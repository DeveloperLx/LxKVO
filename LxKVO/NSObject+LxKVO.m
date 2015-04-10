//
//  DeveloperLx
//  NSObject+LxKVO.m
//

#import "NSObject+LxKVO.h"
#import <objc/runtime.h>
#import <objc/message.h>

static NSString * const CHANGE_DICTIONARY_KEY = @"developerLx.change.dictionary.key";
static NSString * const KVO_CLASS_PREFIX = @"LxKVOSubClassPrefix";

@implementation NSObject (LxKVO)

#pragma mark - assistant

static NSString * getterForSetter(NSString * setter)
{
    NSCAssert([setter hasPrefix:@"set"], @"DeveloperLx: parameter setter format error!");
    NSCAssert([setter hasSuffix:@":"], @"DeveloperLx: parameter setter format error!");
    NSCAssert(setter.length > 4, @"DeveloperLx: parameter setter format error!");
    return [NSString stringWithFormat:@"%@%@", [setter substringWithRange:NSMakeRange(3, 1)].lowercaseString, [setter substringWithRange:NSMakeRange(4, setter.length - 5)]];
}

static NSString * setterForGetter(NSString * getter)
{
    NSCAssert(getter.length > 0, @"DeveloperLx: parameter getter error!");
    return [NSString stringWithFormat:@"set%@%@:", [getter substringToIndex:1].uppercaseString, [getter substringFromIndex:1]];
}

static Class kvo_class(id self, SEL _cmd)
{
    return class_getSuperclass(object_getClass(self));
}

static void kvo_setter(id self, SEL _cmd, id newValue)
{
    NSString * setterName = NSStringFromSelector(_cmd);
    NSCAssert(setterName, @"DeveloperLx: parameter _cmd error!");
    NSString * getterName = getterForSetter(setterName);
    
    id oldValue = [self valueForKey:getterName];
    
    struct objc_super superClass = {
        .receiver = self,
        .super_class = class_getSuperclass(object_getClass(self))
    };
    
    void (*casted_objc_msgSendSuper)(void *, SEL, id) = (void *)objc_msgSendSuper;
    
    casted_objc_msgSendSuper(&superClass, _cmd, newValue);
    
    NSMutableDictionary * changeDictionary = objc_getAssociatedObject(self, (__bridge const void *)(CHANGE_DICTIONARY_KEY));
    ChangeBlock change = (ChangeBlock)(changeDictionary[getterName]);
    if (change) {
        change(oldValue, newValue);
    }
}

#pragma mark - implementation

- (void)observedKeyPath:(NSString *)keyPath withChange:(ChangeBlock)change
{
    NSCAssert([self judgeLegalityOfKeyPath:keyPath], @"DeveloperLx: keyPath: %@ format error!", keyPath);
    
    NSArray * keyPathArray = [keyPath componentsSeparatedByString:@"."];
    if (keyPathArray.count > 1) {
        NSMutableArray * mutableKeyPathArray = [NSMutableArray arrayWithArray:keyPathArray];
        NSString * key = mutableKeyPathArray.lastObject;
        [mutableKeyPathArray removeLastObject];
        NSString * objectPath = [mutableKeyPathArray componentsJoinedByString:@"."];
        NSObject * object = [self valueForKeyPath:objectPath];
        NSCAssert(object, @"DeveloperLx: keyPath: %@ format error!", keyPath);
        [object observedKeyPath:key withChange:change];
        return;
    }
    
    SEL setterSelector = NSSelectorFromString(setterForGetter(keyPath));
    Method setterMethod = class_getInstanceMethod(object_getClass(self), setterSelector);
    NSCAssert(setterMethod, @"DeveloperLx: %@'s keyPath %@ can't be observed!", [self class], keyPath);
    
    Class selfClass = object_getClass(self);
    
    NSString * selfClassName = NSStringFromClass(selfClass);
    if (![selfClassName hasPrefix:KVO_CLASS_PREFIX]) {
        selfClass = [self kvoClass];
        object_setClass(self, selfClass);
    }
    
    if (![self hasSelector:setterSelector]) {
        const char * typeEncoding = method_getTypeEncoding(setterMethod);
        class_addMethod(selfClass, setterSelector, (IMP)kvo_setter, typeEncoding);
    }

    NSMutableDictionary * changeDictionary = objc_getAssociatedObject(self, (__bridge const void *)(CHANGE_DICTIONARY_KEY));
    if (!changeDictionary) {
        changeDictionary = [NSMutableDictionary dictionary];
        objc_setAssociatedObject(self, (__bridge const void *)(CHANGE_DICTIONARY_KEY), changeDictionary, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    [changeDictionary setValue:[change copy] forKey:keyPath];
}

- (void)stopObservedKeyPath:(NSString *)keyPath
{
    NSCAssert([self judgeLegalityOfKeyPath:keyPath], @"DeveloperLx: keyPath: %@ format error!", keyPath);
    
    NSArray * keyPathArray = [keyPath componentsSeparatedByString:@"."];
    if (keyPathArray.count > 1) {
        NSMutableArray * mutableKeyPathArray = [NSMutableArray arrayWithArray:keyPathArray];
        NSString * key = mutableKeyPathArray.lastObject;
        [mutableKeyPathArray removeLastObject];
        NSString * objectPath = [mutableKeyPathArray componentsJoinedByString:@"."];
        NSObject * object = [self valueForKeyPath:objectPath];
        NSCAssert(object, @"DeveloperLx: keyPath: %@ format error!", keyPath);
        [object stopObservedKeyPath:key];
        return;
    }
    
    NSMutableDictionary * changeDictionary = objc_getAssociatedObject(self, (__bridge const void *)(CHANGE_DICTIONARY_KEY));
    [changeDictionary setValue:nil forKey:keyPath];
}

- (BOOL)judgeLegalityOfKeyPath:(NSString *)keyPath
{
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"^[_a-zA-Z]+(\\.[_a-zA-Z][_a-zA-Z0-9]*)*$"];
    return [predicate evaluateWithObject:keyPath];
}

- (Class)kvoClass
{
    Class selfClass = object_getClass(self);
    NSString * selfClassName = NSStringFromClass(selfClass);
    NSString * kvoClassName = [KVO_CLASS_PREFIX stringByAppendingString:selfClassName];
    Class kvoClass = NSClassFromString(kvoClassName);
    if (kvoClass) {
        return kvoClass;
    }
    kvoClass = objc_allocateClassPair(selfClass, kvoClassName.UTF8String, 0);
    
    Method classInstanceMethod = class_getInstanceMethod(selfClass, @selector(class));
    const char * typeEncoding = method_getTypeEncoding(classInstanceMethod);
    class_addMethod(kvoClass, @selector(class), (IMP)kvo_class, typeEncoding);
    objc_registerClassPair(kvoClass);
    return kvoClass;
}

- (BOOL)hasSelector:(SEL)selector
{
    unsigned int methodCount = 0;
    Method * methodList = class_copyMethodList(object_getClass(self), &methodCount);
    for (unsigned int i = 0; i < methodCount; i++) {
        SEL testSelector = method_getName(methodList[i]);
        if (testSelector == selector) {
            free(methodList);
            return YES;
        }
    }
    free(methodList);
    return NO;
}

@end

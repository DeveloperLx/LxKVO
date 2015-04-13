//
//  DeveloperLx
//  NSObject+LxKVO.m
//

#import "NSObject+LxKVO.h"
#import <UIKit/UIKit.h>
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

static void kvo_setter_char(id self, SEL _cmd, char newValue)
{
    NSString * setterName = NSStringFromSelector(_cmd);
    NSCAssert(setterName, @"DeveloperLx: parameter _cmd error!");
    NSString * getterName = getterForSetter(setterName);
    
    id oldValue = [self valueForKey:getterName];
    
    struct objc_super superClass = {
        .receiver = self,
        .super_class = class_getSuperclass(object_getClass(self))
    };
    
    void (*casted_objc_msgSendSuper)(void *, SEL, char) = (void *)objc_msgSendSuper;
    
    casted_objc_msgSendSuper(&superClass, _cmd, newValue);
    
    NSMutableDictionary * changeDictionary = objc_getAssociatedObject(self, (__bridge const void *)(CHANGE_DICTIONARY_KEY));
    ChangeBlock change = (ChangeBlock)(changeDictionary[getterName]);
    if (change) {
        change(oldValue, @(newValue));
    }
}

static void kvo_setter_unsignedChar(id self, SEL _cmd, unsigned char newValue)
{
    NSString * setterName = NSStringFromSelector(_cmd);
    NSCAssert(setterName, @"DeveloperLx: parameter _cmd error!");
    NSString * getterName = getterForSetter(setterName);
    
    id oldValue = [self valueForKey:getterName];
    
    struct objc_super superClass = {
        .receiver = self,
        .super_class = class_getSuperclass(object_getClass(self))
    };
    
    void (*casted_objc_msgSendSuper)(void *, SEL, unsigned char) = (void *)objc_msgSendSuper;
    
    casted_objc_msgSendSuper(&superClass, _cmd, newValue);
    
    NSMutableDictionary * changeDictionary = objc_getAssociatedObject(self, (__bridge const void *)(CHANGE_DICTIONARY_KEY));
    ChangeBlock change = (ChangeBlock)(changeDictionary[getterName]);
    if (change) {
        change(oldValue, @(newValue));
    }
}

static void kvo_setter_short(id self, SEL _cmd, short newValue)
{
    NSString * setterName = NSStringFromSelector(_cmd);
    NSCAssert(setterName, @"DeveloperLx: parameter _cmd error!");
    NSString * getterName = getterForSetter(setterName);
    
    id oldValue = [self valueForKey:getterName];
    
    struct objc_super superClass = {
        .receiver = self,
        .super_class = class_getSuperclass(object_getClass(self))
    };
    
    void (*casted_objc_msgSendSuper)(void *, SEL, short) = (void *)objc_msgSendSuper;
    
    casted_objc_msgSendSuper(&superClass, _cmd, newValue);
    
    NSMutableDictionary * changeDictionary = objc_getAssociatedObject(self, (__bridge const void *)(CHANGE_DICTIONARY_KEY));
    ChangeBlock change = (ChangeBlock)(changeDictionary[getterName]);
    if (change) {
        change(oldValue, @(newValue));
    }
}

static void kvo_setter_unsignedShort(id self, SEL _cmd, unsigned short newValue)
{
    NSString * setterName = NSStringFromSelector(_cmd);
    NSCAssert(setterName, @"DeveloperLx: parameter _cmd error!");
    NSString * getterName = getterForSetter(setterName);
    
    id oldValue = [self valueForKey:getterName];
    
    struct objc_super superClass = {
        .receiver = self,
        .super_class = class_getSuperclass(object_getClass(self))
    };
    
    void (*casted_objc_msgSendSuper)(void *, SEL, unsigned short) = (void *)objc_msgSendSuper;
    
    casted_objc_msgSendSuper(&superClass, _cmd, newValue);
    
    NSMutableDictionary * changeDictionary = objc_getAssociatedObject(self, (__bridge const void *)(CHANGE_DICTIONARY_KEY));
    ChangeBlock change = (ChangeBlock)(changeDictionary[getterName]);
    if (change) {
        change(oldValue, @(newValue));
    }
}

static void kvo_setter_int(id self, SEL _cmd, int newValue)
{
    NSString * setterName = NSStringFromSelector(_cmd);
    NSCAssert(setterName, @"DeveloperLx: parameter _cmd error!");
    NSString * getterName = getterForSetter(setterName);
    
    id oldValue = [self valueForKey:getterName];
    
    struct objc_super superClass = {
        .receiver = self,
        .super_class = class_getSuperclass(object_getClass(self))
    };
    
    void (*casted_objc_msgSendSuper)(void *, SEL, int) = (void *)objc_msgSendSuper;
    
    casted_objc_msgSendSuper(&superClass, _cmd, newValue);
    
    NSMutableDictionary * changeDictionary = objc_getAssociatedObject(self, (__bridge const void *)(CHANGE_DICTIONARY_KEY));
    ChangeBlock change = (ChangeBlock)(changeDictionary[getterName]);
    if (change) {
        change(oldValue, @(newValue));
    }
}

static void kvo_setter_unsignedInt(id self, SEL _cmd, unsigned int newValue)
{
    NSString * setterName = NSStringFromSelector(_cmd);
    NSCAssert(setterName, @"DeveloperLx: parameter _cmd error!");
    NSString * getterName = getterForSetter(setterName);
    
    id oldValue = [self valueForKey:getterName];
    
    struct objc_super superClass = {
        .receiver = self,
        .super_class = class_getSuperclass(object_getClass(self))
    };
    
    void (*casted_objc_msgSendSuper)(void *, SEL, unsigned int) = (void *)objc_msgSendSuper;
    
    casted_objc_msgSendSuper(&superClass, _cmd, newValue);
    
    NSMutableDictionary * changeDictionary = objc_getAssociatedObject(self, (__bridge const void *)(CHANGE_DICTIONARY_KEY));
    ChangeBlock change = (ChangeBlock)(changeDictionary[getterName]);
    if (change) {
        change(oldValue, @(newValue));
    }
}

static void kvo_setter_long(id self, SEL _cmd, long newValue)
{
    NSString * setterName = NSStringFromSelector(_cmd);
    NSCAssert(setterName, @"DeveloperLx: parameter _cmd error!");
    NSString * getterName = getterForSetter(setterName);
    
    id oldValue = [self valueForKey:getterName];
    
    struct objc_super superClass = {
        .receiver = self,
        .super_class = class_getSuperclass(object_getClass(self))
    };
    
    void (*casted_objc_msgSendSuper)(void *, SEL, long) = (void *)objc_msgSendSuper;
    
    casted_objc_msgSendSuper(&superClass, _cmd, newValue);
    
    NSMutableDictionary * changeDictionary = objc_getAssociatedObject(self, (__bridge const void *)(CHANGE_DICTIONARY_KEY));
    ChangeBlock change = (ChangeBlock)(changeDictionary[getterName]);
    if (change) {
        change(oldValue, @(newValue));
    }
}

static void kvo_setter_unsignedLong(id self, SEL _cmd, unsigned long newValue)
{
    NSString * setterName = NSStringFromSelector(_cmd);
    NSCAssert(setterName, @"DeveloperLx: parameter _cmd error!");
    NSString * getterName = getterForSetter(setterName);
    
    id oldValue = [self valueForKey:getterName];
    
    struct objc_super superClass = {
        .receiver = self,
        .super_class = class_getSuperclass(object_getClass(self))
    };
    
    void (*casted_objc_msgSendSuper)(void *, SEL, unsigned long) = (void *)objc_msgSendSuper;
    
    casted_objc_msgSendSuper(&superClass, _cmd, newValue);
    
    NSMutableDictionary * changeDictionary = objc_getAssociatedObject(self, (__bridge const void *)(CHANGE_DICTIONARY_KEY));
    ChangeBlock change = (ChangeBlock)(changeDictionary[getterName]);
    if (change) {
        change(oldValue, @(newValue));
    }
}

static void kvo_setter_longLong(id self, SEL _cmd, long long newValue)
{
    NSString * setterName = NSStringFromSelector(_cmd);
    NSCAssert(setterName, @"DeveloperLx: parameter _cmd error!");
    NSString * getterName = getterForSetter(setterName);
    
    id oldValue = [self valueForKey:getterName];
    
    struct objc_super superClass = {
        .receiver = self,
        .super_class = class_getSuperclass(object_getClass(self))
    };
    
    void (*casted_objc_msgSendSuper)(void *, SEL, long long) = (void *)objc_msgSendSuper;
    
    casted_objc_msgSendSuper(&superClass, _cmd, newValue);
    
    NSMutableDictionary * changeDictionary = objc_getAssociatedObject(self, (__bridge const void *)(CHANGE_DICTIONARY_KEY));
    ChangeBlock change = (ChangeBlock)(changeDictionary[getterName]);
    if (change) {
        change(oldValue, @(newValue));
    }
}

static void kvo_setter_unsignedLongLong(id self, SEL _cmd, unsigned long long newValue)
{
    NSString * setterName = NSStringFromSelector(_cmd);
    NSCAssert(setterName, @"DeveloperLx: parameter _cmd error!");
    NSString * getterName = getterForSetter(setterName);
    
    id oldValue = [self valueForKey:getterName];
    
    struct objc_super superClass = {
        .receiver = self,
        .super_class = class_getSuperclass(object_getClass(self))
    };
    
    void (*casted_objc_msgSendSuper)(void *, SEL, unsigned long long) = (void *)objc_msgSendSuper;
    
    casted_objc_msgSendSuper(&superClass, _cmd, newValue);
    
    NSMutableDictionary * changeDictionary = objc_getAssociatedObject(self, (__bridge const void *)(CHANGE_DICTIONARY_KEY));
    ChangeBlock change = (ChangeBlock)(changeDictionary[getterName]);
    if (change) {
        change(oldValue, @(newValue));
    }
}

static void kvo_setter_float(id self, SEL _cmd, float newValue)
{
    NSString * setterName = NSStringFromSelector(_cmd);
    NSCAssert(setterName, @"DeveloperLx: parameter _cmd error!");
    NSString * getterName = getterForSetter(setterName);
    
    id oldValue = [self valueForKey:getterName];
    
    struct objc_super superClass = {
        .receiver = self,
        .super_class = class_getSuperclass(object_getClass(self))
    };
    
    void (*casted_objc_msgSendSuper)(void *, SEL, float) = (void *)objc_msgSendSuper;
    
    casted_objc_msgSendSuper(&superClass, _cmd, newValue);
    
    NSMutableDictionary * changeDictionary = objc_getAssociatedObject(self, (__bridge const void *)(CHANGE_DICTIONARY_KEY));
    ChangeBlock change = (ChangeBlock)(changeDictionary[getterName]);
    if (change) {
        change(oldValue, @(newValue));
    }
}

static void kvo_setter_double(id self, SEL _cmd, double newValue)
{
    NSString * setterName = NSStringFromSelector(_cmd);
    NSCAssert(setterName, @"DeveloperLx: parameter _cmd error!");
    NSString * getterName = getterForSetter(setterName);
    
    id oldValue = [self valueForKey:getterName];
    
    struct objc_super superClass = {
        .receiver = self,
        .super_class = class_getSuperclass(object_getClass(self))
    };
    
    void (*casted_objc_msgSendSuper)(void *, SEL, double) = (void *)objc_msgSendSuper;
    
    casted_objc_msgSendSuper(&superClass, _cmd, newValue);
    
    NSMutableDictionary * changeDictionary = objc_getAssociatedObject(self, (__bridge const void *)(CHANGE_DICTIONARY_KEY));
    ChangeBlock change = (ChangeBlock)(changeDictionary[getterName]);
    if (change) {
        change(oldValue, @(newValue));
    }
}

static void kvo_setter_object(id self, SEL _cmd, id newValue)
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

static void kvo_setter_bool(id self, SEL _cmd, bool newValue)
{
    NSString * setterName = NSStringFromSelector(_cmd);
    NSCAssert(setterName, @"DeveloperLx: parameter _cmd error!");
    NSString * getterName = getterForSetter(setterName);
    
    id oldValue = [self valueForKey:getterName];
    
    struct objc_super superClass = {
        .receiver = self,
        .super_class = class_getSuperclass(object_getClass(self))
    };
    
    void (*casted_objc_msgSendSuper)(void *, SEL, bool) = (void *)objc_msgSendSuper;
    
    casted_objc_msgSendSuper(&superClass, _cmd, newValue);
    
    NSMutableDictionary * changeDictionary = objc_getAssociatedObject(self, (__bridge const void *)(CHANGE_DICTIONARY_KEY));
    ChangeBlock change = (ChangeBlock)(changeDictionary[getterName]);
    if (change) {
        change(oldValue, @(newValue));
    }
}

static void kvo_setter_point(id self, SEL _cmd, CGPoint newValue)
{
    NSString * setterName = NSStringFromSelector(_cmd);
    NSCAssert(setterName, @"DeveloperLx: parameter _cmd error!");
    NSString * getterName = getterForSetter(setterName);
    
    id oldValue = [self valueForKey:getterName];
    
    struct objc_super superClass = {
        .receiver = self,
        .super_class = class_getSuperclass(object_getClass(self))
    };
    
    void (*casted_objc_msgSendSuper)(void *, SEL, CGPoint) = (void *)objc_msgSendSuper;
    
    casted_objc_msgSendSuper(&superClass, _cmd, newValue);
    
    NSMutableDictionary * changeDictionary = objc_getAssociatedObject(self, (__bridge const void *)(CHANGE_DICTIONARY_KEY));
    ChangeBlock change = (ChangeBlock)(changeDictionary[getterName]);
    if (change) {
        change(oldValue, [NSValue valueWithCGPoint:newValue]);
    }
}

static void kvo_setter_size(id self, SEL _cmd, CGSize newValue)
{
    NSString * setterName = NSStringFromSelector(_cmd);
    NSCAssert(setterName, @"DeveloperLx: parameter _cmd error!");
    NSString * getterName = getterForSetter(setterName);
    
    id oldValue = [self valueForKey:getterName];
    
    struct objc_super superClass = {
        .receiver = self,
        .super_class = class_getSuperclass(object_getClass(self))
    };
    
    void (*casted_objc_msgSendSuper)(void *, SEL, CGSize) = (void *)objc_msgSendSuper;
    
    casted_objc_msgSendSuper(&superClass, _cmd, newValue);
    
    NSMutableDictionary * changeDictionary = objc_getAssociatedObject(self, (__bridge const void *)(CHANGE_DICTIONARY_KEY));
    ChangeBlock change = (ChangeBlock)(changeDictionary[getterName]);
    if (change) {
        change(oldValue, [NSValue valueWithCGSize:newValue]);
    }
}

static void kvo_setter_rect(id self, SEL _cmd, CGRect newValue)
{
    NSString * setterName = NSStringFromSelector(_cmd);
    NSCAssert(setterName, @"DeveloperLx: parameter _cmd error!");
    NSString * getterName = getterForSetter(setterName);
    
    id oldValue = [self valueForKey:getterName];
    
    struct objc_super superClass = {
        .receiver = self,
        .super_class = class_getSuperclass(object_getClass(self))
    };
    
    void (*casted_objc_msgSendSuper)(void *, SEL, CGRect) = (void *)objc_msgSendSuper;
    
    casted_objc_msgSendSuper(&superClass, _cmd, newValue);
    
    NSMutableDictionary * changeDictionary = objc_getAssociatedObject(self, (__bridge const void *)(CHANGE_DICTIONARY_KEY));
    ChangeBlock change = (ChangeBlock)(changeDictionary[getterName]);
    if (change) {
        change(oldValue, [NSValue valueWithCGRect:newValue]);
    }
}

static void kvo_setter_edgeInsets(id self, SEL _cmd, UIEdgeInsets newValue)
{
    NSString * setterName = NSStringFromSelector(_cmd);
    NSCAssert(setterName, @"DeveloperLx: parameter _cmd error!");
    NSString * getterName = getterForSetter(setterName);
    
    id oldValue = [self valueForKey:getterName];
    
    struct objc_super superClass = {
        .receiver = self,
        .super_class = class_getSuperclass(object_getClass(self))
    };
    
    void (*casted_objc_msgSendSuper)(void *, SEL, UIEdgeInsets) = (void *)objc_msgSendSuper;
    
    casted_objc_msgSendSuper(&superClass, _cmd, newValue);
    
    NSMutableDictionary * changeDictionary = objc_getAssociatedObject(self, (__bridge const void *)(CHANGE_DICTIONARY_KEY));
    ChangeBlock change = (ChangeBlock)(changeDictionary[getterName]);
    if (change) {
        change(oldValue, [NSValue valueWithUIEdgeInsets:newValue]);
    }
}

static void kvo_setter_offset(id self, SEL _cmd, UIOffset newValue)
{
    NSString * setterName = NSStringFromSelector(_cmd);
    NSCAssert(setterName, @"DeveloperLx: parameter _cmd error!");
    NSString * getterName = getterForSetter(setterName);
    
    id oldValue = [self valueForKey:getterName];
    
    struct objc_super superClass = {
        .receiver = self,
        .super_class = class_getSuperclass(object_getClass(self))
    };
    
    void (*casted_objc_msgSendSuper)(void *, SEL, UIOffset) = (void *)objc_msgSendSuper;
    
    casted_objc_msgSendSuper(&superClass, _cmd, newValue);
    
    NSMutableDictionary * changeDictionary = objc_getAssociatedObject(self, (__bridge const void *)(CHANGE_DICTIONARY_KEY));
    ChangeBlock change = (ChangeBlock)(changeDictionary[getterName]);
    if (change) {
        change(oldValue, [NSValue valueWithUIOffset:newValue]);
    }
}

static void kvo_setter_affineTransform(id self, SEL _cmd, CGAffineTransform newValue)
{
    NSString * setterName = NSStringFromSelector(_cmd);
    NSCAssert(setterName, @"DeveloperLx: parameter _cmd error!");
    NSString * getterName = getterForSetter(setterName);
    
    id oldValue = [self valueForKey:getterName];
    
    struct objc_super superClass = {
        .receiver = self,
        .super_class = class_getSuperclass(object_getClass(self))
    };
    
    void (*casted_objc_msgSendSuper)(void *, SEL, CGAffineTransform) = (void *)objc_msgSendSuper;
    
    casted_objc_msgSendSuper(&superClass, _cmd, newValue);
    
    NSMutableDictionary * changeDictionary = objc_getAssociatedObject(self, (__bridge const void *)(CHANGE_DICTIONARY_KEY));
    ChangeBlock change = (ChangeBlock)(changeDictionary[getterName]);
    if (change) {
        change(oldValue, [NSValue valueWithCGAffineTransform:newValue]);
    }
}

static void kvo_setter_transform3D(id self, SEL _cmd, CATransform3D newValue)
{
    NSString * setterName = NSStringFromSelector(_cmd);
    NSCAssert(setterName, @"DeveloperLx: parameter _cmd error!");
    NSString * getterName = getterForSetter(setterName);
    
    id oldValue = [self valueForKey:getterName];
    
    struct objc_super superClass = {
        .receiver = self,
        .super_class = class_getSuperclass(object_getClass(self))
    };
    
    void (*casted_objc_msgSendSuper)(void *, SEL, CATransform3D) = (void *)objc_msgSendSuper;
    
    casted_objc_msgSendSuper(&superClass, _cmd, newValue);
    
    NSMutableDictionary * changeDictionary = objc_getAssociatedObject(self, (__bridge const void *)(CHANGE_DICTIONARY_KEY));
    ChangeBlock change = (ChangeBlock)(changeDictionary[getterName]);
    if (change) {
        change(oldValue, [NSValue valueWithCATransform3D:newValue]);
    }
}

static void kvo_setter_pointer(id self, SEL _cmd, const void * newValue)
{
    NSString * setterName = NSStringFromSelector(_cmd);
    NSCAssert(setterName, @"DeveloperLx: parameter _cmd error!");
    NSString * getterName = getterForSetter(setterName);
    
    id oldValue = [self valueForKey:getterName];
    
    struct objc_super superClass = {
        .receiver = self,
        .super_class = class_getSuperclass(object_getClass(self))
    };
    
    void (*casted_objc_msgSendSuper)(void *, SEL, const void *) = (void *)objc_msgSendSuper;
    
    casted_objc_msgSendSuper(&superClass, _cmd, newValue);
    
    NSMutableDictionary * changeDictionary = objc_getAssociatedObject(self, (__bridge const void *)(CHANGE_DICTIONARY_KEY));
    ChangeBlock change = (ChangeBlock)(changeDictionary[getterName]);
    if (change) {
        change(oldValue, [NSValue valueWithPointer:newValue]);
    }
}

static void kvo_setter_range(id self, SEL _cmd, NSRange newValue)
{
    NSString * setterName = NSStringFromSelector(_cmd);
    NSCAssert(setterName, @"DeveloperLx: parameter _cmd error!");
    NSString * getterName = getterForSetter(setterName);
    
    id oldValue = [self valueForKey:getterName];
    
    struct objc_super superClass = {
        .receiver = self,
        .super_class = class_getSuperclass(object_getClass(self))
    };
    
    void (*casted_objc_msgSendSuper)(void *, SEL, NSRange) = (void *)objc_msgSendSuper;
    
    casted_objc_msgSendSuper(&superClass, _cmd, newValue);
    
    NSMutableDictionary * changeDictionary = objc_getAssociatedObject(self, (__bridge const void *)(CHANGE_DICTIONARY_KEY));
    ChangeBlock change = (ChangeBlock)(changeDictionary[getterName]);
    if (change) {
        change(oldValue, [NSValue valueWithRange:newValue]);
    }
}

const char * setterValueTypeEncodingFor(const char * setterTypeEncoding)
{
    NSString * setterTypeEncodingOCString = [NSString stringWithUTF8String:setterTypeEncoding];
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"^v\\d{2}@0:[48].+(8|16)$"];
    NSCAssert([predicate evaluateWithObject:setterTypeEncodingOCString], @"DeveloperLx: setterTypeEncoding: %@ format error!", setterTypeEncodingOCString);
    for (NSInteger i = setterTypeEncodingOCString.length - 1; i >= 0; i--) {
        if ([setterTypeEncodingOCString characterAtIndex:i] < '0' || [setterTypeEncodingOCString characterAtIndex:i] > '9') {
            return [setterTypeEncodingOCString substringWithRange:NSMakeRange(7, i - 6)].UTF8String;
        }
    }
    return NULL;
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
        const char * setterValueTypeEncoding = setterValueTypeEncodingFor(typeEncoding);
        
        if (strcmp(setterValueTypeEncoding, @encode(char)) == 0) {
            class_addMethod(selfClass, setterSelector, (IMP)kvo_setter_char, typeEncoding);
        }
        else if (strcmp(setterValueTypeEncoding, @encode(unsigned char)) == 0) {
            class_addMethod(selfClass, setterSelector, (IMP)kvo_setter_unsignedChar, typeEncoding);
        }
        else if (strcmp(setterValueTypeEncoding, @encode(short)) == 0) {
            class_addMethod(selfClass, setterSelector, (IMP)kvo_setter_short, typeEncoding);
        }
        else if (strcmp(setterValueTypeEncoding, @encode(unsigned short)) == 0) {
            class_addMethod(selfClass, setterSelector, (IMP)kvo_setter_unsignedShort, typeEncoding);
        }
        else if (strcmp(setterValueTypeEncoding, @encode(int)) == 0) {
            class_addMethod(selfClass, setterSelector, (IMP)kvo_setter_int, typeEncoding);
        }
        else if (strcmp(setterValueTypeEncoding, @encode(unsigned int)) == 0) {
            class_addMethod(selfClass, setterSelector, (IMP)kvo_setter_unsignedInt, typeEncoding);
        }
        else if (strcmp(setterValueTypeEncoding, @encode(long)) == 0) {
            class_addMethod(selfClass, setterSelector, (IMP)kvo_setter_long, typeEncoding);
        }
        else if (strcmp(setterValueTypeEncoding, @encode(unsigned long)) == 0) {
            class_addMethod(selfClass, setterSelector, (IMP)kvo_setter_unsignedLong, typeEncoding);
        }
        else if (strcmp(setterValueTypeEncoding, @encode(long long)) == 0) {
            class_addMethod(selfClass, setterSelector, (IMP)kvo_setter_longLong, typeEncoding);
        }
        else if (strcmp(setterValueTypeEncoding, @encode(unsigned long long)) == 0) {
            class_addMethod(selfClass, setterSelector, (IMP)kvo_setter_unsignedLongLong, typeEncoding);
        }
        else if (strcmp(setterValueTypeEncoding, @encode(float)) == 0) {
            class_addMethod(selfClass, setterSelector, (IMP)kvo_setter_float, typeEncoding);
        }
        else if (strcmp(setterValueTypeEncoding, @encode(double)) == 0) {
            class_addMethod(selfClass, setterSelector, (IMP)kvo_setter_double, typeEncoding);
        }
        else if (strcmp(setterValueTypeEncoding, @encode(id)) == 0) {
            class_addMethod(selfClass, setterSelector, (IMP)kvo_setter_object, typeEncoding);
        }
        else if (strcmp(setterValueTypeEncoding, @encode(bool)) == 0) {
            class_addMethod(selfClass, setterSelector, (IMP)kvo_setter_bool, typeEncoding);
        }
        else if (strcmp(setterValueTypeEncoding, @encode(CGPoint)) == 0) {
            class_addMethod(selfClass, setterSelector, (IMP)kvo_setter_point, typeEncoding);
        }
        else if (strcmp(setterValueTypeEncoding, @encode(CGSize)) == 0) {
            class_addMethod(selfClass, setterSelector, (IMP)kvo_setter_size, typeEncoding);
        }
        else if (strcmp(setterValueTypeEncoding, @encode(CGRect)) == 0) {
            class_addMethod(selfClass, setterSelector, (IMP)kvo_setter_rect, typeEncoding);
        }
        else if (strcmp(setterValueTypeEncoding, @encode(UIEdgeInsets)) == 0) {
            class_addMethod(selfClass, setterSelector, (IMP)kvo_setter_edgeInsets, typeEncoding);
        }
        else if (strcmp(setterValueTypeEncoding, @encode(UIOffset)) == 0) {
            class_addMethod(selfClass, setterSelector, (IMP)kvo_setter_offset, typeEncoding);
        }
        else if (strcmp(setterValueTypeEncoding, @encode(CGAffineTransform)) == 0) {
            class_addMethod(selfClass, setterSelector, (IMP)kvo_setter_affineTransform, typeEncoding);
        }
        else if (strcmp(setterValueTypeEncoding, @encode(CATransform3D)) == 0) {
            class_addMethod(selfClass, setterSelector, (IMP)kvo_setter_transform3D, typeEncoding);
        }
        else if (strcmp(setterValueTypeEncoding, @encode(const void *)) == 0) {
            class_addMethod(selfClass, setterSelector, (IMP)kvo_setter_pointer, typeEncoding);
        }
        else if (strcmp(setterValueTypeEncoding, @encode(NSRange)) == 0) {
            class_addMethod(selfClass, setterSelector, (IMP)kvo_setter_range, typeEncoding);
        }
        else {
            NSCAssert(NO, @"DeveloperLx: Can't observe this type of value.");
        }
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

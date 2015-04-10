//
//  DeveloperLx
//  NSObject+LxKVO.h
//

#import <Foundation/Foundation.h>

typedef void (^ChangeBlock)(id oldValue, id newValue);

#define OBJECT_KEYPATH(object, keyPath)     [NSString stringWithUTF8String:(((void)(NO&&((void)object.keyPath,NO)), #keyPath))]
#define LxKVO(object, keyPath, changeBlock) [object observedKeyPath:OBJECT_KEYPATH(object, keyPath) withChange:changeBlock]
#define LxStopKVO(object, keyPath)          [object stopObservedKeyPath:OBJECT_KEYPATH(object, keyPath)]

@interface NSObject (LxKVO)

- (void)observedKeyPath:(NSString *)keyPath withChange:(ChangeBlock)change;
- (void)stopObservedKeyPath:(NSString *)keyPath;

@end

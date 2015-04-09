//
//  DeveloperLx
//  NSObject+LxKVO.h
//

#import <Foundation/Foundation.h>

typedef void (^ChangeBlock)(id oldValue, id newValue);

@interface NSObject (LxKVO)

- (void)observedKey:(NSString *)key withChange:(ChangeBlock)change;
- (void)stopObservedKey:(NSString *)key;

@end

//
//  ViewController.m
//  LxKVODemo
//

#import "ViewController.h"
#import "NSObject+LxKVO.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    LxKVO(self, view.tintColor, ^(id oldValue, id newValue) {
        NSLog(@"view.tintColor:[%@->%@]", oldValue, newValue);  //
    });
    LxKVO(self.view, alpha, ^(id oldValue, id newValue) {
        NSLog(@"alpha:[%@->%@]", oldValue, newValue);  //
    });
//    or
//    [self observedKeyPath:@"view.tintColor" withChange:^(id oldValue, id newValue) {
//        NSLog(@"view.tintColor:[%@->%@]", oldValue, newValue);  //
//    }];
//    [self.view observedKeyPath:@"alpha" withChange:^(id oldValue, id newValue) {
//        NSLog(@"alpha:[%@->%@]", oldValue, newValue);  //
//    }];
    
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timer1:) userInfo:nil repeats:YES];
    [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(timer3:) userInfo:nil repeats:YES];
}

- (void)timer1:(NSTimer *)timer
{
    self.view.tintColor = [UIColor colorWithWhite:(arc4random()%256/255.0) alpha:1];
}

- (void)timer3:(NSTimer *)timer
{
    self.view.alpha = (arc4random()%10/10.0);
    
    LxStopKVO(self, view.tintColor);
//    or
//    [self stopObservedKeyPath:@"view.tintColor"];
}

@end

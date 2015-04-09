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

    [self.view observedKey:@"tintColor" withChange:^(id oldValue, id newValue) {
        NSLog(@"tintColor:[%@->%@]", oldValue, newValue);  //
    }];
    [self.view observedKey:@"backgroundColor" withChange:^(id oldValue, id newValue) {
        NSLog(@"backgroundColor:[%@->%@]", oldValue, newValue);  //
    }];
    
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timer1:) userInfo:nil repeats:YES];
    [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(timer2:) userInfo:nil repeats:YES];
}

- (void)timer1:(NSTimer *)timer
{
    self.view.tintColor = [UIColor colorWithWhite:(arc4random()%256/255.0) alpha:1];
}

- (void)timer2:(NSTimer *)timer
{
    self.view.backgroundColor = [UIColor colorWithWhite:(arc4random()%256/255.0) alpha:1];
}

@end

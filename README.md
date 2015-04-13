# LxKVO
    A convenient KVO implementation.
Installation
------------
    You only need drag NSObject+LxKVO.h and NSObject+LxKVO.m to your project.
Support
------------
    Minimum support iOS version: iOS 6.0
Usage
----------
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
License
-----------
    LxKVO is available under the Apache License 2.0. See the LICENSE file for more info.

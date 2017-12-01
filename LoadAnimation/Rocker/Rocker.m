//
//  Rocker.m
//  LoadAnimation
//
//  Created by Yehua Gao on 2017/11/29.
//  Copyright © 2017年 Yehua Gao. All rights reserved.
//

#import "Rocker.h"
#import "RockerView.h"


@interface Rocker ()<RockerViewDelegate>

@property (nonatomic,strong) RockerView *rockerView;

@end

@implementation Rocker

- (RockerView *)rockerView{
    if (!_rockerView) {
        _rockerView = [RockerView rockerView];
        _rockerView.delegate = self;
    }
    return _rockerView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self rockerViewAnimation];
}

/**
 摇杆
 */
- (void)rockerViewAnimation{
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.rockerView];
    self.rockerView.center = self.view.center;
}

#pragma mark - RockerViewDelegate
- (void)rockerView:(RockerView *)rocker rockTowards:(RockTowardType)towardType{
    switch (towardType) {
        case RockTowardStop:{
            NSLog(@"停止");
        }
            break;
        case RockTowardUp:{
            NSLog(@"up");
        }
            break;
            
        case RockTowardUpAndRight:{
            NSLog(@"up and right");
        }
            break;
            
        case RockTowardRight:{
            NSLog(@"right");
        }
            break;
            
        case RockTowardDownAndRight:{
            NSLog(@"down and right");
        }
            break;
            
        case RockTowardDown:{
            NSLog(@"down");
        }
            break;
            
        case RockTowardDownAndLeft:{
            NSLog(@"down and left");
        }
            break;
            
        case RockTowardLeft:{
            NSLog(@"left");
        }
            break;
        case RockTowardUpAndLeft:{
            NSLog(@"up and left");
        }
            break;
            
        default:
            break;
    }
}

- (void)dealloc{
    NSLog(@"Rocker dealloc");
}
@end

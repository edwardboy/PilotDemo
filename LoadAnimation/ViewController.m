//
//  ViewController.m
//  LoadAnimation
//
//  Created by Yehua Gao on 2017/11/16.
//  Copyright © 2017年 Yehua Gao. All rights reserved.
//

#import "ViewController.h"
#import "LoadAnimateView.h"
#import "RockerView.h"

@interface ViewController ()

@property (nonatomic,strong) LoadAnimateView *animateView;
@property (nonatomic,strong) RockerView *rockerView;

@end

@implementation ViewController

- (RockerView *)rockerView{
    if (!_rockerView) {
        _rockerView = [RockerView rockerView];
    }
    return _rockerView;
}

- (LoadAnimateView *)animateView{
    if (!_animateView) {
        _animateView = [[LoadAnimateView alloc]initWithFrame:CGRectMake(0, 0, 200, 200)];;
        UIView *view = [UIApplication sharedApplication].delegate.window;
        [view addSubview:_animateView];
        _animateView.center = view.center;
    }
    return _animateView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self planetAnimation];
    
    [self rockerViewAnimation];
    
}


/**
 摇杆
 */
- (void)rockerViewAnimation{
    [self.view addSubview:self.rockerView];
    self.rockerView.center = self.view.center;
}

#pragma mark - RockerViewDelegate
- (void)rockerView:(RockerView *)rocker rockTowards:(RockTowardType)towardType{
    NSLog(@"towardType-%ld",(long)towardType);
    
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

/**
 动画
 */
- (void)planetAnimation{
    //  VC中自定义控件命名为loadView时，会重复加载init方法
    LoadAnimateView *animateView = [[LoadAnimateView alloc]initWithFrame:CGRectMake(0, 0, 200, 200)];
    _animateView = animateView;
    [self.view addSubview:animateView];
    animateView.center = self.view.center;
}

- (IBAction)start:(UIBarButtonItem *)sender {
    [self.animateView startAnimate];
}
- (IBAction)stop:(id)sender {
    [_animateView stopAnimate];
    _animateView = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

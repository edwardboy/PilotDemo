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

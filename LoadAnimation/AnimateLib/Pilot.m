//
//  Pilot.m
//  LoadAnimation
//
//  Created by Yehua Gao on 2017/11/29.
//  Copyright © 2017年 Yehua Gao. All rights reserved.
//

#import "Pilot.h"
#import "LoadAnimateView.h"

@interface Pilot ()

@property (nonatomic,strong) LoadAnimateView *animateView;

@end

@implementation Pilot

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
    
    [self planetAnimation];
}

/**
 动画
 */
- (void)planetAnimation{
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *startItem = [[UIBarButtonItem alloc]initWithTitle:@"Start" style:UIBarButtonItemStyleDone target:self action:@selector(start:)];
    UIBarButtonItem *stopItem = [[UIBarButtonItem alloc]initWithTitle:@"Stop" style:UIBarButtonItemStyleDone target:self action:@selector(stop:)];
    self.navigationItem.rightBarButtonItems = @[stopItem,startItem];
    
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

- (void)dealloc{
    [_animateView stopAnimate];
}

@end

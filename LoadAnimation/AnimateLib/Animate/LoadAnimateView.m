//
//  LoadAnimateView.m
//  LoadAnimation
//
//  Created by Yehua Gao on 2017/11/16.
//  Copyright © 2017年 Yehua Gao. All rights reserved.
//

#import "LoadAnimateView.h"
#import "YYWeakProxy.h"
#import "Masonry.h"

@interface LoadAnimateView()<CAAnimationDelegate>
{
    NSTimer *_timer; // 螺旋桨、云
    NSTimer *_planeTimer;    // 飞机
}
@property (nonatomic,weak) UIImageView *planeImgView;
@property (nonatomic,weak) UIImageView *propellerImgView;

@end

@implementation LoadAnimateView

- (instancetype)init{
    if (self = [super init]) {
        
//        NSLog(@"%s",__func__);
        [self setupView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
//        NSLog(@"%s",__func__);
        [self setupView];
    }
    return self;
}


/**
 初始化界面
 */
- (void)setupView{
    
    self.backgroundColor = [UIColor clearColor];
    self.clipsToBounds = YES;
    
    UIImageView *planeImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"plane"]];
    _planeImgView = planeImgView;
    planeImgView.frame = CGRectMake(0, 0, 127.5, 101);
    planeImgView.center = self.center;
    [self addSubview:planeImgView];
    
//    [planeImgView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.center.equalTo(self);
//        make.width.equalTo(@127.5);
//        make.height.equalTo(@101);
//    }];
    
    UIImageView *propellerImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"propeller"]];
    _propellerImgView = propellerImgView;
    [self addSubview:propellerImgView];
    
    propellerImgView.frame = CGRectMake(planeImgView.frame.origin.x - 41.5 + 22, planeImgView.center.y - 37/2, 41.5, 37);
//    [propellerImgView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(planeImgView).offset(2);
//        make.right.equalTo(planeImgView.mas_left).offset(22);
//        make.width.equalTo(@41.5);
//        make.height.equalTo(@37);
//    }];
    
    [self bringSubviewToFront:planeImgView];
    
    // 旋转
    CATransform3D transform = CATransform3DMakeRotation(M_PI_4, 0, 1, 0);
    propellerImgView.layer.transform = transform;
    
    
    _timer = [NSTimer timerWithTimeInterval:1/60 target:[YYWeakProxy proxyWithTarget:self] selector:@selector(fastAnimate) userInfo:nil repeats:YES];
    _planeTimer = [NSTimer timerWithTimeInterval:1 target:[YYWeakProxy proxyWithTarget:self] selector:@selector(slowAnimate) userInfo:nil repeats:YES];
    
    [self startAnimate];
}

/**
 螺旋桨
 */
- (void)fastAnimate{
    //  螺旋桨旋转
    [UIView animateWithDuration:1/60 animations:^{
        _propellerImgView.layer.transform = CATransform3DRotate(_propellerImgView.layer.transform, M_PI/180 , 0, 0, 1);
    }];
    
}

/**
 cloud
 */
- (void)slowAnimate{
    NSString *cloud;
    if ([cloud isEqualToString:@"cloud_g"]) {
        cloud = @"cloud_l";
    }else {
        cloud = @"cloud_g";
    }
    
    CGFloat height = 20;
    CGFloat y = arc4random() % (int)(self.bounds.size.height - height);
    
    UIImageView *cloudImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:cloud]];
    cloudImgView.frame = CGRectMake(-40, y, 40, height);
    [self addSubview:cloudImgView];
    
    CGFloat endX = self.bounds.size.width;
    
    if ([cloud isEqualToString:@"cloud_g"]) {
        [self bringSubviewToFront:cloudImgView];
    }
    
    [UIView animateWithDuration:2 animations:^{
        cloudImgView.frame = CGRectMake(endX + 40, y, 40, height);
        cloudImgView.alpha = 0.3;
    } completion:^(BOOL finished) {
        if (finished){
            [cloudImgView removeFromSuperview];
        }
    }];
}

/**
 开始动画
 */
- (void)startAnimate{
    
    [self setFrameAnimationWithView:_planeImgView];
    [self setFrameAnimationWithView:_propellerImgView];
    
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    [[NSRunLoop currentRunLoop] addTimer:_planeTimer forMode:NSRunLoopCommonModes];
    
}

- (void)setFrameAnimationWithView:(UIView *)view{
    CGPoint startPoint = view.layer.position;
    CAKeyframeAnimation *frameAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    NSValue *startValue = [NSValue valueWithCGPoint:startPoint];
    NSValue *topValue = [NSValue valueWithCGPoint:CGPointMake(startPoint.x,startPoint.y - 10)];
    NSValue *bottomValue = [NSValue valueWithCGPoint:CGPointMake(startPoint.x,startPoint.y + 10)];
    frameAnimation.duration = 1;
    frameAnimation.timingFunction =[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    frameAnimation.repeatCount = MAXFLOAT;
    frameAnimation.removedOnCompletion = NO;
    frameAnimation.autoreverses = YES;
    frameAnimation.values = @[topValue,startValue,bottomValue];
    frameAnimation.fillMode = kCAFillModeForwards;
    frameAnimation.delegate = self;
    [view.layer addAnimation:frameAnimation forKey:@"animation"];
}

- (void)layoutSubviews{
    
}

- (void)animationDidStart:(CAAnimation *)anim;{
    NSLog(@"%s",__func__);
}

/* Called when the animation either completes its active duration or
 * is removed from the object it is attached to (i.e. the layer). 'flag'
 * is true if the animation reached the end of its active duration
 * without being removed. */

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag;{
    NSLog(@"%s",__func__);
}

/**
 停止动画
 */
- (void)stopAnimate{
    [_timer invalidate];
    [_planeTimer invalidate];
    
    [_planeImgView.layer removeAllAnimations];
    [_propellerImgView.layer removeAllAnimations];
    
    [self removeFromSuperview];
}

- (void)dealloc{
#ifdef DEBUG
    NSLog(@"%s",__func__);
#endif
}

@end

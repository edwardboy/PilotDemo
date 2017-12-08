//
//  RockerView.m
//  LoadAnimation
//
//  Created by Yehua Gao on 2017/11/28.
//  Copyright © 2017年 Yehua Gao. All rights reserved.
//

#import "RockerView.h"

@interface RockerView ()
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *arrowImgViews;
@property (weak, nonatomic) IBOutlet UIImageView *centerImgView;
@property (weak, nonatomic) IBOutlet UIImageView *bgImgView;

@property (nonatomic,strong) UIImageView *selectImgView;

@end

@implementation RockerView

+ (instancetype)rockerView{
    return [[[NSBundle mainBundle] loadNibNamed:@"RockerView" owner:nil options:nil] firstObject];
}

- (void)awakeFromNib{
    [super awakeFromNib];
    
    [self bringSubviewToFront:self.centerImgView];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(dragCenter:)];
    [_centerImgView addGestureRecognizer:pan];
    
    _centerImgView.userInteractionEnabled = YES;
}

- (void)recover{
    [UIView animateWithDuration:0.2 animations:^{
        _centerImgView.center = self.bgImgView.center;
        self.selectImgView = nil;
    }];
}

- (void)setSelectImgView:(UIImageView *)selectImgView{
    _selectImgView.hidden = YES;
    selectImgView.hidden = NO;
    _selectImgView = selectImgView;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(rockerView:rockTowards:)]) {
        [self.delegate rockerView:self rockTowards:selectImgView.tag];
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    UIView *v = [self viewWithTag:14];
    v.frame = CGRectMake(61, 127, 76, 71);
}

- (void)dragCenter:(UIPanGestureRecognizer *)sender{
    /*
     拖动过程中需要注意：
     1、中心点范围
     2、centerImg的中心位置检测，即所处在的区域
     */
    if (sender.state == UIGestureRecognizerStateBegan || sender.state == UIGestureRecognizerStateChanged){
        CGFloat circleRadius = self.bounds.size.width / 2; // 转盘半径
        
        CGPoint p = [sender locationInView:self.bgImgView];   // 当前触摸点
        
        //  计算当前触摸点到圆心连线与X正方向形成的角度
        CGPoint pCenter = self.bgImgView.center;    // 圆心
        
        float angle = atan2f(p.x - pCenter.x, p.y - pCenter.y);
        
        NSLog(@"angle:%.2f",180.0/ M_PI * angle);
        
        NSInteger tag = 0;
        
        if (-M_PI/8 < angle && angle <= M_PI/8){    // e
            tag = 14;
        }else if (M_PI/8 < angle && angle <= M_PI*3/8){ //d
            tag = 13;
        }else if (M_PI*3/8 < angle && angle <= M_PI*5/8){   // c
            tag = 12;
        }else if (M_PI*5/8 < angle && angle <= M_PI*7/8){   // b
            tag = 11;
        }else if (-M_PI*3/8 < angle && angle <= -M_PI/8){   // f
            tag = 15;
        }else if (-M_PI*5/8 < angle && angle <= -M_PI*3/8){   // g
            tag = 16;
        }else if (-M_PI*7/8 < angle && angle <= -M_PI*5/8){   // h
            tag = 17;
        }else { // a
            tag = 10;
        }
        self.selectImgView = [self viewWithTag:tag];
        
        
        p.x-=circleRadius;
        p.y-=circleRadius;
        
        CGFloat s = sqrtf(p.x*p.x + p.y*p.y);
        CGFloat ts = s/circleRadius;
        if (ts>1) {
            p.x/=ts;
            p.y/=ts;
        }
        
        p.x/=circleRadius;
        p.y/=circleRadius;
        
        _centerImgView.center = CGPointMake(p.x*circleRadius + circleRadius, p.y*circleRadius + circleRadius);

    }else if (sender.state == UIGestureRecognizerStateEnded || sender.state == UIGestureRecognizerStateCancelled) {
        [self recover];
    }
}

- (void)dealloc{
    NSLog(@"Rocker View dealloc");
}

@end

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
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGPoint p = [touches.anyObject locationInView:self];
    p.x-=self.bounds.size.width/2;
    p.y-=self.bounds.size.width/2;
    
    CGFloat s = sqrtf(p.x*p.x + p.y*p.y);
    
    CGFloat ts = s/(self.bounds.size.width/2);
    if (ts>1) {
        p.x/=ts;
        p.y/=ts;
    }
    
    p.x/=self.bounds.size.width/2;
    p.y/=self.bounds.size.width/2;
    
    _centerImgView.center = CGPointMake(p.x*self.bounds.size.width/2 + self.bounds.size.width/2, p.y*self.bounds.size.width/2 + self.bounds.size.width/2);
    
    for (UIImageView *imgView in self.arrowImgViews) {
        if (CGRectContainsPoint(imgView.frame, _centerImgView.center)) {
            self.selectImgView = imgView;
        }
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self recover];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self recover];
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
    
    switch (selectImgView.tag) {
        case 10:{
            NSLog(@"up");
        }
            break;
            
        case 11:{
            NSLog(@"up and right");
        }
            break;
            
        case 12:{
            NSLog(@"right");
        }
            break;
            
        case 13:{
            NSLog(@"down and right");
        }
            break;
            
        case 14:{
            NSLog(@"down");
        }
            break;
            
        case 15:{
            NSLog(@"down and left");
        }
            break;
            
        case 16:{
            NSLog(@"left");
        }
            break;
        case 17:{
            NSLog(@"up and left");
        }
            break;
        default:
            break;
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    UIView *v = [self viewWithTag:14];
    v.frame = CGRectMake(61, 127, 76, 71);

}



//- (void)dragCenter:(UIPanGestureRecognizer *)sender{
//    /*
//     拖动过程中需要注意：
//     1、中心点范围
//     2、centerImg的中心位置检测，即所处在的区域
//     */
//
//    if (sender.state == UIGestureRecognizerStateBegan || sender.state == UIGestureRecognizerStateChanged) {
//
//        UIView *center = sender.view;
//        CGPoint translation = [sender translationInView:center.superview];
//
//        CGFloat radius = sqrtf(powf((center.center.x - self.bgImgView.center.x), 2) + powf((center.center.y - self.bgImgView.center.y), 2));
//
//        if (radius < self.bounds.size.width/2) {
//            center.center = CGPointMake(translation.x + center.center.x, translation.y + center.center.y);
//            [sender setTranslation:CGPointZero inView:center.superview];
//
//            for (UIImageView *imgView in self.arrowImgViews) {
//                if (CGRectContainsPoint(imgView.frame, center.center)) {
//                    self.selectImgView = imgView;
//                }
//            }
//        }
//
//    }else if (sender.state == UIGestureRecognizerStateEnded || sender.state == UIGestureRecognizerStateCancelled) {
//        [UIView animateWithDuration:0.2 animations:^{
//            _centerImgView.center = self.bgImgView.center;
//            self.selectImgView = nil;
//        }];
//    }
//}

@end

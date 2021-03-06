//
//  RockerView.h
//  LoadAnimation
//
//  Created by Yehua Gao on 2017/11/28.
//  Copyright © 2017年 Yehua Gao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,RockTowardType) {
    RockTowardStop = 0,
    RockTowardUp = 10,
    RockTowardUpAndRight,
    RockTowardRight,
    RockTowardDownAndRight,
    RockTowardDown,
    RockTowardDownAndLeft,
    RockTowardLeft,
    RockTowardUpAndLeft,
};

@class RockerView;
@protocol RockerViewDelegate <NSObject>

//- (void)rockerView:(RockerView *)rocker touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
//- (void)rockerView:(RockerView *)rocker touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;
//- (void)rockerView:(RockerView *)rocker touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;
//- (void)rockerView:(RockerView *)rocker touchesCanceled:(NSSet *)touches withEvent:(UIEvent *)event;

- (void)rockerView:(RockerView *)rocker rockTowards:(RockTowardType)towardType;

@end

@interface RockerView : UIView

@property (nonatomic,weak) id <RockerViewDelegate> delegate;

+ (instancetype)rockerView;

@end

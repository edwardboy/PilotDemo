//
//  CardFlowLayout.m
//  LoadAnimation
//
//  Created by Yehua Gao on 2017/11/29.
//  Copyright © 2017年 Yehua Gao. All rights reserved.
//

#import "CardFlowLayout.h"

#define kItemWidth 250.0
#define kItemHeight 350.0

@implementation CardFlowLayout

- (instancetype)init{
    if (self = [super init]){
        self.itemSize = CGSizeMake(kItemWidth, kItemHeight);
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.sectionInset = UIEdgeInsetsMake(0, ScreenWidth/2 - kItemWidth/2, 0, ScreenWidth/2 - kItemWidth/2);
        self.minimumLineSpacing = (ScreenWidth - kItemWidth)/4;
    }
    return self;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    NSArray *array = [super layoutAttributesForElementsInRect:rect];
//    CGFloat centerX = self.collectionView.contentOffset
    
    return array;
}

@end

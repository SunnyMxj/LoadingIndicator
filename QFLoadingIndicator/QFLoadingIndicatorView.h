//
//  QFLoadingIndicatorView.h
//  QFLoadingIndicator
//
//  Created by QianFan_Ryan on 16/8/9.
//  Copyright © 2016年 QianFan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QFLoadingIndicatorView : UIView

- (instancetype)initWithFrame:(CGRect)frame;

@property(nonatomic, assign)CGFloat borderWidth;//default is 1

@property(nonatomic, strong)UIColor *borderColor;//default is [UIColor colorWithRed:240/255.0f green:240/255.0f blue:240/255.0f alpha:0.7f]

@property(nonatomic, assign)CGFloat radiusPercent;//default is 0.9

@property(nonatomic, strong)UIColor *fillColor;//填充色 default is [UIColor colorWithRed:240/255.0f green:240/255.0f blue:240/255.0f alpha:0.7f]

@property(nonatomic, assign)BOOL prepareAnimation;//是否开启开始旋转动画 default is YES

- (void)updateRatio:(CGFloat)ratio;

@end

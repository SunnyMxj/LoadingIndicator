//
//  QFLoadingIndicatorView.m
//  QFLoadingIndicator
//
//  Created by QianFan_Ryan on 16/8/9.
//  Copyright © 2016年 QianFan. All rights reserved.
//

#import "QFLoadingIndicatorView.h"

@interface QFLoadingIndicatorView()

@property (nonatomic, assign)CGFloat ratio;
@property (nonatomic, strong) CAShapeLayer *shapeLayer;

@end

@implementation QFLoadingIndicatorView

#pragma mark -- system method
- (instancetype)initWithFrame:(CGRect)frame{
    CGFloat length = MIN(CGRectGetWidth(frame), CGRectGetHeight(frame));
    self = [super initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, length, length)];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
        self.layer.cornerRadius = [self getRadius];
        _borderWidth = 1.0f;
        _borderColor = [UIColor colorWithRed:240/255.0f green:240/255.0f blue:240/255.0f alpha:0.7f];
        self.layer.borderColor = _borderColor.CGColor;
        _radiusPercent = 0.9f;
        _fillColor = [UIColor colorWithRed:240/255.0f green:240/255.0f blue:240/255.0f alpha:0.7f];
        self.layer.borderWidth = _borderWidth;
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    if (self.ratio > 0 && self.ratio <= 1) {
        [self stopPrepareAnimation];
        [self drawArcWithContext:UIGraphicsGetCurrentContext() endAngle:[self endAngelForRatio:self.ratio]];
    } else if (self.ratio == 0 && _prepareAnimation){
        [self startPrepareAnimation];
    }
    [super drawRect:rect];
}

#pragma mark -- property
- (CAShapeLayer *)shapeLayer{
    if (!_shapeLayer) {
        _shapeLayer = [[CAShapeLayer alloc] init];
        _shapeLayer.frame = self.bounds;
        _shapeLayer.fillColor = nil;
        _shapeLayer.strokeColor = _borderColor.CGColor;
        [self.layer addSublayer:_shapeLayer];
    }
    return _shapeLayer;
}

- (void)setBorderWidth:(CGFloat)borderWidth{
    _borderWidth = borderWidth;
    if (_prepareAnimation) {
        _shapeLayer.lineWidth = _borderWidth;
    } else {
        self.layer.borderWidth = _borderWidth;
    }
    [self setNeedsDisplay];
}

- (void)setBorderColor:(UIColor *)borderColor{
    _borderColor = borderColor;
    self.layer.borderColor = _borderColor.CGColor;
    _shapeLayer.strokeColor = _borderColor.CGColor;
}

- (void)setPrepareAnimation:(BOOL)prepareAnimation{
    _prepareAnimation = prepareAnimation;
    if (_prepareAnimation) {
        self.layer.borderWidth = .0f;
        self.shapeLayer.lineWidth = _borderWidth;
    } else {
        self.layer.borderWidth = _borderWidth;
    }
}

#pragma mark -- customer method
- (void)startPrepareAnimation{
    self.layer.borderWidth = .0f;
    self.shapeLayer.hidden = NO;
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    
    self.shapeLayer.path = [UIBezierPath bezierPathWithArcCenter:[self getCenter]
                                                          radius:[self getRadius] - _borderWidth
                                                      startAngle:radians(348)
                                                        endAngle:radians(12)
                                                       clockwise:NO].CGPath;
    self.shapeLayer.strokeEnd = 1;
    
    [CATransaction commit];
    
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    rotationAnimation.toValue = [NSNumber numberWithFloat:2*M_PI];
    rotationAnimation.duration = 1.0;
    rotationAnimation.repeatCount = HUGE_VALF;
    
    [self.shapeLayer addAnimation:rotationAnimation forKey:@"prepareAnimation"];
}

- (void)stopPrepareAnimation{
    if (!_shapeLayer || _shapeLayer.hidden) {
        return;
    }
    [_shapeLayer removeAnimationForKey:@"prepareAnimation"];
    _shapeLayer.hidden = YES;
    self.layer.borderWidth = _borderWidth;
}

- (void)updateRatio:(CGFloat)ratio{
    _ratio = ratio;
    [self setNeedsDisplay];
}

#pragma mark -- help method
static inline float radians(double degrees) {
    return degrees * M_PI / 180.0f;
}

- (CGFloat)endAngelForRatio:(CGFloat)ratio{
    return radians(360*ratio - 90);
}

- (void)drawArcWithContext:(CGContextRef)ctx endAngle:(CGFloat)angel{
    CGPoint center = [self getCenter];
    CGContextMoveToPoint(ctx, center.x, center.y);
    CGContextSetFillColor(ctx, CGColorGetComponents(_fillColor.CGColor));
    CGContextAddArc(ctx, center.x, center.y, [self getRadius]*_radiusPercent,  -M_PI_2, angel, 0);
    CGContextClosePath(ctx);
    CGContextFillPath(ctx);
}

- (CGFloat)getRadius{
    static CGFloat radius;
    radius = CGRectGetWidth(self.bounds) / 2;
    return radius;
}

- (CGPoint)getCenter{
    return CGPointMake([self getRadius], [self getRadius]);
}

@end

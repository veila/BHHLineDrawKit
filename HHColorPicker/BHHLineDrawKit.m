//
//  BHHLineDrawKit.m
//  HHColorPicker
//
//  Created by iAm2r on 12/30/16.
//  Copyright © 2016 ME293. All rights reserved.
//

#import "BHHLineDrawKit.h"

//#define distanceShowViewColor           80
//#define minDistanceToEdge               0
//#define durationAnimation               0.2
//#define maxViewColor                    30
//#define minViewColor                    2
//#define minViewLine                     1
//#define minPercentViewLine              0.03
//#define maxPercentViewLine              0.9

@implementation BHHLineDrawKit{
    UIView *viewColor;
    UIView *viewLineWidth;
}

-(void)initOriginal{
    self.distanceShowViewColor = 80;
    self.minDistanceToEdge = 0;
    self.durationAnimation = 0.2;
    self.maxViewColor = 30;
    self.minViewColor = 2;
    self.minViewLine = 1;
    self.minPercentViewLine = 0.03;
    self.maxPercentViewLine = 0.9;
}

-(void)layoutSubviews{

    viewColor = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _minViewColor, _minViewColor)];
    viewColor.hidden = YES;
    viewColor.layer.borderWidth = 2;
    viewColor.layer.borderColor = [[UIColor blackColor] CGColor];
    viewColor.backgroundColor = [UIColor whiteColor];
    [self addSubview:viewColor];
    viewLineWidth = [[UIView alloc] initWithFrame:CGRectMake(viewColor.frame.size.width/2 - _minViewLine, viewColor.frame.size.width/2 - _minViewLine, _minViewLine, _minViewLine)];
    viewColor.layer.borderWidth = 0.5;
    viewLineWidth.backgroundColor = [UIColor blackColor];
    [viewColor addSubview:viewLineWidth];
    
    self.pickerColorImage.image = [self colorSliderBackground];
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint point = [touch locationInView:self];
    
    viewColor.layer.borderColor = [[self getColorFromValue:point.y/self.frame.size.height] CGColor];
    viewLineWidth.backgroundColor = [self getColorFromValue:point.y/self.frame.size.height];
    viewColor.frame = CGRectMake(point.x, point.y, _minViewColor, _minViewColor);
    viewColor.hidden = NO;
    [UIView animateWithDuration:_durationAnimation animations:^{
        viewColor.frame = CGRectMake(point.x - _distanceShowViewColor, point.y, _maxViewColor, _maxViewColor);
        viewLineWidth.frame = CGRectMake(viewColor.frame.size.width/2 - _minViewLine, viewColor.frame.size.width/2 - _minViewLine, _minViewLine, _minViewLine);
    } completion:^(BOOL finished) {
    }];
    [self addCornerRadiusAnimationFrom:1 andTo:_maxViewColor/2 andDuration:_durationAnimation];
}


- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint point = [touch locationInView:self];
    viewColor.layer.borderColor = [[self getColorFromValue:point.y/self.frame.size.height] CGColor];
    viewLineWidth.backgroundColor = [self getColorFromValue:point.y/self.frame.size.height];
    
    float percent = 0;
    if(point.x < -_minPercentViewLine*self.frame.origin.x){
        percent = -point.x/(self.frame.origin.x);
    }
    else{
        percent = 0.03;
    }
    
    if(percent > _maxPercentViewLine){
        percent = _maxPercentViewLine;
    }
    
    if(point.x - _distanceShowViewColor - _minDistanceToEdge < -self.frame.origin.x){
        point.x = -self.frame.origin.x + _distanceShowViewColor + _minDistanceToEdge;
    }
    
    [UIView animateWithDuration:_durationAnimation animations:^{
        viewColor.frame = CGRectMake(point.x - _distanceShowViewColor, point.y,_maxViewColor, _maxViewColor);
    } completion:^(BOOL finished) {
        
    }];
    
    
    viewLineWidth.frame = CGRectMake(viewColor.frame.size.width/2 - (percent*_maxViewColor)/2, viewColor.frame.size.width/2 - (percent*_maxViewColor)/2, percent*_maxViewColor, percent*_maxViewColor);
    viewLineWidth.layer.cornerRadius = (percent*_maxViewColor)/2;
    
    [self.delegate endSettingColor:viewLineWidth.backgroundColor AndLineWidth:viewLineWidth.frame.size.width];
}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint point = [touch locationInView:self];
    [UIView animateWithDuration:_durationAnimation animations:^{
        viewColor.frame = CGRectMake(point.x, point.y, _minViewColor, _minViewColor);
        viewLineWidth.frame = CGRectMake(viewColor.frame.size.width/2 - _minViewLine, viewColor.frame.size.width/2 - _minViewLine, _minViewLine, _minViewLine);
    } completion:^(BOOL finished) {
        viewColor.hidden = YES;
    }];
    
    [self addCornerRadiusAnimationFrom:_maxViewColor/2 andTo:1 andDuration:_durationAnimation];
}

-(void)addCornerRadiusAnimationFrom:(CGFloat)from andTo:(CGFloat)to andDuration:(CFTimeInterval)duration{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"cornerRadius"];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    animation.fromValue = [NSNumber numberWithFloat:from];
    animation.toValue = [NSNumber numberWithFloat:to];
    animation.duration = duration;
    [viewColor.layer addAnimation:animation forKey:@"cornerRadius"];
    viewColor.layer.cornerRadius = to;
}

-(UIColor*)getColorFromValue:(float)value
{
    if(value<1/3.0){
        return [UIColor colorWithWhite:value/0.3 alpha:1];
    }
    return [UIColor colorWithHue:((value-1/3.0)/0.7)*2/3.0 saturation:1 brightness:1 alpha:1];
}


- (UIImage*)colorSliderBackground
{
    CGSize size = self.pickerColorImage.frame.size;
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGRect frame = self.pickerColorImage.frame;
    CGPathRef path = [UIBezierPath bezierPathWithRoundedRect:frame cornerRadius:5].CGPath;
    CGContextAddPath(context, path);
    CGContextClip(context);
    
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    CGFloat components[] = {
        0.0f, 0.0f, 0.0f, 1.0f,
        1.0f, 1.0f, 1.0f, 1.0f,
        1.0f, 0.0f, 0.0f, 1.0f,
        1.0f, 1.0f, 0.0f, 1.0f,
        0.0f, 1.0f, 0.0f, 1.0f,
        0.0f, 1.0f, 1.0f, 1.0f,
        0.0f, 0.0f, 1.0f, 1.0f
    };
    
    size_t count = sizeof(components)/ (sizeof(CGFloat)* 4);
    CGFloat locations[] = {0.0f, 0.9/3.0, 1/3.0, 1.5/3.0, 2/3.0, 2.5/3.0, 1.0};
    
    CGPoint startPoint = CGPointMake(0, 0);
    CGPoint endPoint = CGPointMake(0, size.height);
    
    CGGradientRef gradientRef = CGGradientCreateWithColorComponents(colorSpaceRef, components, locations, count);
    
    CGContextDrawLinearGradient(context, gradientRef, startPoint, endPoint, kCGGradientDrawsAfterEndLocation);
    
    UIImage *tmp = UIGraphicsGetImageFromCurrentImageContext();
    
    CGGradientRelease(gradientRef);
    CGColorSpaceRelease(colorSpaceRef);
    
    UIGraphicsEndImageContext();
    
    return tmp;
}




@end

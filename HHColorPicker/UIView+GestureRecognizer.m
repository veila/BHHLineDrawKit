//
//  UIView+GestureRecognizer.m
//  HHColorPicker
//
//  Created by iAm2r on 1/5/17.
//  Copyright © 2017 ME293. All rights reserved.
//

#import "UIView+GestureRecognizer.h"

@implementation UIView (GestureRecognizer)


-(void)addGestureRecognizer{
    
    UIPanGestureRecognizer* panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(move:)];
    [panRecognizer setMinimumNumberOfTouches:1];
    [panRecognizer setMaximumNumberOfTouches:1];
    [panRecognizer setDelegate:self];
    [self addGestureRecognizer:panRecognizer];
    
    UIRotationGestureRecognizer* rotationRecognizer = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotate:)];
    [rotationRecognizer setDelegate:self];
    [self addGestureRecognizer:rotationRecognizer];
    
    
    UIPinchGestureRecognizer *scale = [[UIPinchGestureRecognizer alloc]
                                                initWithTarget:self
                                                action:@selector(scale:)];
    
    [self addGestureRecognizer:scale];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    
    [self addGestureRecognizer:tap];
    

}

- (void)scale:(UIPinchGestureRecognizer *)recognizer
{
    
    recognizer.view.transform = CGAffineTransformScale(recognizer.view.transform, recognizer.scale, recognizer.scale);
    recognizer.scale = 1;
    
}

-(void)tap:(UITapGestureRecognizer*)recognizer{
    
    [self.superview bringSubviewToFront:self];
    
}

-(void)move:(UIPanGestureRecognizer *)recognizer {
    
    CGPoint translation = [recognizer translationInView:self.superview];
    recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x,
                                         recognizer.view.center.y + translation.y);
    [recognizer setTranslation:CGPointMake(0, 0) inView:self.superview];
}

-(void)rotate:(UIRotationGestureRecognizer *)recognizer {
    
    recognizer.view.transform = CGAffineTransformRotate(recognizer.view.transform, recognizer.rotation);
    recognizer.rotation = 0;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

@end

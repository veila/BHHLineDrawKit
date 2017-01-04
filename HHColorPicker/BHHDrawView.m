//
//  BHHDrawView.m
//  HHColorPicker
//
//  Created by iAm2r on 1/4/17.
//  Copyright © 2017 ME293. All rights reserved.
//

#import "BHHDrawView.h"

@implementation BHHDrawView{
    
    UIImageView *_drawingView;
    CGPoint _prevDraggingPosition;
    UIColor *colorLine;
    CGFloat widthLine;
}

-(instancetype)initWith:(CGRect)frame{
    self = [super init];
    self.frame = frame;
    [self setup];
    return self;
}

-(void)setup{
    
    colorLine = [UIColor blackColor];
    widthLine = 1;
    self.backgroundColor = [UIColor clearColor];
    _drawingView = [[UIImageView alloc] initWithFrame:self.bounds];
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(drawingViewDidPan:)];
    panGesture.maximumNumberOfTouches = 1;
    
    _drawingView.userInteractionEnabled = YES;
    [_drawingView addGestureRecognizer:panGesture];

    [self addSubview:_drawingView];
}

-(void)setupWidth:(CGFloat)width andColor:(UIColor*)color{
    colorLine = color;
    widthLine = width;
}


- (void)drawingViewDidPan:(UIPanGestureRecognizer*)sender
{
    CGPoint currentDraggingPosition = [sender locationInView:_drawingView];
    
    if(sender.state == UIGestureRecognizerStateBegan){
        _prevDraggingPosition = currentDraggingPosition;
    }
    
    if(sender.state != UIGestureRecognizerStateEnded){
        [self drawLine:_prevDraggingPosition to:currentDraggingPosition];
    }
    _prevDraggingPosition = currentDraggingPosition;
}

-(void)drawLine:(CGPoint)from to:(CGPoint)to
{
    
    CGSize size = _drawingView.frame.size;
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [_drawingView.image drawAtPoint:CGPointZero];
    
    //CGFloat strokeWidth = MAX(1, _widthSlider.value * 65);
    //UIColor *strokeColor = _strokePreview.backgroundColor;
    
    CGContextSetLineWidth(context, widthLine);
    CGContextSetStrokeColorWithColor(context, colorLine.CGColor);
    CGContextSetLineCap(context, kCGLineCapRound);
    
//    if(!_eraserIcon.hidden){
//        CGContextSetBlendMode(context, kCGBlendModeClear);
//    }
    
    CGContextMoveToPoint(context, from.x, from.y);
    CGContextAddLineToPoint(context, to.x, to.y);
    CGContextStrokePath(context);
    
    _drawingView.image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
}



@end

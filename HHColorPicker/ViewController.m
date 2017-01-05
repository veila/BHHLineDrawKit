//
//  ViewController.m
//  HHColorPicker
//
//  Created by iAm2r on 12/30/16.
//  Copyright © 2016 ME293. All rights reserved.
//

#import "ViewController.h"
#import "BHHLineDrawKit.h"
#import "DrawView.h"
#import "BHHDrawView.h"
#import "UIView+GestureRecognizer.h"

@interface ViewController ()<BHHLineDrawKitDelegate, UIGestureRecognizerDelegate>

@end

@implementation ViewController{
    BHHLineDrawKit *picker;
    BHHDrawView *drawView;
    
    CGFloat firstX;
    CGFloat firstY;
    CGFloat lastRotation;
    
    
    
}



- (void)viewDidLoad {
    
    [super viewDidLoad];
    lastRotation = 0.0;
    
    
    [self.imgView addGestureRecognizer];
    
//    UIPanGestureRecognizer* panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(move:)];
//    [panRecognizer setMinimumNumberOfTouches:1];
//    [panRecognizer setMaximumNumberOfTouches:1];
//    [panRecognizer setDelegate:self];
//    [self.imgView addGestureRecognizer:panRecognizer];
//    
//    UIRotationGestureRecognizer* rotationRecognizer = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotate:)];
//    [rotationRecognizer setDelegate:self];
//    [self.imgView addGestureRecognizer:rotationRecognizer];
//    
//    
//    UIPinchGestureRecognizer *twoFingerPinch = [[UIPinchGestureRecognizer alloc]
//                                                 initWithTarget:self
//                                                 action:@selector(twoFingerPinch:)];
//    
//    [self.imgView addGestureRecognizer:twoFingerPinch];
    //[self addDrawView];
    //[self addPickerColor];
    // Do any additional setup after loading the view, typically from a nib.
}

//- (void)twoFingerPinch:(UIPinchGestureRecognizer *)recognizer
//{
//    
//    recognizer.view.transform = CGAffineTransformScale(recognizer.view.transform, recognizer.scale, recognizer.scale);
//    recognizer.scale = 1;
//    
//}
//
//
//-(void)move:(UIPanGestureRecognizer *)recognizer {
//    
//    CGPoint translation = [recognizer translationInView:self.view];
//    recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x,
//                                         recognizer.view.center.y + translation.y);
//    [recognizer setTranslation:CGPointMake(0, 0) inView:self.view];
//
//
//}
//-(void)rotate:(UIRotationGestureRecognizer *)recognizer {
//    
//    recognizer.view.transform = CGAffineTransformRotate(recognizer.view.transform, recognizer.rotation);
//    recognizer.rotation = 0;
//}
//
//-(void)addDrawView{
//    
//    drawView = [[BHHDrawView alloc] initWith:self.view.bounds];
//    [self.view addSubview:drawView];
//    
//}
//
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
//    return YES;
//}


-(void)addPickerColor{
    NSArray *subviewArray = [[NSBundle mainBundle] loadNibNamed:@"BHHLineDrawKit" owner:self options:nil];
    picker = [subviewArray objectAtIndex:0];
    picker.delegate = self;
    [picker initOriginal];
    picker.frame = CGRectMake(self.view.frame.size.width - 50, 20, 30, 500);
    [self.view addSubview:picker];
}

-(void)endSettingColor:(UIColor*)color AndLineWidth:(CGFloat)width{
    [drawView setupWidth:width andColor:color];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}





@end

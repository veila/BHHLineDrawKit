//
//  BHHDrawView.h
//  HHColorPicker
//
//  Created by iAm2r on 1/4/17.
//  Copyright © 2017 ME293. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BHHDrawView : UIView

-(instancetype)initWith:(CGRect)frame;
-(void)setupWidth:(CGFloat)width andColor:(UIColor*)color;

@end

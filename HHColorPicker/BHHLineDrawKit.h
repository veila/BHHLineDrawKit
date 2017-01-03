//
//  BHHLineDrawKit.h
//  HHColorPicker
//
//  Created by iAm2r on 12/30/16.
//  Copyright © 2016 ME293. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BHHLineDrawKitDelegate <NSObject>

-(void)endSettingColor:(UIColor*)color AndLineWidth:(CGFloat)width;

@end

@interface BHHLineDrawKit : UIView
@property (strong, nonatomic) IBOutlet UIImageView *pickerColorImage;
@property (strong, nonatomic) id<BHHLineDrawKitDelegate> delegate;



// distance to show a circle color to the touching point
@property (nonatomic) CGFloat distanceShowViewColor;

// min distance from the circle color to egde of the screen (both left and right if setting TRUE on ...)
@property (nonatomic) CGFloat minDistanceToEdge;

// duration animation to show and hide circle color
@property (nonatomic) CFTimeInterval durationAnimation;

// max size of the circle color (diameter)
@property (nonatomic) CGFloat maxViewColor;

// min size of the circle color (diameter)
@property (nonatomic) CGFloat minViewColor;

// min original size of circle line
@property (nonatomic) CGFloat minViewLine;

// min percent size of circle line with circle color
@property (nonatomic) CGFloat minPercentViewLine;

// max percent size of circle line with circle color when move finger
@property (nonatomic) CGFloat maxPercentViewLine;

-(void)initOriginal;

@end

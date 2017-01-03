//
//  ViewController.m
//  HHColorPicker
//
//  Created by iAm2r on 12/30/16.
//  Copyright © 2016 ME293. All rights reserved.
//

#import "ViewController.h"
#import "BHHLineDrawKit.h"

@interface ViewController ()<BHHLineDrawKitDelegate>

@end

@implementation ViewController{
    BHHLineDrawKit *picker;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addPickerColor];
    // Do any additional setup after loading the view, typically from a nib.
}


-(void)addPickerColor{
    NSArray *subviewArray = [[NSBundle mainBundle] loadNibNamed:@"BHHLineDrawKit" owner:self options:nil];
    picker = [subviewArray objectAtIndex:0];
    picker.delegate = self;
    [picker initOriginal];
    picker.frame = CGRectMake(self.view.frame.size.width - 50, 20, 30, 500);
    [self.view addSubview:picker];
}

-(void)endSettingColor:(UIColor*)color AndLineWidth:(CGFloat)width{
    self.view.backgroundColor = color;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end

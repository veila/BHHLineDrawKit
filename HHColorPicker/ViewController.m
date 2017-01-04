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

@interface ViewController ()<BHHLineDrawKitDelegate>

@end

@implementation ViewController{
    BHHLineDrawKit *picker;
    BHHDrawView *drawView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addDrawView];
    [self addPickerColor];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)addDrawView{
    
    drawView = [[BHHDrawView alloc] initWith:self.view.bounds];
    [self.view addSubview:drawView];
    
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
    [drawView setupWidth:width andColor:color];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}





@end

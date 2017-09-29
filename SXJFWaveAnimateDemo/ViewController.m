//
//  ViewController.m
//  SXJFWaveAnimateDemo
//
//  Created by shanlin on 2017/9/29.
//  Copyright © 2017年 shanxingjinfu. All rights reserved.
//

#import "ViewController.h"
#import "SXJFWaveAnimationView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSDictionary *dict = @{
                           SXJFWaveBorderWidth:@5,
                           SXJFWaveTextFontSize:@24,
                           SXJFWaveTextString:@"善林金融",
                           SXJFWaveCurveHeightPosition:@(SXJFWaveCurveFluctuationPositionType_Center),
                           SXJFWaveTopTextColor:[UIColor blueColor],
                           SXJFWaveTopBorderColor:[UIColor yellowColor],
                           SXJFWaveTopBackgroundColor:[UIColor whiteColor],
                           SXJFWaveHollowTextColor:[UIColor blackColor],
                           SXJFWaveHollowBorderColor:[UIColor yellowColor],
                           SXJFWaveHollowBackgroundColor:[UIColor blueColor],
                           SXJFWaveBottomTextColor:[UIColor whiteColor],
                           SXJFWaveBottomBackgroundColor:[UIColor blueColor],
                           SXJFWaveBottomBorderColor:[UIColor yellowColor],
                           
                           
                           
                           };
    
    CGFloat swidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat sheight = [UIScreen mainScreen].bounds.size.height;
    
    SXJFWaveAnimationView *waveView = [[SXJFWaveAnimationView alloc]initWithFrame:CGRectMake((swidth-150)/2.0, (sheight-150)/2.0, 150, 150) waveConfigures:dict];
    
    
    [self.view addSubview:waveView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

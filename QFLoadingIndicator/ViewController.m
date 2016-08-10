//
//  ViewController.m
//  QFLoadingIndicator
//
//  Created by QianFan_Ryan on 16/8/9.
//  Copyright © 2016年 QianFan. All rights reserved.
//

#import "ViewController.h"
#import "QFLoadingIndicatorView.h"

@interface ViewController ()

@property (nonatomic,weak)QFLoadingIndicatorView *indicator;
@property (nonatomic,assign)CGFloat ratio;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor darkGrayColor];

    QFLoadingIndicatorView *indicator = [[QFLoadingIndicatorView alloc]initWithFrame:CGRectMake(10, 100, 100, 100)];
    indicator.fillColor = [UIColor colorWithRed:240/255.0f green:240/255.0f blue:240/255.0f alpha:0.7f];
//    _indicator.borderWidth = 2.f;
    indicator.prepareAnimation = YES;
    [self.view addSubview:indicator];
    
    _indicator = indicator;
    
    UISlider *slider = [[UISlider alloc]initWithFrame:CGRectMake(10, 300, [UIScreen mainScreen].bounds.size.width-20, 20)];
    [slider addTarget:self action:@selector(sliderChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:slider];
}

- (void)sliderChanged:(UISlider *)slider{
    [_indicator updateRatio:slider.value];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

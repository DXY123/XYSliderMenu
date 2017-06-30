//
//  ViewController.m
//  XYSlideMenuDemo
//
//  Created by 邓雪莹 on 2017/6/30.
//  Copyright © 2017年 邓雪莹. All rights reserved.
//

#import "ViewController.h"

#define SCREENW [UIScreen mainScreen].bounds.size.width
#define SCREENH [UIScreen mainScreen].bounds.size.height

@interface ViewController ()

@property (nonatomic, strong) UILabel * mainLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    [self prepareUI];
    
}


- (void)prepareUI{
    
    self.view.backgroundColor = [UIColor yellowColor];
    
    [self.view addSubview:self.mainLabel];
    
    [self frameSetup];
    
}

- (void)frameSetup{
    
    self.mainLabel.frame = CGRectMake(0, 0, 150, 30);
    self.mainLabel.center = CGPointMake(SCREENW * 0.5, SCREENH * 0.5);
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 懒加载

- (UILabel *)mainLabel{
    if (!_mainLabel) {
        _mainLabel = [[UILabel alloc] init];
        _mainLabel.text = @"MainController";
        _mainLabel.textAlignment = NSTextAlignmentCenter;
        _mainLabel.textColor = [UIColor blackColor];
    }
    return _mainLabel;
}

@end

//
//  XYSliderController.h
//  XYSlideMenuDemo
//
//  Created by 邓雪莹 on 2017/6/30.
//  Copyright © 2017年 邓雪莹. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYSliderController : UIViewController

/**
 API
 
 @param leftVC 策划菜单
 @param mainVC 主界面
 @param slideOffset 侧滑菜单完整显示需要的偏移
 @param scale 屏幕适配比例(屏幕宽度/slideOffset对应的测试机的屏幕宽度)
 @return self
 */
- (instancetype)initWithLeftController:(UIViewController *)leftVC mainController:(UIViewController *)mainVC slideOffset:(CGFloat)slideOffset andScale:(CGFloat)scale;


@end

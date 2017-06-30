//
//  XYSliderController.m
//  XYSlideMenuDemo
//
//  Created by 邓雪莹 on 2017/6/30.
//  Copyright © 2017年 邓雪莹. All rights reserved.
//

#import "XYSliderController.h"

@interface XYSliderController ()

@property(nonatomic,strong) UIViewController * leftVC;

@property(nonatomic,strong) UIViewController * mainVC;

@property(nonatomic,assign)CGFloat slideOffset;

/** 轻触手势 */
@property(nonatomic,strong) UITapGestureRecognizer * tap;

@end

@implementation XYSliderController

- (instancetype)initWithLeftController:(UIViewController *)leftVC mainController:(UIViewController *)mainVC slideOffset:(CGFloat)slideOffset andScale:(CGFloat)scale{
    if (self = [super init]) {
        self.leftVC = leftVC;
        self.mainVC = mainVC;
        self.slideOffset = slideOffset * scale;
        
        //1.添加子控制器
        [self addChildViewController:leftVC];
        
        [self addChildViewController:mainVC];
        
        //2.盖视图 添加子view
        [self.view addSubview:leftVC.view];
        [self.view addSubview:mainVC.view];
        
        
        //3.didMove
        [leftVC didMoveToParentViewController:self];
        [mainVC didMoveToParentViewController:self];
        
        //4.添加拖拽手势
        UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
        
        [self.view addGestureRecognizer:pan];
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
}


#pragma mark - 侧滑手势
- (void)pan:(UIPanGestureRecognizer *)sender{
    //1.get offset
    CGPoint offset = [sender translationInView:sender.view];
    
    //2.return to zero
    [sender setTranslation:CGPointZero inView:sender.view];
    
    
    //防止往左滑右面穿透 防止向右滑过界
    if (offset.x + self.mainVC.view.frame.origin.x < 0 || offset.x + self.mainVC.view.frame.origin.x > self.slideOffset) {
        return ;
    }
    
    
    switch (sender.state) {
        case UIGestureRecognizerStateBegan:
        case UIGestureRecognizerStateChanged:
            //形变
            self.mainVC.view.transform = CGAffineTransformTranslate(self.mainVC.view.transform, offset.x, 0);
            [UIView animateWithDuration:.3 animations:^{
                
            }];
            break;
            
        case UIGestureRecognizerStateFailed:
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded:
            //判断状态
            //如果大于效果宽度的一半,则完全打开菜单控制器
            if (self.mainVC.view.frame.origin.x > self.slideOffset * 0.5) {
                [self openSlideMenu];
            }else{
                //否则还原
                [self closeSlideMenu];
            }
            
        default:
            break;
    }
    
    
}

- (void)openSlideMenu{
    [UIView animateWithDuration:.3 animations:^{
        self.mainVC.view.transform = CGAffineTransformMakeTranslation(self.slideOffset, 0);
    }];
    
    //判断：如果已经有tap手势 则不添加
    if (![self.mainVC.view.gestureRecognizers containsObject:self.tap]) {
        //添加点击手势
        [self.mainVC.view addGestureRecognizer:self.tap];
    }
    
    
}

//轻触手势
- (void)tap:(UITapGestureRecognizer *)sender{
    //关闭
    [self closeSlideMenu];
}

- (void)closeSlideMenu{
    [UIView animateWithDuration:.3 animations:^{
        self.mainVC.view.transform = CGAffineTransformIdentity;
    }];
    
    //删除手势
    [self.mainVC.view removeGestureRecognizer:self.tap];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Getter

- (UITapGestureRecognizer *)tap{
    if (!_tap) {
        _tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    }
    return _tap;
}


@end

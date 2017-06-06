//
//  MainViewController.m
//  DrawerDemo
//
//  Created by 刘高升 on 2017/6/6.
//  Copyright © 2017年 刘高升. All rights reserved.
//

#import "MainViewController.h"
#define kScreenWidth   [UIScreen mainScreen].bounds.size.width
#define kScreenHeight  [UIScreen mainScreen].bounds.size.height
#define AnimationDuration  0.2
#define LeftMenuVCoriginX  -kScreenWidth * 0.6
#define LeftMenuVCEndOriginX 0
#define HomeVCOriginX 0
#define HomeVCEndOriginX kScreenWidth * 0.6

#define LeftVCWidthScaleValue  1
#define LeftVCWidthEndScaleValue  1
#define LeftVCHeightScaleValue 1
#define LeftVCHeightEndScaleValue 1

#define HomeVCWidthScaleValue  1
#define HomeVCWidthEndScaleValue  1
#define HomeVCHeightScaleValue 1
#define HomeVCHeightEndScaleValue 1

#define MaxDistance  HomeVCEndOriginX - HomeVCOriginX


@interface MainViewController ()
{

    UITapGestureRecognizer *_tap;
    
    UIViewController *_leftController;
    UIViewController *_homeController;

    UIView *_leftView;
    UIView *_homeView;
    
    CGFloat _distance;
    

}
@end

@implementation MainViewController

- (instancetype)initLeftMenuController:(UIViewController *)leftController andHomeController:(UIViewController *)homeController {

    if (self == [super init]) {
        
        _leftController = leftController;
        _homeController = homeController;
        
    }
    return self;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initContent];
    
}

//初始化控制器
- (void)initContent {
    self.view.backgroundColor = [UIColor whiteColor];
    //初始化点击手势
    _tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    //左侧
    _leftView = _leftController.view;
    _leftView.transform = CGAffineTransformConcat(CGAffineTransformMakeScale(LeftVCWidthScaleValue,LeftVCHeightScaleValue ), CGAffineTransformMakeTranslation(LeftMenuVCoriginX, 0));
    [self.view addSubview:_leftView];
    [self addChildViewController:_leftController];
    [_leftController didMoveToParentViewController:self];
    
    //主页
    _homeView = _homeController.view;
    _homeView.transform = CGAffineTransformConcat(CGAffineTransformMakeScale(HomeVCWidthScaleValue, HomeVCHeightScaleValue), CGAffineTransformMakeTranslation(0, 0));
    [self.view addSubview:_homeView];
    [self addChildViewController:_homeController];
    [_homeController didMoveToParentViewController:self];
    
    //滑动手势
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
    [_homeView addGestureRecognizer:pan];

}


#pragma mark - pan
- (void)pan:(UIPanGestureRecognizer *)panGes {

    CGFloat moveX = [panGes translationInView:_homeView].x;
    _distance = _distance + moveX;
    //百分比
    CGFloat percent = _distance / MaxDistance;
    if (percent >= 0 && percent <= 1) {
        
        _leftView.transform = CGAffineTransformConcat(CGAffineTransformMakeScale(LeftVCWidthScaleValue, LeftVCHeightScaleValue), CGAffineTransformMakeTranslation(LeftMenuVCoriginX + _distance, 0));
        _homeView.transform = CGAffineTransformConcat(CGAffineTransformMakeScale(HomeVCWidthScaleValue, HomeVCHeightScaleValue), CGAffineTransformMakeTranslation(HomeVCOriginX + _distance, 0));
    }

    if (panGes.state == UIGestureRecognizerStateEnded) {
        
        if (percent >= 0.3) {
            
            [self showMenuView];
            
        }else {
            
            [self showHomeView];
        
        }
    }else{
        
        [panGes setTranslation:CGPointZero inView:self.view];
    
    }


}


- (void)tap:(UITapGestureRecognizer *)tapGes {

    [self showHomeView];

}

- (void)showMenuView {

    [UIView animateWithDuration:AnimationDuration animations:^{
        
           _leftView.transform = CGAffineTransformConcat(CGAffineTransformMakeScale(LeftVCWidthEndScaleValue, LeftVCHeightEndScaleValue), CGAffineTransformMakeTranslation(LeftMenuVCEndOriginX, 0));
           _homeView.transform = CGAffineTransformConcat(CGAffineTransformMakeScale(HomeVCWidthEndScaleValue,HomeVCHeightEndScaleValue), CGAffineTransformMakeTranslation(HomeVCEndOriginX, 0));
        
        
    }completion:^(BOOL finished) {
        _distance = HomeVCEndOriginX;
        [_homeView addGestureRecognizer:_tap];
        
    }];



}


- (void)showHomeView {

    [UIView animateWithDuration:AnimationDuration animations:^{
        _leftView.transform = CGAffineTransformConcat(CGAffineTransformMakeScale(LeftVCWidthScaleValue, LeftVCHeightScaleValue), CGAffineTransformMakeTranslation(LeftMenuVCoriginX, 0));
        _homeView.transform = CGAffineTransformConcat(CGAffineTransformMakeScale(HomeVCWidthScaleValue,HomeVCHeightScaleValue), CGAffineTransformMakeTranslation(HomeVCOriginX, 0));
    }completion:^(BOOL finished) {
        _distance = HomeVCOriginX;
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

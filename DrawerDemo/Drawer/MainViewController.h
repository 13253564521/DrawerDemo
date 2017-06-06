//
//  MainViewController.h
//  DrawerDemo
//抽屉框架
//  Created by 刘高升 on 2017/6/6.
//  Copyright © 2017年 刘高升. All rights reserved.
//底层控制器

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController
- (instancetype)initLeftMenuController:(UIViewController *)leftController andHomeController:(UIViewController *)homeController;
@end

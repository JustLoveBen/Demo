//
//  DetailViewController.m
//  subviews
//
//  Created by JustBen on 7/20/16.
//  Copyright © 2016 JustBen. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
            
        // Update the view.
        [self configureView];
    }
}

- (void)configureView {
    // Update the user interface for the detail item.
    if (self.detailItem) {
        self.detailDescriptionLabel.text = [self.detailItem description];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)testButton:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    return;
    
    UIViewController *topVC = [[self class] getVisibleViewController];
    if (topVC.navigationController) {
        if (topVC.navigationController.viewControllers.count > 1) {
            [topVC.navigationController popViewControllerAnimated:YES];
        } else {
            if (topVC.navigationController.presentingViewController) {
                [topVC.navigationController dismissViewControllerAnimated:YES completion:^{
                    
                }];
            }
        }
    } else {
        if (topVC.presentingViewController) {
            [topVC dismissViewControllerAnimated:YES completion:^{
                
            }];
        }
    }
}


+ (UIViewController*)getVisibleViewController
{
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal) {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(window in windows) {
            if (window.windowLevel == UIWindowLevelNormal) {
                break;
            }
        }
    }
    
    UIViewController *rootViewController = window.rootViewController;
    return [[self class] childViewController:rootViewController];
}

+ (UIViewController *)childViewController:(UIViewController *)viewController
{
    if (viewController.presentedViewController)
    {
        return [self childViewController:viewController.presentedViewController];
    } else if ([viewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabBarController = (UITabBarController *)viewController;
        UIViewController *selectedViewController = tabBarController.selectedViewController;
        
        return [self childViewController:selectedViewController];
    } else if ([viewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navigationController = (UINavigationController *)viewController;
        UIViewController *lastViewController = [[navigationController viewControllers] lastObject];
        
        return [self childViewController:lastViewController];
    } else if ([viewController isKindOfClass:[UIPageViewController class]]) {
        UIPageViewController *pageViewController = (UIPageViewController *)viewController;
        UIViewController *visibleViewController = pageViewController.viewControllers[0];
        if (visibleViewController) {
            return [self childViewController:visibleViewController];
        } else {
            return viewController;
        }
    } else if ([viewController isKindOfClass:[UISplitViewController class]]) {
        UISplitViewController *spliteViewController = (UISplitViewController *)viewController;
        UIViewController *visibleViewController = [spliteViewController.viewControllers lastObject];
        if (visibleViewController) {
            return [self childViewController:visibleViewController];
        } else {
            return viewController;
        }
    } else {
        if (viewController.childViewControllers && viewController.childViewControllers.count > 0) {
            UIViewController *lastViewController = [viewController.childViewControllers lastObject];
            return [self childViewController:lastViewController];
        }
    }
    
    return viewController;
}


@end

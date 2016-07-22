//
//  UIViewController+Swizzlean.m
//  Swizzle
//
//  Created by JustBen on 5/4/16.
//  Copyright © 2016 JustBen. All rights reserved.
//

#import "UIViewController+Swizzlean.h"
#import "AnalyticsSwizzlean.h"

@implementation UIViewController (Swizzlean)

+ (void)load
{
    SEL selectores[] = {@selector(viewDidLoad), @selector(viewWillAppear:), @selector(viewWillDisappear:)};
    
    for (int i = 0; i < sizeof(selectores)/sizeof(SEL); i++) {
        SEL originSelector = selectores[i];
        SEL swizzleSelector = NSSelectorFromString([NSString stringWithFormat:@"as_%@", NSStringFromSelector(originSelector)]);
        
        as_swizzleInstanceMethods(self, originSelector, swizzleSelector);
    }
}

- (void)as_viewDidLoad
{
    [self as_viewDidLoad];
}

- (void)as_viewWillAppear:(BOOL)animation
{
    [self as_viewWillAppear:animation];
}

- (void)as_viewWillDisappear:(BOOL)animation
{
    [self as_viewWillDisappear:animation];
}

@end

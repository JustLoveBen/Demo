//
//  UIViewController+Analytics.m
//  phoncol
//
//  Created by JustBen on 4/26/16.
//  Copyright © 2016 t8. All rights reserved.
//

#import "UIViewController+Analytics.h"
#import "UITabBarController+Analytics.h"
#import "AnalyticsSwizzlean.h"

@implementation UIViewController (Analytics)

+ (void)load {
    // All methods that trigger height cache's invalidation
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL selectors[] = {
            @selector(viewWillAppear:),
            @selector(viewWillDisappear:),
        };
        
        for (NSUInteger index = 0; index < sizeof(selectors) / sizeof(SEL); ++index) {
            SEL originalSelector = selectors[index];
            SEL swizzledSelector = NSSelectorFromString([@"as_" stringByAppendingString:NSStringFromSelector(originalSelector)]);
            
            as_swizzleSelector([self class], originalSelector, swizzledSelector);
        }
    });
}

- (void)as_viewWillAppear:(BOOL)animated {
    [self as_viewWillAppear:animated];
    
    if ([self isKindOfClass:[UINavigationController class]]) {
        return;
    }
    
    // [MobClick beginLogPageView:NSStringFromClass([self class])];
}

- (void)as_viewWillDisappear:(BOOL)animated {
    [self as_viewWillDisappear:animated];
    
    // [MobClick endLogPageView:NSStringFromClass([self class])];
}

@end

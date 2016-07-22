//
//  UITabBarController+Analytics.m
//  phoncol
//
//  Created by JustBen on 4/26/16.
//  Copyright © 2016 t8. All rights reserved.
//

#import "UITabBarController+Analytics.h"
#import "AnalyticsSwizzlean.h"
#import <mach/mach_time.h>

static uint64_t beginTime;
static uint64_t endTime;
static mach_timebase_info_data_t timebaseInfo;

@implementation UITabBarController (Analytics)

+ (void)load {
    // All methods that trigger height cache's invalidation
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL selectors[] = {
            @selector(viewDidLoad),
            @selector(setSelectedIndex:),
            @selector(setSelectedViewController:)
        };
        
        for (NSUInteger index = 0; index < sizeof(selectors) / sizeof(SEL); ++index) {
            SEL originalSelector = selectors[index];
            SEL swizzledSelector = NSSelectorFromString([@"as_" stringByAppendingString:NSStringFromSelector(originalSelector)]);
            
            as_swizzleSelector([self class], originalSelector, swizzledSelector);
        }
    });
}

//- (void)viewDidLoad
//{
//    [super viewDidLoad];
//}

- (void)as_viewDidLoad {
    if ([self respondsToSelector:@selector(as_viewDidLoad)]) {
        [self as_viewDidLoad];
    } else {
        
    }
    
    [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationWillEnterForegroundNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        
        beginTime = mach_absolute_time();
        
    }];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidEnterBackgroundNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        
        endTime = mach_absolute_time();
        if (timebaseInfo.denom == 0) {
            mach_timebase_info(&timebaseInfo);
        }
        uint64_t nanoseconds = (endTime - beginTime) * timebaseInfo.numer / timebaseInfo.denom;
        int seconds = (int)(nanoseconds/1000000000);
        // [MobClick logPageView:[self tabbarPageViewKeyWithIndex:self.selectedIndex] seconds:seconds];
        
    }];
}

- (void)as_setSelectedIndex:(NSUInteger)selectedIndex {
    [self as_setSelectedIndex:selectedIndex];
    beginTime = mach_absolute_time();
}

- (void)as_setSelectedViewController:(UIViewController *)selectedViewController {
    endTime = mach_absolute_time();
    if (timebaseInfo.denom == 0) {
        mach_timebase_info(&timebaseInfo);
    }
    uint64_t nanoseconds = (endTime - beginTime) * timebaseInfo.numer / timebaseInfo.denom;
    int seconds = (int)(nanoseconds/1000000000);
    // [MobClick logPageView:[self tabbarPageViewKeyWithIndex:self.selectedIndex] seconds:seconds];
    
    [self as_setSelectedViewController:selectedViewController];
    
    beginTime = mach_absolute_time();
}

- (NSString *)tabbarPageViewKeyWithIndex:(NSUInteger)index {
    NSString *pageViewKey = @"unknownPageViewKey";
    switch (index) {
        case 0: {
            pageViewKey = @"tabbar_articles";
        }
            break;
            
        case 1: {
            pageViewKey = @"tabbar_chat";
        }
            break;
            
        case 2: {
            pageViewKey = @"tabbar_discover";
        }
            break;
            
        case 3: {
            pageViewKey = @"tabbar_profile";
        }
            break;
            
        default:
            break;
    }
    
    return pageViewKey;
}

@end

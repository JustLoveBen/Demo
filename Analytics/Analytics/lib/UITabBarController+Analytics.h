//
//  UITabBarController+Analytics.h
//  phoncol
//
//  Created by JustBen on 4/26/16.
//  Copyright © 2016 t8. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBarController (Analytics)

/**
 *  每个TabBar对应的界面的pageViewKey
 *
 *  @param index tabbar的对应的index
 *
 *  @return pageViewKey
 */
- (NSString *)tabbarPageViewKeyWithIndex:(NSUInteger)index;

@end

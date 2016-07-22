//
//  PCAnalyticsManager.h
//  phoncol
//
//  Created by JustBen on 4/26/16.
//  Copyright © 2016 t8. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"

@interface PCAnalyticsManager : NSObject

AS_SINGLETON(PCAnalyticsManager)

/**
 *  启动统计
 */
- (void)startAnalytics;

@end

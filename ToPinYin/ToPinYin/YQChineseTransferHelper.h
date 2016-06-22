//
//  YQChineseTransferHelper.h
//  YunQue
//
//  Created by 琦张 on 14/11/24.
//  Copyright (c) 2014年 zhphy. All rights reserved.
//

#import <Foundation/Foundation.h>

// 单例模式
#undef	AS_SINGLETON
#define AS_SINGLETON( __class ) \
+ (__class *)sharedInstance;

#undef	DEF_SINGLETON
#define DEF_SINGLETON( __class ) \
+ (__class *)sharedInstance \
{ \
static dispatch_once_t once; \
static __class * __singleton__; \
dispatch_once( &once, ^{ __singleton__ = [[self alloc] init]; } ); \
return __singleton__; \
}


@interface YQChineseTransferHelper : NSObject

@property (nonatomic,strong) NSMutableDictionary *cacheDict;

AS_SINGLETON(YQChineseTransferHelper)

+ (NSString *)getCachedStrWithKey:(NSString *)chinese;
+ (void)save;

@end

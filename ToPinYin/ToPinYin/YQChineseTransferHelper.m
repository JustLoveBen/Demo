//
//  YQChineseTransferHelper.m
//  YunQue
//
//  Created by 琦张 on 14/11/24.
//  Copyright (c) 2014年 zhphy. All rights reserved.
//

#import "YQChineseTransferHelper.h"

@implementation YQChineseTransferHelper

DEF_SINGLETON(YQChineseTransferHelper)

- (id)init
{
    self = [super init];
    if (self) {
        self.cacheDict = [[[NSMutableDictionary alloc] initWithContentsOfFile:[YQChineseTransferHelper cachePath]] mutableCopy];
        if (self.cacheDict==nil) {
            self.cacheDict = [NSMutableDictionary dictionary];
        }
    }
    return self;
}

+ (NSString *)cachePath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachesDir = [paths objectAtIndex:0];
    return [cachesDir stringByAppendingPathComponent:@"chineseTransferCache.plist"];
}

+ (NSString *)getCachedStrWithKey:(NSString *)chinese
{
    NSString *result = [[YQChineseTransferHelper sharedInstance].cacheDict objectForKey:chinese];
    if (!result) {
        result = [YQChineseTransferHelper transferWithChinese:chinese];
        [[YQChineseTransferHelper sharedInstance].cacheDict setObject:result forKey:chinese];
    }
    return result;
}

+ (NSString *)transferWithChinese:(NSString *)chinese
{
    CFMutableStringRef string = CFStringCreateMutableCopy(NULL, 0, (__bridge CFMutableStringRef)[NSMutableString stringWithString:chinese]);
    CFStringTransform(string, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform(string, NULL, kCFStringTransformStripDiacritics, NO);
    NSMutableString *aNSString = (__bridge NSMutableString *)string;
    return aNSString;
}

+ (void)save
{
    NSDictionary *dict = [[YQChineseTransferHelper sharedInstance].cacheDict copy];
    if (dict) {
        [dict writeToFile:[YQChineseTransferHelper cachePath] atomically:YES];
    }
}

@end

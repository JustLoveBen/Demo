//
//  ToPinYin.m
//  ToPinYin
//
//  Created by JustBen on 4/18/16.
//  Copyright © 2016 JustBen. All rights reserved.
//

#import "ToPinYin.h"

@implementation ToPinYin

+ (const char)latinFromString:(NSString *)string
{
    NSString *tmpStr = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if (!tmpStr || tmpStr.length <= 0) {
        return '#';
    }
    
    CFMutableStringRef cfString = CFStringCreateMutableCopy(kCFAllocatorDefault, 0, (__bridge CFStringRef)tmpStr);
    CFStringTransform(cfString, NULL, kCFStringTransformToLatin, NO);
    CFStringTransform(cfString, NULL, kCFStringTransformStripCombiningMarks, NO);
    CFStringLowercase(cfString, CFLocaleGetSystem());
    
    char firstChar = CFStringGetCharacterAtIndex(cfString, 0);
    if (firstChar >= 'a' && firstChar <= 'z') {
        return firstChar;
    }
    
    return '#';
}

@end

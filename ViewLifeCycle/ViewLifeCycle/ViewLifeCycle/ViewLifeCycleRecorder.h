//
//  ViewLifeCycleRecorder.h
//  viewLifeCycle
//
//  Created by JustBen on 4/11/16.
//  Copyright © 2016 JustBen. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ViewLifeCycleRecorder <NSObject>

+ (void)swizzling;
+ (void)clearSwizzling;

@end

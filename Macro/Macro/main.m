//
//  main.m
//  Macro
//
//  Created by JustBen on 5/3/16.
//  Copyright © 2016 JustBen. All rights reserved.
//

#import <Foundation/Foundation.h>

#define FUN(IName) IName##_ptr

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
        
        int i = 0;
        printf("%d", FUN(i));
    }
    return 0;
}

//
//  main.m
//  Macro
//
//  Created by JustBen on 5/3/16.
//  Copyright © 2016 JustBen. All rights reserved.
//

#import <Foundation/Foundation.h>

#define RCT_EXPORT_MODULE(js_name) \
NSString *test() {return @#js_name;} \


#define FUN(IName) IName##_ptr


NSString *testt() {
    return @"rts";
}

RCT_EXPORT_MODULE(TTT)

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
        
//        int i = 0;
//        printf("%d", FUN(i));
        
        NSString *t = test();
        NSLog(@"%@", t);
    }
    return 0;
}

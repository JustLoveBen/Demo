//
//  Any.m
//  ProtocolArray
//
//  Created by JustBen on 7/12/16.
//  Copyright © 2016 JustBen. All rights reserved.
//

#import "Any.h"

@interface Any ()

@property (nonatomic, assign, readwrite) NSInteger anyTest;
@property (nonatomic, assign, readwrite) id<TestProtocol> test;

@end

@implementation Any

- (void)testAny
{
    self.anyTest = 1;
    
    self.test = nil;
    
    self.num = @(10);
}

@end

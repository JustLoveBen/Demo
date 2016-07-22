//
//  AnyProtocol.h
//  ProtocolArray
//
//  Created by JustBen on 7/12/16.
//  Copyright © 2016 JustBen. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TestProtocol <NSObject>

@end


@protocol AnyProtocol <NSObject>

@property (nonatomic, assign, readonly) NSInteger anyTest;

@property (nonatomic, assign, readonly) id<TestProtocol> test;

@property (nonatomic, strong) NSNumber *num;

@end

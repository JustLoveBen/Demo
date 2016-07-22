//
//  Any.h
//  ProtocolArray
//
//  Created by JustBen on 7/12/16.
//  Copyright © 2016 JustBen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AnyProtocol.h"

@interface Any : NSObject <AnyProtocol>

@property (nonatomic, assign) NSInteger index;

- (void)testAny;

@end

//
//  ViewController.m
//  ProtocolArray
//
//  Created by JustBen on 7/12/16.
//  Copyright © 2016 JustBen. All rights reserved.
//

#import "ViewController.h"
#import "Any.h"
#import "AnyProtocol.h"

@interface ViewController ()

@property (nonatomic, strong) NSMutableArray <Any *> *anys;
//@property (nonatomic, strong) NSMutableArray <AnyProtocol> *anys;

@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _anys = [[NSMutableArray alloc] init];
    
    Any *any1 = [[Any alloc] init];
    any1.index = 0;
    [any1 testAny];
    
    [_anys addObject:any1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

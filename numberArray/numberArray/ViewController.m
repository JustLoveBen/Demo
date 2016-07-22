//
//  ViewController.m
//  numberArray
//
//  Created by JustBen on 6/2/16.
//  Copyright © 2016 JustBen. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, copy) NSMutableArray *numArray;

@property (nonatomic, copy) NSMutableSet *numSet;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _numArray = [[NSMutableArray alloc] init];
    [self.numArray addObject:@(1)];
    [self.numArray addObject:@(2)];
    [self.numArray addObject:@(1)];
    
    NSLog(@"num array:%@", self.numArray);
    
    _numSet = [NSMutableSet set];
    [self.numSet addObject:@(1)];
    [self.numSet addObject:@(2)];
    [self.numSet addObject:@(1)];
    
    NSLog(@"num set:%@", self.numSet);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

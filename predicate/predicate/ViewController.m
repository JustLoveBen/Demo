//
//  ViewController.m
//  predicate
//
//  Created by JustBen on 6/12/16.
//  Copyright © 2016 JustBen. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSPredicate *predicate1 = [NSPredicate predicateWithFormat:@"user_id=%@", @"123"];
    NSPredicate *predicate2 = [NSPredicate predicateWithFormat:@"user_id=%@" arguments:@"123"];
    NSPredicate *predicate3 = [NSPredicate predicateWithFormat:@"user_id=?" argumentArray:@[@"123"]];
    
    NSLog(@"%@, %@, %@", predicate1, predicate2, predicate3);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

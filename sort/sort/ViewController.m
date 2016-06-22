//
//  ViewController.m
//  sort
//
//  Created by JustBen on 6/8/16.
//  Copyright © 2016 JustBen. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSArray *arr = @[@(7), @(0), @(2), @(11), @(7), @(4), @(23), @(1), @(3), @(0)];
    NSArray *a = [self sortedSeqsWithSeqs:arr];
    NSLog(@"%@", a);
    
    NSLog(@"%@", [a subarrayWithRange:NSMakeRange(0, 20)]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSArray *)sortedSeqsWithSeqs:(NSArray *)seqs
{
    NSAssert(seqs && seqs.count > 0, @"seqs为nil");
    
    NSArray *soredSeqs = [seqs sortedArrayUsingComparator:^NSComparisonResult(NSNumber *obj1, NSNumber *obj2) {
        if (obj1.integerValue > obj2.integerValue) {
            return NSOrderedDescending;
        } else if (obj1.integerValue < obj2.integerValue) {
            return NSOrderedAscending;
        } else {
            return NSOrderedSame;
        }
    }];
    
    return soredSeqs;
}

@end

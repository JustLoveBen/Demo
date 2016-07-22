//
//  ViewController.m
//  reg
//
//  Created by JustBen on 4/20/16.
//  Copyright © 2016 JustBen. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    NSString *regex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
//    
//    NSString *string = @"";
//    
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
//    BOOL isValid = [predicate evaluateWithObject:email];
//    if (isValid) {
//        NSLog(@"OK");
//    }
//    
    
    NSString *r = @"^((?!^distinct_id$|^original_id$|^time$|^event$|^properties$|^id$|^first_id$|^second_id$|^users$|^events$|^event$|^user_id$|^date$|^datetime$)[a-zA-Z_$][a-zA-Z\\d_$]{0,99})$";
    NSPredicate *p = [NSPredicate predicateWithFormat:@"SELF MATCHES[c] %@", r];
    if ([p evaluateWithObject:@"distinct"]) {
        NSLog(@"OK");
    } else {
        NSLog(@"NO");
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

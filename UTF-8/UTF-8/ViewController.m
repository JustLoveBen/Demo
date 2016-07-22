//
//  ViewController.m
//  UTF-8
//
//  Created by JustBen on 6/15/16.
//  Copyright © 2016 JustBen. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSString *chinese = @"中国";
    NSString *ascci = @"a1";
    
    NSString *tt = @"";
    NSString *ag = @" 短发 a 的 㚕😊";
    NSString *ll;
    
    NSLog(@"%d, %d, %d, %d", [chinese lengthOfBytesUsingEncoding:NSUTF8StringEncoding], [ascci lengthOfBytesUsingEncoding:NSUTF8StringEncoding], [tt lengthOfBytesUsingEncoding:NSUTF8StringEncoding], [ag lengthOfBytesUsingEncoding:NSUTF8StringEncoding]);
    
    char *chineseBytes = [chinese cStringUsingEncoding:NSUnicodeStringEncoding];
    char *ascciBytes = [ascci cStringUsingEncoding:NSUnicodeStringEncoding];
    char *ttBytes = [ag cStringUsingEncoding:NSUTF8StringEncoding];
    
    NSLog(@"%s, %s, %s", chineseBytes, ascciBytes, ttBytes);
    
    NSLog(@"chinese length:%d, ascci:%d, tt:%d", strlen(chineseBytes), strlen(ascciBytes), strlen(ttBytes));
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

//
//  ViewController.m
//  ToPinYin
//
//  Created by JustBen on 4/18/16.
//  Copyright © 2016 JustBen. All rights reserved.
//

#import "ViewController.h"
#import "ToPinYin.h"
#import "YQChineseTransferHelper.h"


@interface ViewController ()

@property (nonatomic, strong) NSArray *lastNames;

@property (nonatomic, strong) NSTimer *timer1;
@property (nonatomic, strong) NSTimer *timer2;
@property (nonatomic, strong) NSTimer *timer3;
@property (nonatomic, strong) NSTimer *timer4;
@property (nonatomic, strong) NSTimer *timer5;
@property (nonatomic, strong) NSTimer *timer6;

- (void)actionForTimer1;
- (void)actionForTimer2;
- (void)actionForTimer3;
- (void)actionForTimer4;
- (void)actionForTimer5;
- (void)actionForTimer6;

@property (nonatomic, copy) NSDictionary *names;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _lastNames = @[@"阿", @"史", @"豆", @"而", @"若", @"1", @"sfd", @"结", @"那", @"漂", @"宁", @"六", @"共", @"山", @"阿", @"斯", @"顿", @"发", @"晶", @"如", @"德", @"国", @"妇", @"女", @"教", @"师", @"的", @"理", @"科", @"生", @"的", @"烦", @"恼"];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"names" ofType:@"plist"];
    self.names = [[NSDictionary alloc] initWithContentsOfFile:path];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
//    NSString *t1 = [YQChineseTransferHelper getCachedStrWithKey:@"張中國"];
//    NSString *t2 = [YQChineseTransferHelper getCachedStrWithKey:@"Zhang"];
//    NSComparisonResult result = [t1 localizedCompare:t2];
//    
//    [YQChineseTransferHelper save];
//    
//    NSString *t = [YQChineseTransferHelper getCachedStrWithKey:[@"ヤコブ" substringToIndex:1]];
//    NSLog(@"%@", t);
//    
//    char c = [ToPinYin latinFromString:[@"ヤコブ" substringToIndex:1]];
//    NSLog(@"%c", c);
    
    [self startTest];
}

- (NSString *)randomLastName
{
    srand(time(0));
    return self.lastNames[random()%self.lastNames.count];
}

- (NSString*)firstLetterOfString:(NSString*)chinese
{
    NSString *aNSString = [YQChineseTransferHelper getCachedStrWithKey:chinese];
    NSString *finalString = [aNSString stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%c", 32] withString:@""];
    
    if (!finalString || finalString.length<1) {
        return @"#";
    }
    
    NSString *firstLetter = [[finalString substringToIndex:1]uppercaseString];
    if (!firstLetter||firstLetter.length<=0) {
        firstLetter = @"#";
    }else{
        unichar letter = [firstLetter characterAtIndex:0];
        if (letter<65||letter>90) {
            firstLetter = @"#";
        }
    }
    return firstLetter;
}


#pragma mark -
#pragma mark - Timers

- (void)startTest
{
    self.timer1 = [self timerWithTimeInterval:0.4 selector:@selector(actionForTimer1)];
    self.timer2 = [self timerWithTimeInterval:0.1 selector:@selector(actionForTimer2)];
    self.timer3 = [self timerWithTimeInterval:0.3 selector:@selector(actionForTimer3)];
    self.timer4 = [self timerWithTimeInterval:0.5 selector:@selector(actionForTimer4)];
    self.timer5 = [self timerWithTimeInterval:0.1 selector:@selector(actionForTimer5)];
    self.timer6 = [self timerWithTimeInterval:0.2 selector:@selector(actionForTimer6)];
}

- (NSTimer *)timerWithTimeInterval:(NSTimeInterval)timerInterval selector:(SEL)aSelector
{
    return [NSTimer scheduledTimerWithTimeInterval:timerInterval target:self selector:aSelector userInfo:nil repeats:YES];
}


- (void)actionForTimer1
{
    dispatch_async(dispatch_get_main_queue(), ^{
//        for (NSString *country in self.names.allKeys) {
//            [YQChineseTransferHelper getCachedStrWithKey:[self.names objectForKey:country]];
//        }
//        
//        dispatch_async(dispatch_get_main_queue(), ^{
            [YQChineseTransferHelper save];
//        });
    });
}

- (void)actionForTimer2
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
//        [YQChineseTransferHelper getCachedStrWithKey:[NSString stringWithFormat:@"%@王二蛋", [self randomLastName]]];
//        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [YQChineseTransferHelper save];
//        });
//        
//        for (NSString *country in self.names.allKeys) {
//            [YQChineseTransferHelper getCachedStrWithKey:[self.names objectForKey:country]];
//        }
//        
//        dispatch_async(dispatch_get_main_queue(), ^{
            [YQChineseTransferHelper save];
//        });
    });
}

- (void)actionForTimer3
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        
//        [YQChineseTransferHelper getCachedStrWithKey:[NSString stringWithFormat:@"%@王二蛋", [self randomLastName]]];
//        [YQChineseTransferHelper getCachedStrWithKey:[NSString stringWithFormat:@"%@二蛋", [self randomLastName]]];
//        [YQChineseTransferHelper getCachedStrWithKey:[NSString stringWithFormat:@"%@蛋", [self randomLastName]]];
//        [YQChineseTransferHelper getCachedStrWithKey:[NSString stringWithFormat:@"%@史蒂夫", [self randomLastName]]];
//        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [YQChineseTransferHelper save];
//        });
//        
//        for (NSString *country in self.names.allKeys) {
//            [YQChineseTransferHelper getCachedStrWithKey:[self.names objectForKey:country]];
//        }
//        
//        dispatch_async(dispatch_get_main_queue(), ^{
            [YQChineseTransferHelper save];
//        });
    });
}

- (void)actionForTimer4
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
//        [YQChineseTransferHelper getCachedStrWithKey:[NSString stringWithFormat:@"%@门口", [self randomLastName]]];
//        
//        dispatch_async(dispatch_get_main_queue(), ^{
            [YQChineseTransferHelper save];
//        });
    });
}

- (void)actionForTimer5
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
//        [YQChineseTransferHelper getCachedStrWithKey:[NSString stringWithFormat:@"%@反对撒", [self randomLastName]]];
//        
//        for (NSString *country in self.names.allKeys) {
//            [YQChineseTransferHelper getCachedStrWithKey:[self.names objectForKey:country]];
//        }
//        
//        dispatch_async(dispatch_get_main_queue(), ^{
            [YQChineseTransferHelper save];
//        });
    });
}

- (void)actionForTimer6
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        [YQChineseTransferHelper getCachedStrWithKey:[NSString stringWithFormat:@"%@%@", [self randomLastName], [self randomLastName]]];
//        [YQChineseTransferHelper getCachedStrWithKey:[NSString stringWithFormat:@"%@%@%@", [self randomLastName], [self randomLastName], [self randomLastName]]];
//        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [YQChineseTransferHelper save];
//        });
//        
//        for (NSString *country in self.names.allKeys) {
//            [YQChineseTransferHelper getCachedStrWithKey:[self.names objectForKey:country]];
//        }
//        
//        dispatch_async(dispatch_get_main_queue(), ^{
            [YQChineseTransferHelper save];
//        });
    });
}


@end

//
//  ViewController.m
//  sizeFit
//
//  Created by JustBen on 7/11/16.
//  Copyright © 2016 JustBen. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UILabel *label;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _contentView = [[UIView alloc] init];
    _contentView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:_contentView];
    
    _label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 300, 300)];
    _label.numberOfLines = 0;
    _label.text = @"test \n test \n test";
    _label.backgroundColor = [UIColor redColor];
    [_contentView addSubview:_label];
    
    NSLayoutConstraint *topLayoutConstraint = [[NSLayoutConstraint alloc] ini];
    
    NSLog(@"%@", NSStringFromCGSize([_label sizeThatFits:[UIScreen mainScreen].bounds.size]));
    
    NSLog(@"%@", NSStringFromCGRect([_label.text boundingRectWithSize:[UIScreen mainScreen].bounds.size options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: _label.font} context:NULL]));
    
    NSAttributedString *as = [[NSAttributedString alloc] initWithString:_label.text attributes:@{NSFontAttributeName: _label.font}];
    NSLog(@"%@", NSStringFromCGRect([as boundingRectWithSize:[UIScreen mainScreen].bounds.size options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin context:NULL]));
    
    [_label sizeToFit];
    
    NSLog(@"%@", NSStringFromCGRect(_label.frame));
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

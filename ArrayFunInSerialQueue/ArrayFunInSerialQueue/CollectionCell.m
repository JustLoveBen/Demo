//
//  CollectionCell.m
//  ArrayFunInSerialQueue
//
//  Created by JustBen on 4/13/16.
//  Copyright © 2016 JustBen. All rights reserved.
//

#import "CollectionCell.h"

@interface CollectionCell ()

@property (nonatomic, strong) UILabel *contentLabel;

@end

@implementation CollectionCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _contentLabel = [[UILabel alloc] initWithFrame:self.bounds];
        _contentLabel.font = [UIFont systemFontOfSize:20.0f];
        _contentLabel.textColor = [UIColor whiteColor];
        _contentLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_contentLabel];
    }
    
    return self;
}

- (void)updateUIWithContent:(NSString *)content
{
    self.contentLabel.text = content;
}

@end

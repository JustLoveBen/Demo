//
//  DetailViewController.h
//  subviews
//
//  Created by JustBen on 7/20/16.
//  Copyright © 2016 JustBen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end


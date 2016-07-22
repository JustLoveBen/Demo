//
//  ViewController.m
//  imageCompression
//
//  Created by JustBen on 6/16/16.
//  Copyright © 2016 JustBen. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UIImageView *imageView;

@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.imageView = [[UIImageView alloc] initWithFrame:UIEdgeInsetsInsetRect(self.view.bounds, UIEdgeInsetsMake(5, 5, 5, 5))];
    self.imageView.backgroundColor = [UIColor lightGrayColor];
    self.imageView.contentMode = UIViewContentModeCenter;
    [self.view addSubview:self.imageView];
    
    UIImage *image_12 = [UIImage imageNamed:@"IMG_0012.PNG"];
    
    NSLog(@"%f", UIImageJPEGRepresentation(image_12, 1.0f).length/(float)(1024 * 8));
    
    for (NSInteger i = 0; i <= 10; i++) {
        UIImage *compressedImage = [self compressImage:image_12 withCompressionQuality:0.1f * i];
        NSLog(@"%f, %@", UIImageJPEGRepresentation(compressedImage, 1.0f).length/(float)(1024 * 8), NSStringFromCGSize(compressedImage.size));
        self.imageView.image = compressedImage;
    }
}

- (UIImage *)compressImage:(UIImage *)image withCompressionQuality:(CGFloat)compressionQuality
{
    float actualHeight = image.size.height;
    float actualWidth = image.size.width;
    float maxHeight = 300.0f;
    float maxWidth = 400.0f;
    float imgRatio = actualWidth/actualHeight;
    float maxRatio = maxWidth/maxHeight;
    
    if (actualHeight > maxHeight || actualWidth > maxWidth) {
        if (imgRatio < maxRatio) {
            //  adjust width according to maxHeight
            imgRatio = maxHeight / actualHeight;
            actualWidth = imgRatio * actualWidth;
            actualHeight = maxHeight;
        } else if (imgRatio > maxRatio) {
            //  adjust height according to maxWidth
            imgRatio = maxWidth / actualWidth;
            actualHeight = imgRatio * actualHeight;
            actualWidth = maxWidth;
        } else {
            actualHeight = maxHeight;
            actualWidth = maxWidth;
        }
    }
    
    CGRect rect = CGRectMake(0.0, 0.0, actualWidth, actualHeight);
    
    UIGraphicsBeginImageContextWithOptions(rect.size, YES, 1.0f);
    [image drawInRect:rect];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();;
    UIGraphicsEndImageContext();
    
    NSData *imageData = UIImageJPEGRepresentation(img, compressionQuality);
    
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:[NSString stringWithFormat:@"t_%f", compressionQuality]];
    [imageData writeToFile:path atomically:YES];
    
    return [UIImage imageWithData:imageData];
}


- (BOOL)prefersStatusBarHidden
{
    return YES;
}

@end

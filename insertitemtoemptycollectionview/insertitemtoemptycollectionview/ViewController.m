//
//  ViewController.m
//  insertitemtoemptycollectionview
//
//  Created by JustBen on 4/11/16.
//  Copyright © 2016 JustBen. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, assign) NSInteger itemCount;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(60.0f, 60.0f);
    flowLayout.minimumLineSpacing = 10.0f;
    flowLayout.minimumInteritemSpacing = 10.0f;
    flowLayout.sectionInset = UIEdgeInsetsMake(10.0f, 10.0f, 10.0f, 10.0f);
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.dataSource = self;
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [self.view addSubview:_collectionView];
    
    
    _itemCount = 1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insert
{
    _itemCount += 10;
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < 10; i++) {
        [array addObject:[NSIndexPath indexPathForRow:i inSection:0]];
    }
    
    [self.collectionView insertItemsAtIndexPaths:array];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    
    for (int i = 0; i < 10; i++) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self insert];
        });
    }
    
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        
//        CFAbsoluteTime startTime = CFAbsoluteTimeGetCurrent();
//        
//        _itemCount += 1;
//        [self.collectionView insertItemsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]]];
//        
//        _itemCount--;
//        [self.collectionView deleteItemsAtIndexPaths:@[[NSIndexPath indexPathForRow:2 inSection:0]]];
//        
//        [self.collectionView moveItemAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0] toIndexPath:[NSIndexPath indexPathForRow:6 inSection:0]];
        
//        _itemCount++;
//        [self.collectionView insertItemsAtIndexPaths:@[[NSIndexPath indexPathForRow:1 inSection:0]]];
//        
//        _itemCount--;
//        [self.collectionView deleteItemsAtIndexPaths:@[[NSIndexPath indexPathForRow:4 inSection:0]]];
//        
//        [self.collectionView moveItemAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0] toIndexPath:[NSIndexPath indexPathForRow:6 inSection:0]];
//        
//        _itemCount++;
//        [self.collectionView insertItemsAtIndexPaths:@[[NSIndexPath indexPathForRow:1 inSection:0]]];
//        
//        _itemCount--;
//        [self.collectionView deleteItemsAtIndexPaths:@[[NSIndexPath indexPathForRow:7 inSection:0]]];
//        
//        [self.collectionView moveItemAtIndexPath:[NSIndexPath indexPathForRow:5 inSection:0] toIndexPath:[NSIndexPath indexPathForRow:6 inSection:0]];
//        
//        _itemCount++;
//        [self.collectionView insertItemsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]]];
//        
//        _itemCount--;
//        [self.collectionView deleteItemsAtIndexPaths:@[[NSIndexPath indexPathForRow:5 inSection:0]]];
//        
//        [self.collectionView moveItemAtIndexPath:[NSIndexPath indexPathForRow:6 inSection:0] toIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
//        
//        _itemCount++;
//        [self.collectionView insertItemsAtIndexPaths:@[[NSIndexPath indexPathForRow:2 inSection:0]]];
//        
//        _itemCount--;
//        [self.collectionView deleteItemsAtIndexPaths:@[[NSIndexPath indexPathForRow:7 inSection:0]]];
//        
//        [self.collectionView moveItemAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0] toIndexPath:[NSIndexPath indexPathForRow:8 inSection:0]];
//        
//        CFAbsoluteTime endTime = CFAbsoluteTimeGetCurrent();
//        
//        NSLog(@"time length:%f", endTime - startTime);
//    });
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self.collectionView performBatchUpdates:^{
//            CFAbsoluteTime startTime = CFAbsoluteTimeGetCurrent();
//            
//            _itemCount += 4;
//            [self.collectionView insertItemsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0], [NSIndexPath indexPathForRow:1 inSection:0], [NSIndexPath indexPathForRow:2 inSection:0], [NSIndexPath indexPathForRow:3 inSection:0]]];
//            
////            _itemCount--;
////            [self.collectionView deleteItemsAtIndexPaths:@[[NSIndexPath indexPathForRow:2 inSection:0]]];
////            
////            [self.collectionView moveItemAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0] toIndexPath:[NSIndexPath indexPathForRow:6 inSection:0]];
//            
////            _itemCount++;
////            [self.collectionView insertItemsAtIndexPaths:@[[NSIndexPath indexPathForRow:1 inSection:0]]];
////            
////            _itemCount--;
////            [self.collectionView deleteItemsAtIndexPaths:@[[NSIndexPath indexPathForRow:4 inSection:0]]];
////            
////            [self.collectionView moveItemAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0] toIndexPath:[NSIndexPath indexPathForRow:6 inSection:0]];
////            
////            _itemCount++;
////            [self.collectionView insertItemsAtIndexPaths:@[[NSIndexPath indexPathForRow:1 inSection:0]]];
////            
////            _itemCount--;
////            [self.collectionView deleteItemsAtIndexPaths:@[[NSIndexPath indexPathForRow:7 inSection:0]]];
////            
////            [self.collectionView moveItemAtIndexPath:[NSIndexPath indexPathForRow:5 inSection:0] toIndexPath:[NSIndexPath indexPathForRow:6 inSection:0]];
////            
////            _itemCount++;
////            [self.collectionView insertItemsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]]];
////            
////            _itemCount--;
////            [self.collectionView deleteItemsAtIndexPaths:@[[NSIndexPath indexPathForRow:5 inSection:0]]];
////            
////            [self.collectionView moveItemAtIndexPath:[NSIndexPath indexPathForRow:6 inSection:0] toIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
////            
////            _itemCount++;
////            [self.collectionView insertItemsAtIndexPaths:@[[NSIndexPath indexPathForRow:2 inSection:0]]];
////            
////            _itemCount--;
////            [self.collectionView deleteItemsAtIndexPaths:@[[NSIndexPath indexPathForRow:7 inSection:0]]];
////            
////            [self.collectionView moveItemAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0] toIndexPath:[NSIndexPath indexPathForRow:8 inSection:0]];
//            
//            CFAbsoluteTime endTime = CFAbsoluteTimeGetCurrent();
//            
//            NSLog(@"time length:%f", endTime - startTime);
//        } completion:^(BOOL finished) {
//            NSLog(@"finished");
//        }];
//    });
}

#pragma mark -
#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.itemCount;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    int row = indexPath.row;
    cell.backgroundColor = [UIColor colorWithRed:row/255.0f green:row/255.0f blue:row/255.0f alpha:1.0f];
    
    int j = 0;
    for (int i = 0; i < 1000; i++) {
        j += i;
    }
    
    return cell;
}


@end

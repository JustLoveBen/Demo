//
//  ViewController.m
//  ArrayFunInSerialQueue
//
//  Created by JustBen on 4/13/16.
//  Copyright © 2016 JustBen. All rights reserved.
//

#import "ViewController.h"
#import "CollectionCell.h"
#import "Swizzlean.h"
#import <objc/runtime.h>


@interface ViewController () <UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray *items;

@property (nonatomic, assign) NSInteger callIndex;
@property (nonatomic, strong) NSIndexPath *indexPath00;


@property (nonatomic, strong) NSTimer *asyncInsertTimer1;
@property (nonatomic, strong) NSTimer *asyncInsertTimer2;
@property (nonatomic, strong) NSTimer *syncInsertTimer;
@property (nonatomic, strong) NSTimer *asyncRemoveTimer1;
@property (nonatomic, strong) NSTimer *asyncRemoveTimer2;
@property (nonatomic, strong) NSTimer *reloadTimer;
- (void)actionForAsyncInsertTimer1;
- (void)actionForAsyncInsertTimer2;
- (void)actionForSyncInsertTimer;
- (void)actionForAsyncRemoveTimer1;
- (void)actionForAsyncRemoveTimer2;
- (void)actionForReloadTimer;

@property (nonatomic, strong) NSMutableString *callStack;
@property (nonatomic, strong) NSMutableString *countStack;

@end

@implementation ViewController


#pragma mark -
#pragma mark - dealloc

- (void)dealloc
{
    [_items removeAllObjects];
}

#pragma mark -
#pragma mark - init

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
//        _asyncInsertTimer1 = [self timerWithInterval:0.5 selector:@selector(actionForAsyncInsertTimer1)];
//        _asyncInsertTimer2 = [self timerWithInterval:4 selector:@selector(actionForAsyncInsertTimer2)];
//        _syncInsertTimer = [self timerWithInterval:1 selector:@selector(actionForSyncInsertTimer)];
//        _asyncRemoveTimer1 = [self timerWithInterval:3 selector:@selector(actionForAsyncRemoveTimer1)];
//        _asyncRemoveTimer2 = [self timerWithInterval:3 selector:@selector(actionForAsyncRemoveTimer2)];
//        _reloadTimer = [self timerWithInterval:30 selector:@selector(actionForReloadTimer)];
    }
    
    return self;
}

#pragma mark - 
#pragma mark - view life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _items = [[NSMutableArray alloc] init];
    _callIndex = 0;
    _indexPath00 = [NSIndexPath indexPathForRow:0 inSection:0];
    _callStack = [[NSMutableString alloc] init];
    _countStack = [[NSMutableString alloc] init];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(60.0f, 60.0f);
    flowLayout.minimumLineSpacing = 10.0f;
    flowLayout.minimumInteritemSpacing = 10.0f;
    flowLayout.sectionInset = UIEdgeInsetsMake(10.0f, 10.0f, 10.0f, 10.0f);
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.dataSource = self;
    [_collectionView registerClass:[CollectionCell class] forCellWithReuseIdentifier:@"cell"];
    [self.view addSubview:_collectionView];
    
    [self swizzleCollectionViewData];
    [self test];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self insertItemSync];
//    
//    [self startTest];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
//    [self endTest];
}

#pragma mark - 
#pragma mark - memory warning

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - 
#pragma mark - test funcs

- (void)startTest
{
    [self.syncInsertTimer fire];
    [self.asyncInsertTimer1 fire];
    [self.asyncInsertTimer2 fire];
    [self.asyncRemoveTimer1 fire];
    [self.asyncRemoveTimer2 fire];
    [self.reloadTimer fire];
}

- (void)endTest
{
    [self.asyncInsertTimer1 invalidate];
    [self.asyncInsertTimer2 invalidate];
    [self.syncInsertTimer invalidate];
    [self.asyncRemoveTimer1 invalidate];
    [self.asyncRemoveTimer2 invalidate];
    [self.reloadTimer invalidate];
}

#pragma mark -
#pragma mark - timer generation

- (NSTimer *)timerWithInterval:(NSTimeInterval)interval selector:(SEL)selector
{
    NSTimer *timer = [NSTimer timerWithTimeInterval:interval target:self selector:selector userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
    return timer;
}

#pragma mark -
#pragma mark - timer actions

- (void)actionForAsyncInsertTimer1
{
    [self insertItemAsync];
}

- (void)actionForAsyncInsertTimer2
{
    [self insertItemsAsyncWithCount:20];
}

- (void)actionForSyncInsertTimer
{
    [self insertItemSync];
}

- (void)actionForAsyncRemoveTimer1
{
    [self removeItemAsync];
}

- (void)actionForAsyncRemoveTimer2
{
    [self removeItemsAsyncWithCount:5];
}

- (void)actionForReloadTimer
{
    [self reloadAsyncWithCount:10];
}


#pragma mark -
#pragma mark - item funcs

- (void)insertItemAsync
{
    [self.callStack appendString:@" 0->"];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self insertItemSync];
    });
    
    [self.callStack appendString:@"<-0 "];
}

- (void)insertItemSync
{
    [self.callStack appendString:@" 1->"];
    
    _callIndex++;

//    NSLog(@"%d", [self numberItemsInCollectionView]);
    NSLog(@"%@", [self sectionItemCountsInCollectionView]);

    [_items addObject:[NSString stringWithFormat:@"%li - 0", (long)_callIndex]];
    [_collectionView insertItemsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]]];
    
//    NSLog(@"%d", [self numberItemsInCollectionView]);
    NSLog(@"%@", [self sectionItemCountsInCollectionView]);
    
    [self.callStack appendString:@"<-1 "];
}

- (void)removeItemAsync
{
    [self.callStack appendString:@" 2->"];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self removeItemSync];
    });
    
    [self.callStack appendString:@"<-2 "];
}

- (void)removeItemSync
{
    [self.callStack appendString:@" 3->"];
    
    NSInteger count = _items.count;
    if (count <= 0) {
        return;
    }
    
    _callIndex++;
    
    NSInteger index = random()%count;
    [self.callStack appendFormat:@"d:%li", (long)index];
    
    [_items removeObjectAtIndex:index];
    [_collectionView deleteItemsAtIndexPaths:@[[NSIndexPath indexPathForRow:index inSection:0]]];
    
    [self.callStack appendString:@"<-3 "];
}

- (void)insertItemsAsyncWithCount:(NSInteger)count
{
    [self.callStack appendString:@" 4->"];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self insertItemsSyncWithCount:count];
    });
    
    [self.callStack appendString:@"<-4 "];
}

- (void)insertItemsSyncWithCount:(NSInteger)count
{
    [self.callStack appendString:@" 5->"];
    
    if (count <= 0) {
        return;
    }
    
    _callIndex++;
    
    NSMutableArray *items = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < count; i++) {
        [items addObject:[NSString stringWithFormat:@"%li - %li", (long)_callIndex, (long)i]];
    }
    [_items addObjectsFromArray:items];
    
    NSMutableArray *indexPaths = [[NSMutableArray alloc] init];
    [items enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [indexPaths addObject:[NSIndexPath indexPathForRow:[_items indexOfObject:obj] inSection:0]];
    }];
    
    [_collectionView insertItemsAtIndexPaths:indexPaths];
    
    [self.callStack appendString:@"<-5 "];
}

- (void)removeItemsAsyncWithCount:(NSInteger)count
{
    [self.callStack appendString:@" 6->"];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self removeItemsSyncWithCount:count];
    });
    
    [self.callStack appendString:@"<-6 "];
}

- (void)removeItemsSyncWithCount:(NSInteger)count
{
    [self.callStack appendString:@" 7->"];
    
    if (count <= 0) {
        return;
    }
    
    NSInteger totalCount = _items.count;
    if (totalCount <= 0) {
        return;
    }
    
    _callIndex++;
    
    NSMutableIndexSet *indexs = [[NSMutableIndexSet alloc] init];
    NSMutableArray *indexPaths = [[NSMutableArray alloc] init];
    
    for (NSInteger i = 0; i < count; ) {
        NSInteger index = random()%totalCount;
        if (![indexs containsIndex:index]) {
            [indexs addIndex:index];
            [indexPaths addObject:[NSIndexPath indexPathForRow:index inSection:0]];
            
            i++;
        }
    }
    
    [self.callStack appendFormat:@"d:%@", indexs];
    
    [_items removeObjectsAtIndexes:indexs];
    [_collectionView deleteItemsAtIndexPaths:indexPaths];
    
    [self.callStack appendString:@"<-7 "];
}

- (void)reloadAsyncWithCount:(NSInteger)count
{
    [self.callStack appendString:@" 8->"];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self reloadSyncWithCount:count];
    });
    
    [self.callStack appendString:@"<-8 "];
}

- (void)reloadSyncWithCount:(NSInteger)count
{
    [self.callStack appendString:@" 9->"];
    
    if (count < 0) {
        return;
    }
    
    _callIndex++;
    
    [_items removeAllObjects];
    
    NSMutableArray *items = [[NSMutableArray alloc] init];
    NSMutableArray *indexPaths = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < count; i++) {
        [items addObject:[NSString stringWithFormat:@"%li - %li", (long)_callIndex, (long)i]];
        [indexPaths addObject:[NSIndexPath indexPathForRow:i inSection:0]];
    }
    [_items addObjectsFromArray:items];
    
    NSLog(@"%@", [self sectionItemCountsInCollectionView]);
    [_collectionView reloadSections:[NSIndexSet indexSetWithIndex:0]];
//    [_collectionView reloadData];
    NSLog(@"%@", [self sectionItemCountsInCollectionView]);
    
    _callIndex = 0;
    
    [self.callStack appendString:@"<-9 "];
}


#pragma mark -
#pragma mark - number items in collection view

- (int)numberItemsInCollectionView
{
    id collectionViewData = [self.collectionView valueForKey:@"collectionViewData"];
    if (collectionViewData) {
        id numItems = [collectionViewData valueForKey:@"numItems"];
        if (numItems) {
            return ((NSNumber *)numItems).intValue;
        }
    }
    
    return 0;
}

- (NSArray *)sectionItemCountsInCollectionView
{
    id collectionViewData = [self.collectionView valueForKey:@"collectionViewData"];
    if (collectionViewData) {
//        if ([collectionViewData respondsToSelector:@selector(numberOfItemsInSection:)]) {
//            [collectionViewData performSelector:@selector(numberOfItemsInSection:) withObject:@1];
//            NSLog(@"----");
//        }
//        id sectionItemCounts = [collectionViewData valueForKey:@"globalItems"];
//        if (sectionItemCounts) {
//            return sectionItemCounts;
//        }
        
        if ([collectionViewData respondsToSelector:@selector(numberOfSections)]) {
            [collectionViewData performSelector:@selector(numberOfSections)];
        }
        
        if ([collectionViewData valueForKey:@"class"]) {
//            id sectionItemCounts = [collectionViewData valueForKey:@"globalItems"];
//            if (sectionItemCounts) {
//                return sectionItemCounts;
//            }
        }
        
        return nil;
    }
    
    return nil;
}

#pragma mark -
#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSLog(@"=========");
    return _items.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    NSInteger row = indexPath.row;
    cell.backgroundColor = [UIColor colorWithRed:row/255.0f green:row/255.0f blue:row/255.0f alpha:1.0f];
    
    NSString *content = _items[row];
    if (content && content.length > 0) {
        [cell updateUIWithContent:content];
    }
    
    return cell;
}


#pragma mark -
#pragma mark - Swizzle

- (void)swizzleCollectionViewData
{
    swizzInstance(NSClassFromString(@"UICollectionViewData"),@selector(numberOfSections),@selector(jb_numberOfSections));
    
////    Swizzlean *swizzle = [[Swizzlean alloc] initWithClassToSwizzle:NSClassFromString(@"UICollectionViewData")];
//    Swizzlean *swizzle = [[Swizzlean alloc] initWithClassToSwizzle:[self class]];
//    [swizzle swizzleInstanceMethod:@selector(test) withReplacementImplementation:^(id _self) {
//        NSLog(@"=========================");
////        int num = [_self performSelector:@selector(test)];
////        return num;
//    }];
}

- (void)test
{
    NSLog(@"--------------------------test---------------------------");
}

- (void)newTest
{
    NSLog(@"==========================test===========================");
}

- (int)jb_numberOfSections
{
    NSLog(@"++++++++++");
    
    return 1;
}

static void swizzInstance(Class class, SEL originalSelector, SEL swizzledSelector)
{
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    
    BOOL didAddMethod =
    class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod)
    {
        class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod),method_getTypeEncoding(originalMethod));
    }
    else
    {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

@end

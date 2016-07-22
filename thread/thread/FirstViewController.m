//
//  FirstViewController.m
//  thread
//
//  Created by JustBen on 6/6/16.
//  Copyright © 2016 JustBen. All rights reserved.
//

#import "FirstViewController.h"
#import <pthread/pthread.h>


typedef void(^WriteBlock)();

@interface FirstViewController ()
{
    pthread_mutex_t _dbWriteLock;
}

@property (nonatomic, strong) NSSet *runLoopModes;
@property (nonatomic, copy) WriteBlock writeBlock;

- (void)runDBWriteBlock;

@end

@implementation FirstViewController

- (void)dealloc
{
    pthread_mutex_destroy(&_dbWriteLock);
}

- (id)init
{
    self = [super init];
    if (self) {
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    pthread_mutex_init(&_dbWriteLock, NULL);
    _runLoopModes = [NSSet setWithObject:NSRunLoopCommonModes];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    
    [self performOnDBWriteThreadWithBlock:^{
        NSInteger i = 0;
        i = 2;
        NSLog(@"%i", i);
    }];
}

+ (void)networkRequestThreadEntryPoint:(id)__unused object {
    @autoreleasepool {
        [[NSThread currentThread] setName:@"AFNetworking"];
        
        NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
        [runLoop addPort:[NSMachPort port] forMode:NSDefaultRunLoopMode];
        [runLoop run];
    }
}

+ (NSThread *)networkRequestThread {
    static NSThread *_networkRequestThread = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _networkRequestThread = [[NSThread alloc] initWithTarget:self selector:@selector(networkRequestThreadEntryPoint:) object:nil];
        [_networkRequestThread start];
    });
    
    return _networkRequestThread;
}

+ (void)dbWriteThreadPointer:(id)__unused object
{
    [[NSThread currentThread] setName:@"com.tinfinite.database.write"];
    NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
    [runLoop addPort:[NSMachPort port] forMode:NSDefaultRunLoopMode];
    [runLoop run];
}

+ (NSThread *)dbWriteThread
{
    static NSThread *_dbWriteThread = nil;
    static dispatch_once_t onceTokenForDBWriteThread;
    dispatch_once(&onceTokenForDBWriteThread, ^{
        _dbWriteThread = [[NSThread alloc] initWithTarget:self selector:@selector(dbWriteThreadPointer:) object:nil];
        [_dbWriteThread start];
    });
    
    return _dbWriteThread;
}

- (void)performOnDBWriteThreadWithBlock:(void (^)())block
{
//    [self performSelector:@selector(runDBWriteBlock)];
    
    pthread_mutex_lock(&_dbWriteLock);
    self.writeBlock = block;
//    [self performSelector:@selector(runDBWriteBlock) onThread:[NSThread mainThread] withObject:nil waitUntilDone:NO modes:[self.runLoopModes allObjects]];
    
//    [self performSelectorOnMainThread:@selector(runDBWriteBlock) withObject:nil waitUntilDone:NO];
    
    [self performSelector:@selector(runDBWriteBlock) onThread:[[self class] dbWriteThread] withObject:nil waitUntilDone:NO];
    
    pthread_mutex_unlock(&_dbWriteLock);
}

- (void)runDBWriteBlock
{
    if (self.writeBlock) {
        self.writeBlock();
    }
    
    //    block([RLMRealm defaultRealm]);
}

@end

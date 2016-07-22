//
//  Singleton.h
//  Analytics
//
//  Created by JustBen on 5/9/16.
//  Copyright © 2016 JustBen. All rights reserved.
//

#ifndef Singleton_h
#define Singleton_h

#undef AS_SINGLETON
#define AS_SINGLETON(classname) + (instancetype)sharedInstance;

#define DEF_SINGLETON
#define DEF_SINGLETON(classname) \
static id shared##classname; \
\
+ (instancetype)allocWithZone:(struct _NSZone *)zone \
{ \
static dispatch_once_t onceTokenFor##classname; \
dispatch_once(&onceTokenFor##classname, ^{ \
shared##classname = [super allocWithZone:zone]; \
}); \
return shared##classname; \
} \
\
+ (instancetype)sharedInstance \
{ \
static dispatch_once_t onceTokenFor##classname; \
dispatch_once(&onceTokenFor##classname, ^{ \
shared##classname = [[self alloc] init]; \
}); \
return shared##classname; \
} \
\
- (id)copyWithZone:(NSZone *)zone \
{ \
return shared##classname; \
}

#endif /* Singleton_h */

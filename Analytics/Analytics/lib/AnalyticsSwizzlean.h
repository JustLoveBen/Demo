//
//  AnalyticsSwizzlean.h
//  phoncol
//
//  Created by JustBen on 4/26/16.
//  Copyright © 2016 t8. All rights reserved.
//

#ifndef AnalyticsSwizzlean_h
#define AnalyticsSwizzlean_h

#include <objc/runtime.h>

void as_swizzleSelector(Class class, SEL originalSelector, SEL swizzledSelector);
BOOL as_addMethod(Class class, SEL selector, Method method);

#endif /* AnalyticsSwizzlean_h */

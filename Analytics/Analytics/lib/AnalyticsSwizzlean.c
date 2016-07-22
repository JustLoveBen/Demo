//
//  AnalyticsSwizzlean.c
//  phoncol
//
//  Created by JustBen on 4/26/16.
//  Copyright © 2016 t8. All rights reserved.
//

#include "AnalyticsSwizzlean.h"

void as_swizzleSelector(Class class, SEL originalSelector, SEL swizzledSelector) {
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    method_exchangeImplementations(originalMethod, swizzledMethod);
}

BOOL as_addMethod(Class class, SEL selector, Method method) {
    return class_addMethod(class, selector,  method_getImplementation(method),  method_getTypeEncoding(method));
}

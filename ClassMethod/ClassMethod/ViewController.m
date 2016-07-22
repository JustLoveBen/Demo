//
//  ViewController.m
//  ClassMethod
//
//  Created by JustBen on 5/5/16.
//  Copyright © 2016 JustBen. All rights reserved.
//

#import "ViewController.h"
#import <objc/message.h>

#define msgSend(obj, selector, ...) ((id (*)(id, SEL, ...))objc_msgSend)(obj, selector, ##__VA_ARGS__)

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    /// An opaque type that represents an Objective-C class.
//    typedef struct objc_class *Class;
//    
//    /// Represents an instance of a class.
//    struct objc_object {
//        Class isa  OBJC_ISA_AVAILABILITY;
//    };
//    
//    /// A pointer to an instance of a class.
//    typedef struct objc_object *id;
    
    Class arrayClass = [NSMutableArray class];
    SEL arraySelector = @selector(array);
    SEL addObjectSelector = @selector(addObject:);
    
//    id obj = arrayClass;
//    id array = [obj performSelector:arraySelector];
//    [array performSelector:addObjectSelector withObject:@(1)];
//    
//    id result = ((id (*)(id, SEL))objc_msgSend)(obj, arraySelector);
//    id num = @(1);
//    ((id (*)(id, SEL, id))objc_msgSend)(result, addObjectSelector, num);
//    ((id (*)(id, SEL, ...))objc_msgSend)(result, addObjectSelector, num);
//    
//    NSLog(@"%@", result);
//    
    id result = [self performWithClass:arrayClass selector:arraySelector argv:NULL];
//    ((id (*)(id, SEL, id))objc_msgSend)(result, addObjectSelector, num);
    
    msgSend(result, addObjectSelector, @(2));
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (id)performWithClass:(Class)class selector:(SEL)selector argv:(id *)argv
{
    if (!class || !selector) {
        return nil;
    }
    
    id result;
    if (argv) {
        switch (sizeof(argv)/sizeof(id)) {
            case 0: {
                result = ((id (*)(id, SEL, ...))objc_msgSend)(class, selector);
            }
                break;
                
            case 1: {
                result = ((id (*)(id, SEL, ...))objc_msgSend)(class, selector, argv[0]);
            }
                break;
                
            case 2: {
                result = ((id (*)(id, SEL, ...))objc_msgSend)(class, selector, argv[0], argv[1]);
            }
                break;
                
            case 3: {
                result = ((id (*)(id, SEL, ...))objc_msgSend)(class, selector, argv[0], argv[1], argv[2]);
            }
                break;
            default: {
                result = ((id (*)(id, SEL, ...))objc_msgSend)(class, selector);
            }
                break;
        }
    } else {
        result = ((id (*)(id, SEL, ...))objc_msgSend)(class, selector);
    }
    
    return result;
}

@end

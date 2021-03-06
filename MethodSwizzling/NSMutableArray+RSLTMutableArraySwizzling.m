//
//  NSMutableArray+RSLTMutableArraySwizzling.m
//  RedStarMain
//
//  Created by LT on 17/6/8.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "NSMutableArray+RSLTMutableArraySwizzling.h"

@implementation NSMutableArray (RSLTMutableArraySwizzling)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Method startMethod = class_getInstanceMethod(objc_getClass("__NSArrayM"), @selector(objectAtIndex:));
        Method endMethod = class_getInstanceMethod(objc_getClass("__NSArrayM"), @selector(rslt_objectAtIndex:));
        method_exchangeImplementations(startMethod, endMethod);
        
    });
}

- (id)rslt_objectAtIndex:(NSUInteger)index {
    
    if (self.count-1 < index) {
        @try {
            return [self rslt_objectAtIndex:index];
        }
        @catch (NSException *exception) {
            NSLog(@"%s崩溃，由于%s", class_getName(self.class), __func__);
            NSLog(@"崩溃信息=%@", [exception callStackSymbols]);
            return nil;
        }
        @finally {}
    }
    else {
        return [self rslt_objectAtIndex:index];
    }
}



@end

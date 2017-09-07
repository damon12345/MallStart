//
//  NSMutableDictionary+RSLTMutableDictionarySwizzling.m
//  RedStarMain
//
//  Created by LT on 17/6/8.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "NSMutableDictionary+RSLTMutableDictionarySwizzling.h"

@implementation NSMutableDictionary (RSLTMutableDictionarySwizzling)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Method startMethod = class_getInstanceMethod(objc_getClass("__NSDictionaryM"), @selector(setObject:forKey:));
        Method endMethod = class_getInstanceMethod(objc_getClass("__NSDictionaryM"), @selector(rslt_setObject:forKey:));
        method_exchangeImplementations(startMethod, endMethod);
        
    });
}

- (void)rslt_setObject:(NSString *)object forKey:(NSString *)forKey{

    if (object && forKey){
        
        [self rslt_setObject:object forKey:forKey];
    }else{
        
        @try {
            [self rslt_setObject:object forKey:forKey];
        } @catch (NSException *exception) {
            NSLog(@"%s崩溃，由于%s", class_getName(self.class), __func__);
            NSLog(@"崩溃信息=%@", [exception callStackSymbols]);
            
        } @finally {}
        
    }
    
}


@end

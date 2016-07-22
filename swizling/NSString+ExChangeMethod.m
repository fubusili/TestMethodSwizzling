//
//  NSString+ExChangeMethod.m
//  swizling
//
//  Created by hc_cyril on 16/4/29.
//  Copyright © 2016年 Clark. All rights reserved.
//

#import "NSString+ExChangeMethod.h"
#import <objc/runtime.h>

@implementation NSString (ExChangeMethod)
+ (void)load {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = NSClassFromString(@"__NSStringI");
        [self class];
        swizzleeMethod(class, @selector(substringFromIndex:), @selector(sSubstringFromIndex:));
        
    });
    
}

- (id)sSubstringFromIndex:(id)aKey {
    
    return [self sSubstringFromIndex:aKey];
    //    return [NSObject noNull:[self noNullObjectForKey:aKey]];
    
}

void swizzleeMethod(Class class,SEL originalSelector,SEL swizzleSelector){
    //class_getInstanceMethod返回 class的名称为selector的方法
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzleSelector);
    //method_getImplementation  返回method的实现指针
    BOOL didAddMethod = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    if(didAddMethod){
        //class_replaceMethod  替换函数实现  函数  originalMethod 用swizzleSelector  替换
        class_replaceMethod(class, swizzleSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        
    }else{
        //交换两个IMP是实现指针
        method_exchangeImplementations(originalMethod, swizzledMethod);
        
    }
    
}

@end

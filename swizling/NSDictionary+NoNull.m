//
//  NSDictionary+NoNull.m
//  hucai
//
//  Created by hc_cyril on 16/4/29.
//
//

#import "NSDictionary+NoNull.h"
#import <objc/runtime.h>
//#import "NSObject+NoNullObject.h"

@implementation NSDictionary (NoNull)
+ (void)load {

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = NSClassFromString(@"__NSDictionaryI");
        swizzleMethod(class, @selector(objectForKey:), @selector(noNullObjectForKey:));
        
    });

}

- (id)noNullObjectForKey:(id)aKey {
    
    if ([aKey isEqualToString:@"a"]) {
        return [self noNullObjectForKey:aKey];
    }
    return [self noNullObjectForKey:aKey];
    
//    return [NSObject noNull:[self noNullObjectForKey:aKey]];

}

void swizzleMethod(Class class,SEL originalSelector,SEL swizzleSelector){
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

//
//  UITableView+TableViewContentSizeCategory.m
//  ScrollAndScroll
//
//  Created by YongLeiChu on 09/03/2018.
//  Copyright © 2018 YongLeiChu. All rights reserved.
//

#import "UITableView+TableViewContentSizeCategory.h"
#import <objc/runtime.h>

@implementation UITableView (TableViewContentSizeCategory)

//+ (void)load {
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        Class class = [self class];
//
//        SEL originalSelector = @selector(setContentOffset:);
//        SEL swizzledSelector = @selector(customSetContentOffset:);
//
//        Method originalMethod = class_getInstanceMethod(class, originalSelector);
//        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
//
//        BOOL success = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
//        if (success) {
//            class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
//        } else {
//            method_exchangeImplementations(originalMethod, swizzledMethod);
//        }
//    });
//}
//
//- (void)customSetContentOffset:(CGPoint)point {
//    CGFloat contentSizeHeight = point.y;
//    if (self.contentSize.height < 300 + [UIScreen mainScreen].bounds.size.height) {
//        contentSizeHeight = 300 + [UIScreen mainScreen].bounds.size.height;
//        self.contentInset = UIEdgeInsetsMake(0, 0, contentSizeHeight, 0);
//    }
//    [self customSetContentOffset:CGPointMake(0, contentSizeHeight)];
//}

@end

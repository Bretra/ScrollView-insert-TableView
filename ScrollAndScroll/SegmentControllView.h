//
//  SegmentControllView.h
//  ScrollAndScroll
//
//  Created by YongLeiChu on 2018/3/19.
//  Copyright © 2018年 YongLeiChu. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SegmentControllView : UIView
@property (nonatomic, copy) void(^clickIndexBlock)(NSInteger index);
- (void)setSegmentControlEvent:(NSInteger)index;

@end

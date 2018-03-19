//
//  SegmentControllView.m
//  ScrollAndScroll
//
//  Created by YongLeiChu on 2018/3/19.
//  Copyright © 2018年 YongLeiChu. All rights reserved.
//

#import "SegmentControllView.h"

@implementation SegmentControllView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        for (int i = 0; i < 3; i++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(i * [UIScreen mainScreen].bounds.size.width / 3, 0, [UIScreen mainScreen].bounds.size.width / 3, self.frame.size.height);
            [btn setTitle:[NSString stringWithFormat:@"%d",i] forState:UIControlStateNormal];
            btn.backgroundColor = [UIColor blueColor];
            [self addSubview:btn];
            btn.tag = i;
            [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    return self;
}

- (void)click:(UIButton *)btn {
    if (self.clickIndexBlock) {
        self.clickIndexBlock(btn.tag);
    }
}

- (void)setSegmentControlEvent:(NSInteger)index {
    for (int i = 0; i < self.subviews.count; i++) {
        UIView *view = self.subviews[i];
        if (index == i) {
            view.backgroundColor = [UIColor grayColor];
        }else {
            view.backgroundColor = [UIColor blueColor];
        }
    }
}
@end

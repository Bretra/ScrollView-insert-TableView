//
//  ViewController.m
//  ScrollAndScroll
//
//  Created by YongLeiChu on 09/03/2018.
//  Copyright © 2018 YongLeiChu. All rights reserved.
//

#import "ViewController.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"

#import "HeaderView.h"
#import "SegmentControllView.h"

#define KW [UIScreen mainScreen].bounds.size.width
#define KH [UIScreen mainScreen].bounds.size.height

@interface ViewController ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) HeaderView *headerView;
@property (nonatomic, strong) SegmentControllView *segmentControll;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    FirstViewController *firstVC = [[FirstViewController alloc] init];
    SecondViewController *secondVC = [[SecondViewController alloc] init];
    ThirdViewController *thirdVC = [[ThirdViewController alloc] init];
    
    firstVC.view.frame = CGRectMake(0, 0, KW, KH);
    secondVC.view.frame = CGRectMake(KW, 0, KW, KH);
    thirdVC.view.frame = CGRectMake(KW * 2, 0, KW, KH);
    
    [self addChildViewController:firstVC];
    [self addChildViewController:secondVC];
    [self addChildViewController:thirdVC];
    
    [self.view addSubview:self.scrollView];
    [_scrollView addSubview:firstVC.view];
    [_scrollView addSubview:secondVC.view];
    [_scrollView addSubview:thirdVC.view];
    
    self.headerView = [[HeaderView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 300)];
    [self.view addSubview:self.headerView];
    _headerView.backgroundColor = [UIColor orangeColor];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 200, 100)];
    [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [_headerView addSubview:btn];
    btn.backgroundColor = [UIColor redColor];
    btn.center = _headerView.center;
    self.segmentControll = [[SegmentControllView alloc] initWithFrame:CGRectMake(0, 300, [UIScreen mainScreen].bounds.size.width, 50)];
    _segmentControll.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:self.segmentControll];
    [_segmentControll setSegmentControlEvent:0];
    __weak ViewController *weakSelf = self;
    _segmentControll.clickIndexBlock = ^(NSInteger index) {
        [weakSelf.scrollView setContentOffset:CGPointMake([UIScreen mainScreen].bounds.size.width * index, 0) animated:NO];
    };
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(xx:) name:@"kScrollView" object:nil];
}

- (void)click:(UIButton *)btn {
    [[[UIAlertView alloc] initWithTitle:@"click me" message:@"wa ha ha" delegate:self cancelButtonTitle:@"sure" otherButtonTitles:nil] show];
}

- (void)xx:(NSNotification *)noti {
    NSDictionary *dic = noti.object;
    NSInteger index = _scrollView.contentOffset.x / KW;
    UIViewController *vc = self.childViewControllers[index];
    if (![dic[@"currentScrollViewControllerName"] isEqualToString:NSStringFromClass([vc class])]) {
        return;
    }
    NSLog(@"%@", dic);
    CGRect headerFrame = self.headerView.frame;
    CGFloat yMargin = [dic[@"scrollOffset"] CGPointValue].y;
    if (yMargin>= 300) {
        yMargin = 300;
    }
    if (yMargin <= 0) {
        yMargin = 0;
    }
    headerFrame.origin.y = -yMargin;
    _headerView.frame = headerFrame;
    
    CGRect rect = _segmentControll.frame;
    rect.origin.y = 300 - yMargin;
    _segmentControll.frame = rect;
    
    //设置其他vc scrollview的偏移量
    [self subchildViewControllersWithIndex:index andCurrentScrollOffsetY:yMargin];
    
}

- (NSArray<UIViewController*> *)subchildViewControllersWithIndex:(NSInteger)index andCurrentScrollOffsetY:(CGFloat)currentScrollOffsetY {
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:2];
    for (int i = 0; i < self.childViewControllers.count; i++) {
        if (i != index) {
            [array addObject:self.childViewControllers[i]];
            UIViewController *vc = self.childViewControllers[i];
            UITableView *tableView = vc.view.subviews.firstObject;
            [tableView setContentOffset:CGPointMake(0, currentScrollOffsetY)];
        }
    }
    return [array copy];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSInteger scrollIndex = scrollView.contentOffset.x / [UIScreen mainScreen].bounds.size.width;
    [_segmentControll setSegmentControlEvent:scrollIndex];
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        _scrollView.contentSize = CGSizeMake(KW * 3, KH);
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
    }
    return _scrollView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

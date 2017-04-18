//
//  ViewController.m
//  DYScrollSegmentDemo
//
//  Created by Daniel Yao on 17/4/10.
//  Copyright © 2017年 Daniel Yao. All rights reserved.
//

#import "ViewController.h"
#import "DYSegmentView.h"
#import "DYVCSegmentOne.h"
#import "DYVCSegmentTwo.h"

@interface ViewController ()<UIScrollViewDelegate,DYSegmentDelegate>

@property(nonatomic,strong)DYSegmentView *dySegment;

@property(nonatomic,strong)UIScrollView *scrollView;

@property(nonatomic,strong)DYVCSegmentOne *vcOne;

@property(nonatomic,strong)DYVCSegmentTwo *vcTwo;

@end

@implementation ViewController
-(DYSegmentView *)dySegment{
    if (!_dySegment) {
        _dySegment = [[DYSegmentView alloc]initWithFrame:CGRectMake(ScreenWidth/2-120, 25, 240, 44)];
        _dySegment.delegate         = self;
        _dySegment.backgroundColor  = [UIColor clearColor];
        _dySegment.titleNormalColor = UIColorFromRGB(0xffffff, 0.5);
        _dySegment.titleSelectColor = UIColorFromRGB(0xffffff, 0.9);
        _dySegment.titleFont        = [UIFont systemFontOfSize:15];
        _dySegment.titleArray       = @[@"在线",@"附近"];
    }
    return _dySegment;
}
-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView  = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        _scrollView.delegate = self;
        _scrollView.showsHorizontalScrollIndicator  = NO;
        _scrollView.showsVerticalScrollIndicator    = NO;
        _scrollView.contentSize     = CGSizeMake(ScreenWidth * 2, ScreenHeight);
        _scrollView.pagingEnabled   = YES;
        _scrollView.bounces         = NO;

    }
    return _scrollView;
}
-(DYVCSegmentOne *)vcOne{
    if (!_vcOne) {
        _vcOne = [[DYVCSegmentOne alloc]init];
        _vcOne.view.backgroundColor = UIColorFromRGB(0xffffff, 0.3);
    }
    return _vcOne;
}
-(DYVCSegmentTwo *)vcTwo{
    if (!_vcTwo) {
        _vcTwo = [[DYVCSegmentTwo alloc]init];
        _vcTwo.view.backgroundColor = UIColorFromRGB(0xffffff, 0.7);
    }
    return _vcTwo;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self configNavigationBar];
    [self initWithScrollView];
}
- (void)configNavigationBar
{
    self.navigationController.navigationBar.shadowImage=[UIImage new];
    [ self.navigationController.navigationBar setBarTintColor:UIColorFromRGB(0x000000, 1.0)];//纯粹为了界面好看
    
    self.navigationItem.titleView = self.dySegment;
}
-(void)initWithScrollView{
    [self.view addSubview:self.scrollView];
    [self addChildViewController:self.vcOne];
    [self addChildViewController:self.vcTwo];
    
    self.vcOne.view.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    self.vcTwo.view.frame = CGRectMake(ScreenWidth, 0, ScreenWidth, ScreenHeight);
    [self.scrollView addSubview:self.vcOne.view];
    [self.scrollView addSubview:self.vcTwo.view];
}

#pragma mark - UIScrollDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [_dySegment dyDidScrollChangeTheTitleColorWithContentOfSet:scrollView.contentOffset.x];
}
#pragma mark - DYSegmentDelegate
-(void)dySegment:(DYSegmentView *)segment didSelectIndex:(NSInteger)index{
    NSString *notiStr;
    if (index == 1) {
        notiStr = @"1";
    }else{
        notiStr = @"2";
    }
    self.scrollView.contentOffset = CGPointMake(ScreenWidth*(index-1), 0);
    [[NSNotificationCenter defaultCenter] postNotificationName:@"MainViewScrollDidScroll" object:notiStr];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

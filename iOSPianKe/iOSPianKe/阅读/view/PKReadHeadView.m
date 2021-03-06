//
//  PKReadHeadView.m
//  iOSPianKe
//
//  Created by ma c on 16/2/1.
//  Copyright © 2016年 赵金鹏. All rights reserved.
//

#import "PKReadHeadView.h"
#import "Masonry.h"

@interface PKReadHeadView()<UIScrollViewDelegate>

@end

@implementation PKReadHeadView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        [self.scrollView addSubview:self.imageView1];
        [self.scrollView addSubview:self.imageView2];
        [self.scrollView addSubview:self.imageView3];
        
        [self addSubview:self.scrollView];
        [self addSubview:self.pageCoutrol];
        
        [self addAutoLayout];
        
    }
    return self;
}

- (void)addAutoLayout {
    WS(weakSelf);
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    [_imageView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.scrollView.mas_left);
        make.top.equalTo(weakSelf.scrollView.mas_top);
        make.size.equalTo(CGSizeMake(VIEW_WIDTH, 150));
    }];
    
    [_imageView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.imageView1.mas_right);
        make.top.equalTo(weakSelf.scrollView.mas_top);
        make.size.equalTo(CGSizeMake(VIEW_WIDTH, 150));
    }];
    
    [_imageView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.imageView2.mas_right);
        make.top.equalTo(weakSelf.scrollView.mas_top);
        make.size.equalTo(CGSizeMake(VIEW_WIDTH, 150));
    }];
    
    [_pageCoutrol mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.mas_right).offset(-10);
        make.bottom.equalTo(weakSelf.mas_bottom).offset(-10);
        make.size.equalTo(CGSizeMake(60, 20));
    }];
    
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        // 开启用户交互
        _scrollView.userInteractionEnabled = YES;
        // 开启分页效果
        _scrollView.pagingEnabled = YES;
        // 关闭界面反弹效果
        [_scrollView setBounces:NO];
        // 设置横向滚动条关闭
        [_scrollView setShowsHorizontalScrollIndicator:NO];
        // 设置scollView内容视图的大小
        _scrollView.contentSize = CGSizeMake(VIEW_WIDTH*3, self.frame.size.height);
        // 当前视图位置
        //        self.scrollView.contentOffset = CGPointMake(0, 0);
        self.scrollView.delegate = self;
        
    }
    return _scrollView;
}


- (UIPageControl *)pageCoutrol {
    if (!_pageCoutrol) {
        _pageCoutrol = [[UIPageControl alloc] init];
        // 设置圆点个数
        [_pageCoutrol setNumberOfPages:3];
        // 设置透明度
        //    [pageControl setAlpha:0.3];
        // 关闭用户交互
        _pageCoutrol.userInteractionEnabled = NO;
        
        // 设置当前圆钮亮起的位置
        _pageCoutrol.currentPage = 0;
    }
    return _pageCoutrol;
}
#pragma mark- UIScrollViewDelegate
// 实现UIScrollView的 滚动方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // 获取滚动的x方向的偏移值
    CGFloat offsetX = scrollView.contentOffset.x;
    // 用x方向的偏移的值除以一张图片的宽度，取商就是当前滚动到了第几页
    NSInteger page = offsetX/_scrollView.frame.size.width;
    // 将页码设置给UIPageControl
    _pageCoutrol.currentPage = page;
}

- (UIImageView *)imageView1 {
    if (!_imageView1) {
        _imageView1 = [[UIImageView alloc] init];
    }
    return _imageView1;
}

- (UIImageView *)imageView2 {
    if (!_imageView2) {
        _imageView2 = [[UIImageView alloc] init];
    }
    return _imageView2;
}

- (UIImageView *)imageView3 {
    if (!_imageView3) {
        _imageView3 = [[UIImageView alloc] init];
    }
    return _imageView3;
}



@end


















//
//  PKReadHeadView.h
//  iOSPianKe
//
//  Created by ma c on 16/2/1.
//  Copyright © 2016年 赵金鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PKReadHeadView : UIView

// 头部scrollView
@property (strong, nonatomic) UIScrollView* scrollView;
@property (strong, nonatomic) UIPageControl* pageCoutrol;
// scrollView里的三个imageView
@property (strong, nonatomic) UIImageView* imageView1;
@property (strong, nonatomic) UIImageView* imageView2;
@property (strong, nonatomic) UIImageView* imageView3;
// 保存数据的数组
@property (strong, nonatomic) NSMutableArray* headArray;
// 保存下面数据的数组
@property (strong, nonatomic) NSMutableArray* downArray;

@end

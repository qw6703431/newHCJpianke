//
//  PKReadViewController.m
//  iOSPianKe
//
//  Created by ma c on 16/1/19.
//  Copyright © 2016年 赵金鹏. All rights reserved.
//

#import "PKReadViewController.h"
#import "Masonry.h"
#import "UIImageView+SDWedImage.h" // 加载网络图片
#import "PKReadHeadView.h"

@interface PKReadViewController ()<UIScrollViewDelegate>

// nav左面的按钮和lebel
@property (strong, nonatomic) UIButton* leftBtn;
@property (strong, nonatomic) UILabel* leftLabel;

@property (strong, nonatomic) PKReadHeadView* readHeadView;

// 保存数据的数组
@property (strong, nonatomic) NSMutableArray* headArray;
// 保存下面数据的数组
@property (strong, nonatomic) NSMutableArray* downArray;

@end

@implementation PKReadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.view addSubview:self.readHeadView];

    [self addAutoLayout];
    [self POSTHttpRead];
    
    [self navigationBtn];
    
    // Do any additional setup after loading the view.
}

- (void)addAutoLayout {
    WS(weakSelf);
    [_readHeadView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view.mas_top).offset(64);
        make.left.equalTo(weakSelf.view.mas_left);
        make.right.equalTo(weakSelf.view.mas_right);
        make.height.equalTo(150);
    }];
    
}

- (void)POSTHttpRead {
    // 制作请求参数
    NSDictionary* dic = @{@"auth":	@"W8c8Fivl9flDCsJzH8HukzJxQMrm3N7KP9Wc5WTFjcWP229VKTBRU7vI",
                          @"client":@"1",
                          @"deviceid":@"A55AF7DB-88C8-408D-B983-D0B9C9CA0B36",
                          @"version":@"3.0.6"};
    WS(weakSelf);
    [self POSTHttpRequest:@"http://api2.pianke.me/read/columns" dic:dic successBalck:^(id JSON) {
        NSDictionary* returnDic = JSON;
        if ([returnDic[@"result"] integerValue] == 1) {
            if (weakSelf.headArray == nil) {
                weakSelf.headArray = [[NSMutableArray alloc] init];
            }
            weakSelf.headArray = [returnDic[@"data"] valueForKey:@"carousel"];
            if (weakSelf.downArray == nil) {
                weakSelf.downArray = [[NSMutableArray alloc] init];
            }
            weakSelf.downArray = [returnDic[@"data"] valueForKey:@"list"];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf imageViewDownLoad];
            });
        }
    } errorBlock:^(NSError *error) {
        
    }];
}

// 加载图片
- (void)imageViewDownLoad {
    
    [self.readHeadView.imageView1 downloadImage:[self.headArray[0] valueForKey:@"img"]];
    [self.readHeadView.imageView2 downloadImage:[self.headArray[1] valueForKey:@"img"]];
    [self.readHeadView.imageView3 downloadImage:[self.headArray[2] valueForKey:@"img"]];
}

- (PKReadHeadView *)readHeadView {
    if (!_readHeadView) {
        _readHeadView = [[PKReadHeadView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    }
    return _readHeadView;
}


- (void)navigationBtn {
    // 自定义导航栏左边按钮样式
    _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_leftBtn setFrame:CGRectMake(0, 0, 40, 40)];
    [_leftBtn setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
    [_leftBtn setImage:[UIImage imageNamed:@"菜单"] forState:(UIControlStateNormal)];
    // 导航栏按钮图片的偏移量
    [_leftBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 0)];
    // 导航栏按钮文字的偏移量
    //    [_leftBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    [_leftBtn addTarget:self action:@selector(leftAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* leftBtn = [[UIBarButtonItem alloc] initWithCustomView:_leftBtn];
    
    UIView* leftView = [[UIView alloc] init];
    leftView.backgroundColor = [UIColor grayColor];
    leftView.frame = CGRectMake(35, -2, 1, 44);
    [_leftBtn addSubview:leftView];
    
    _leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 20)];
    _leftLabel.text = @"阅读";
    _leftLabel.font = [UIFont systemFontOfSize:15.0];
    UIBarButtonItem* leftLa = [[UIBarButtonItem alloc] initWithCustomView:_leftLabel];
    
    // 设置左侧按钮
    [self.navigationItem setLeftBarButtonItems:@[leftBtn,leftLa] animated:YES];
}
// nav左边按钮所响应的事件
- (void)leftAction:(id)sender {
    // 跳到抽屉
    [self presentLeftMenuViewController:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

//
//  ViewController.m
//  123456
//
//  Created by 杨利 on 17/3/7.
//  Copyright © 2017年 吴明伟. All rights reserved.
//

#import "ViewController.h"
#import "WMWShareBaseView.h"
#import "OneModel.h"

#define kDEVICEWIDTH [UIScreen mainScreen].bounds.size.width
#define kDEVICEHEIGHT [UIScreen mainScreen].bounds.size.height

@interface ViewController ()
@property (nonatomic, strong) WMWShareBaseView *shareView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *_loginButton = [[UIButton alloc]initWithFrame:CGRectMake(40, 220, kDEVICEWIDTH - 40 * 2, 40)];
    [_loginButton setTitle:@"hello world" forState:UIControlStateNormal];
    _loginButton.backgroundColor = [UIColor grayColor];
    [_loginButton addTarget:self action:@selector(loadClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_loginButton];
    
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)loadClicked
{
    // 传输数据
    // 第一行为四个固定按钮 修改属性值在WMWShareBtnView.m中，点击方法在最底部
    // 下面的按钮为可变按钮，会根据数据源的变化而变化，View高度会自动适应，点击方法在底部
    
    NSArray *dataArray = @[
                          @{@"title": @"测试1", @"iamgeUrl": @"share_platform_qqfriends@2x", @"skipUrl": @"http://www.baidu.com"},
                          @{@"title": @"测试2", @"iamgeUrl": @"share_platform_wechattimeline@2x", @"skipUrl": @"http://www.baidu.com"},
                          @{@"title": @"测试3", @"iamgeUrl": @"share_platform_wechat@2x", @"skipUrl": @"http://www.baidu.com"},
                          @{@"title": @"测试4", @"iamgeUrl": @"share_platform_qqfriends@2x", @"skipUrl": @"http://www.baidu.com"},
                          @{@"title": @"测试1", @"iamgeUrl": @"share_platform_wechattimeline@2x", @"skipUrl": @"http://www.baidu.com"},
                          @{@"title": @"测试4", @"iamgeUrl": @"share_platform_qqfriends@2x", @"skipUrl": @"http://www.baidu.com"},
                          @{@"title": @"测试1", @"iamgeUrl": @"share_platform_wechattimeline@2x", @"skipUrl": @"http://www.baidu.com"},
                          @{@"title": @"测试2", @"iamgeUrl": @"share_platform_qqfriends@2x", @"skipUrl": @"http://www.baidu.com"},
                          @{@"title": @"测试3", @"iamgeUrl": @"share_platform_wechat@2x", @"skipUrl": @"http://www.baidu.com"},
                          @{@"title": @"测试4", @"iamgeUrl": @"share_platform_wechattimeline@2x", @"skipUrl": @"http://www.baidu.com"}];
    
    NSMutableArray *tempArray = [NSMutableArray array];
    for (NSDictionary *dic in dataArray) {
        OneModel *oneModel = [[OneModel alloc] init];
        [oneModel setValuesForKeysWithDictionary:dic];
        [tempArray addObject:oneModel];
    }
    
    _shareView = [[WMWShareBaseView alloc] initWithCollectionDataArray:tempArray];
    [_shareView showInView:self.view];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

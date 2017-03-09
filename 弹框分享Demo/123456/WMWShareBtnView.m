//
//  WMWShareBtnView.m
//  123456
//
//  Created by 杨利 on 17/3/8.
//  Copyright © 2017年 吴明伟. All rights reserved.
//

#import "WMWShareBtnView.h"
#import "WMWShareCollectionView.h"

#define kDEVICEWIDTH [UIScreen mainScreen].bounds.size.width
#define kDEVICEHEIGHT [UIScreen mainScreen].bounds.size.height
#define BUTTON_WIDTH_HEIGHT ([UIScreen mainScreen].bounds.size.width - 100) / 4// buttonView 宽高

@interface WMWShareBtnView ()

@property (nonatomic , copy) NSArray *dataArray;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, assign) CGFloat contentViewHeight;
@property (nonatomic, strong) WMWShareCollectionView *shareCollectionView;

@end

@implementation WMWShareBtnView

- (id)initWithDataArray:(NSArray *)dataArray ContentViewHeight:(CGFloat)contentViewHeight {
    
    self = [super init];
    if (self) {
        self.contentViewHeight = contentViewHeight;
        self.dataArray = dataArray;
    }
    return self;
}

#pragma mark --- 创建固定按钮
- (UIView *)setFiexdShareView {
    
#warning 需要修改数据
    // 添加固定分享按钮
    NSArray *btnTitleArr = @[@"微信", @"QQ", @"微博", @"多图"];
    NSArray *btnImageNameArr = @[@"share_platform_wechat",
                                 @"share_platform_wechattimeline",
                                 @"share_platform_qqfriends",
                                 @"share_platform_wechattimeline"];
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDEVICEWIDTH, self.contentViewHeight)];
    for (int i = 0; i < btnTitleArr.count; i++) {
        UIView *btnView = [self setShareButtonTitle:btnTitleArr[i] BtnImg:btnImageNameArr[i] index:i];
        btnView.tag = 1000 + i;
        [btnView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(btnViewClicked:)]];
        [backView addSubview:btnView];
    }
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(15, BUTTON_WIDTH_HEIGHT + 5, kDEVICEWIDTH - 30, 1)];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [backView addSubview:lineView];
    
    
    UIView *collectionBackView = [[UIView alloc] initWithFrame:CGRectMake(0, BUTTON_WIDTH_HEIGHT + 6, kDEVICEWIDTH, self.contentViewHeight - 55 - BUTTON_WIDTH_HEIGHT)];
    self.shareCollectionView = [[WMWShareCollectionView alloc] initWithCollectionDataArray:self.dataArray];
    [collectionBackView addSubview:[self.shareCollectionView setCollectionShareView]];
    [backView addSubview:collectionBackView];
    
    
    return backView;
}

#pragma mark --- 固定按钮属性
- (UIView *)setShareButtonTitle:(NSString *)tittle BtnImg:(NSString *)img index:(int)index {
    NSInteger margin = ((kDEVICEWIDTH - 30) - BUTTON_WIDTH_HEIGHT * 4) / 3;
    UIView *btnVview = [[UIView alloc] initWithFrame: CGRectMake(15 + margin * index + BUTTON_WIDTH_HEIGHT * index, 0, BUTTON_WIDTH_HEIGHT, BUTTON_WIDTH_HEIGHT)];
    
    UIImageView *weChaImg = [[UIImageView alloc] initWithFrame:CGRectMake(13, 4, BUTTON_WIDTH_HEIGHT - 26, BUTTON_WIDTH_HEIGHT - 24)];
    weChaImg.image = [UIImage imageNamed:img];
    [btnVview addSubview:weChaImg];
    
    UILabel *titLab = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(weChaImg.frame), BUTTON_WIDTH_HEIGHT, 20)];
    titLab.font = [UIFont systemFontOfSize:13.0f];
    titLab.textAlignment = NSTextAlignmentCenter;
    titLab.text = tittle;
    [btnVview addSubview:titLab];
    return btnVview;
}

#pragma mark --- 固定按钮点击方法
- (void) btnViewClicked:(UITapGestureRecognizer *)recognizer {
    //发出通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"titleCall" object:self userInfo:nil];
    switch (recognizer.view.tag) {
        case 1000 :
        {
            NSLog(@"微信");
        }
            break;
        case 1001 :
        {
            NSLog(@"朋友圈");
        }
            break;
        case 1002 :
        {
            NSLog(@"QQ");
        }
            break;
        case 1003 :
        {
            NSLog(@"多图");
        }
            break;
        default:
            break;
    }
    
}

@end

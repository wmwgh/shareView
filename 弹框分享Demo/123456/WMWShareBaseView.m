//
//  WMWShareBaseView.m
//  123456
//
//  Created by 杨利 on 17/3/8.
//  Copyright © 2017年 吴明伟. All rights reserved.
//

#import "WMWShareBaseView.h"
#import "WMWShareBtnView.h"


#define kDEVICEWIDTH [UIScreen mainScreen].bounds.size.width
#define kDEVICEHEIGHT [UIScreen mainScreen].bounds.size.height

@interface WMWShareBaseView() 

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) WMWShareBtnView *shareBtnView;
@property (nonatomic, assign) CGFloat contentViewHeight;
@property (nonatomic, assign) NSInteger linesOfCollection;
@property (nonatomic , copy) NSArray *collectionDataArray;

@end

@implementation WMWShareBaseView

// 获取数据
- (id)initWithCollectionDataArray:(NSArray *)collectionDataArray {
    self = [super init];
    if (self) {
        self.collectionDataArray = collectionDataArray;
        NSInteger linesCount = collectionDataArray.count / 4;
        if (collectionDataArray.count % 4 != 0) {
            self.linesOfCollection = linesCount + 1;
        } else {
            self.linesOfCollection = linesCount;
        }
        CGFloat temp = 0;
        // 计算lines 设置collection的行数
        if (self.linesOfCollection < 2) {
            temp = (([UIScreen mainScreen].bounds.size.width - 100) / 4 + 12) * self.linesOfCollection;
        } else {
            // 大于2行是 只显示两行
            temp = (([UIScreen mainScreen].bounds.size.width - 100) / 4 + 12) * 2;
        }
        self.contentViewHeight = temp + 55 + ([UIScreen mainScreen].bounds.size.width - 100) / 4;
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(disMissView)
                                                     name:@"titleCall"
                                                   object:nil];
        [self initContent];
    }
    return self;
}

- (void)initContent
{
    self.frame = CGRectMake(0, 0, kDEVICEWIDTH, kDEVICEHEIGHT);
    self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(disMissView)]];
    
    if (self.contentView == nil)
    {
        [self setContentView];
    }
}

- (void)setContentView {
    self.contentView = [[UIView alloc]initWithFrame:CGRectMake(0, kDEVICEHEIGHT - self.contentViewHeight, kDEVICEWIDTH, self.contentViewHeight)];
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    // 有固定按钮和collection的分享
    UIView *fixedBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDEVICEWIDTH, self.contentViewHeight)];
    self.shareBtnView = [[WMWShareBtnView alloc] initWithDataArray:self.collectionDataArray ContentViewHeight:self.contentViewHeight];
    [fixedBackView addSubview:[self.shareBtnView setFiexdShareView]];
    [self.contentView addSubview:fixedBackView];
        
    //  添加取消按钮
    [self cancelBtn];
    [self addSubview:self.contentView];
}

- (void)cancelBtn {
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame = CGRectMake(0, self.contentViewHeight - 50, kDEVICEWIDTH, 50);
    [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cancelBtn setTitle:@"取       消" forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(disMissView) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:cancelBtn];
}

//展示从底部向上弹出的UIView（包含遮罩）
- (void)showInView:(UIView *)view
{
    if (!view) {
        return;
    }
    [view addSubview:self];
    [view addSubview:_contentView];
    
    [_contentView setFrame:CGRectMake(0, kDEVICEHEIGHT, kDEVICEWIDTH, self.contentViewHeight)];
    
    [UIView animateWithDuration:0.3 animations:^{
        [_contentView setFrame:CGRectMake(0, kDEVICEHEIGHT - self.contentViewHeight, kDEVICEWIDTH, self.contentViewHeight)];
    } completion:nil];
}

//移除从上向底部弹下去的UIView（包含遮罩）
- (void)disMissView
{
    [UIView animateWithDuration:0.3f
                     animations:^{
                         [_contentView setFrame:CGRectMake(0, kDEVICEHEIGHT, kDEVICEWIDTH, self.contentViewHeight)];
                     }
                     completion:^(BOOL finished){
                         [self removeFromSuperview];
                         [_contentView removeFromSuperview];
                     }];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"titleCall" object:nil];
}

@end

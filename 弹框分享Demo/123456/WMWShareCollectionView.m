//
//  WMWShareCollectionView.m
//  123456
//
//  Created by 杨利 on 17/3/9.
//  Copyright © 2017年 吴明伟. All rights reserved.
//

#import "WMWShareCollectionView.h"
#import "ShareButtonCell.h"

#define kDEVICEWIDTH [UIScreen mainScreen].bounds.size.width
#define kDEVICEHEIGHT [UIScreen mainScreen].bounds.size.height
#define BUTTON_WIDTH_HEIGHT ([UIScreen mainScreen].bounds.size.width - 100) / 4// buttonView 宽高

#define SHARE_CONTENT_VIEW_HEIGHT self.contentViewHeight // 分享最底层View的高
#define SHARE_COLLECTION_VIEW_HEIGHT self.collectionHeight // collection的高

@interface WMWShareCollectionView () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic , copy) NSArray *collectionDataArray;
@property (nonatomic, assign) CGFloat collectionHeight;
@property (nonatomic, assign) CGFloat contentViewHeight;
@property (nonatomic, assign) NSInteger linesOfCollection;
@property (nonatomic , strong) UICollectionView *shareCollectionView;
@end

@implementation WMWShareCollectionView

- (id)initWithCollectionDataArray:(NSArray *)collectionDataArray {
    
    self = [super init];
    if (self) {
        
        self.collectionDataArray = collectionDataArray;
        // 计算collectionView 动态的高度
        [self setShareViewFrame];
    }
    return self;
}

- (void)setShareViewFrame {
    NSInteger count = [self.collectionDataArray count];
    NSInteger linesCount = count / 4;
    if (count % 4 != 0) {
        self.linesOfCollection = linesCount + 1;
    } else {
        self.linesOfCollection = linesCount;
    }
    
    // 计算lines 设置collection的行数
    if (self.linesOfCollection < 2) {
        self.collectionHeight = (BUTTON_WIDTH_HEIGHT + 12) * self.linesOfCollection;
    } else {
        // 大于2行是 只显示两行
        self.collectionHeight = (BUTTON_WIDTH_HEIGHT + 12) * 2;
    }
    self.contentViewHeight = self.collectionHeight + 55 + BUTTON_WIDTH_HEIGHT;
}

- (UIView *)setCollectionShareView {
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDEVICEWIDTH, SHARE_COLLECTION_VIEW_HEIGHT)];
    UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout new];
    // 1.定义collectionView的样式
    flowLayout = [[UICollectionViewFlowLayout alloc] init];
    // 给定item的大小
    flowLayout.itemSize = CGSizeMake(BUTTON_WIDTH_HEIGHT, BUTTON_WIDTH_HEIGHT);
    // 每两个item的最小间隙（垂直滚动）
    flowLayout.minimumInteritemSpacing = 15;
    // 每两个item的最小间隙（水平滚动方向）
    flowLayout.minimumLineSpacing = 15;
    // 设置滚动方向
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;// 垂直方向
    // 设置视图的内边距（上左下右）
    flowLayout.sectionInset = UIEdgeInsetsMake(3, 15, 3, 15);
    
    self.shareCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kDEVICEWIDTH, SHARE_COLLECTION_VIEW_HEIGHT) collectionViewLayout:flowLayout];
    self.shareCollectionView.backgroundColor = [UIColor whiteColor];
    self.shareCollectionView.delegate = self;        //实现代理
    self.shareCollectionView.dataSource = self;      //实现数据源方法
    self.shareCollectionView.showsHorizontalScrollIndicator = NO;
    //注册cell，通过创建的CollectionCell
    [self.shareCollectionView registerNib:[UINib nibWithNibName:@"ShareButtonCell" bundle:nil] forCellWithReuseIdentifier:@"CELL"];
    [backView addSubview:self.shareCollectionView];
    return backView;
}

#pragma mark UICollectionViewDataSource的代理方法
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.collectionDataArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ShareButtonCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CELL" forIndexPath:indexPath];
    cell.oneModel = self.collectionDataArray[indexPath.row];
    return cell;
}

#pragma mark UICollectionViewDelegate的代理方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%ld", indexPath.row);
}


@end

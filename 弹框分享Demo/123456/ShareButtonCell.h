//
//  ShareButtonCell.h
//  123456
//
//  Created by 杨利 on 17/3/7.
//  Copyright © 2017年 吴明伟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OneModel.h"

@interface ShareButtonCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UILabel *shareBtnTittle;
@property (strong, nonatomic) IBOutlet UIImageView *shareBtnImg;
@property (nonatomic, strong) OneModel *oneModel;

@end

//
//  ShareButtonCell.m
//  123456
//
//  Created by 杨利 on 17/3/7.
//  Copyright © 2017年 吴明伟. All rights reserved.
//

#import "ShareButtonCell.h"

@implementation ShareButtonCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setOneModel:(OneModel *)oneModel{
    _oneModel = oneModel;
    _shareBtnTittle.text = oneModel.title;
    _shareBtnImg.image = [UIImage imageNamed:oneModel.iamgeUrl];
}

@end

//
//  ReduceCell.m
//  Limit_1509
//
//  Created by qianfeng on 15/7/29.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "ReduceCell.h"
#import "UIImageView+WebCache.h"

@implementation ReduceCell



-(void)configModel:(LimitModel *)model index:(NSInteger)index
{
    if (index % 2 == 0) {
        self.bgImageView.image = [UIImage imageNamed:@"cate_list_bg1"];
    }else{
        self.bgImageView.image = [UIImage imageNamed:@"cate_list_bg2"];
    }
    [self.leftImageView sd_setImageWithURL:[NSURL URLWithString:model.iconUrl]];
    self.titleLabel.text = [NSString stringWithFormat:@"%@",model.currentPrice];
    NSString *lastPrice = [NSString stringWithFormat:@"%@",model.lastPrice];
    NSDictionary *dic = @{NSStrikethroughStyleAttributeName:@1};
    NSAttributedString *str = [[NSAttributedString alloc] initWithString:lastPrice attributes:dic];
    self.lastPriceLabel.attributedText = str;
    [self.myStarView setRating:model.starCurrent.floatValue];
    self.typeLabel.text = model.categoryName;
    self.shareLabel.text = [NSString stringWithFormat:@"%@",model.favorites];
    self.downloaderLabel.text = [NSString stringWithFormat:@"%@",model.downloads];
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

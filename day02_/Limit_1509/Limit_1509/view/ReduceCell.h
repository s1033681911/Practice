//
//  ReduceCell.h
//  Limit_1509
//
//  Created by qianfeng on 15/7/29.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StarView.h"
#import "LimitModel.h"

@interface ReduceCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UIImageView *leftImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *curPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastPriceLabel;
@property (weak, nonatomic) IBOutlet StarView *myStarView;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *shareLabel;
@property (weak, nonatomic) IBOutlet UILabel *favoriteLabel;
@property (weak, nonatomic) IBOutlet UILabel *downloaderLabel;

-(void)configModel:(LimitModel *)model index:(NSInteger)index;

@end

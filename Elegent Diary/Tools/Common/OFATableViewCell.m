//
//  OFATableViewCell.m
//  OnceForAll
//
//  Created by lwhldy on 2017/7/6.
//  Copyright © 2017年 lwhldy. All rights reserved.
//

#import "OFATableViewCell.h"

@implementation OFATableViewCell

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setOFAstyle];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setOFAstyle];
    }
    return self;
}

- (void)setOFAstyle {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self setOFAstyle];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self setOFAstyle];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

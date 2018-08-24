//
//  ListSectionHeaderView.m
//  Elegent Diary
//
//  Created by lwhldy on 2017/8/23.
//  Copyright © 2017年 lwhldy. All rights reserved.
//

#import "ListSectionHeaderView.h"

@interface ListSectionHeaderView ()

@property (weak, nonatomic) IBOutlet UILabel *monthLabel;


@end

@implementation ListSectionHeaderView

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setMonthLabelText:(NSString *)text {
    NSString *month = [text componentsSeparatedByString:@"-"].lastObject;
    if (month.length == 2) {
        NSString *front = [month substringToIndex:1];
        if ([front isEqualToString:@"0"]) {
            [self.monthLabel setText:[month substringFromIndex:1]];
            
        }else {
            [self.monthLabel setText:month];
        }
    }
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

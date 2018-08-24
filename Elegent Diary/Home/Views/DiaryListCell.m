//
//  DiaryListCell.m
//  Elegent Diary
//
//  Created by lwhldy on 2017/8/23.
//  Copyright © 2017年 lwhldy. All rights reserved.
//

#import "DiaryListCell.h"

@interface DiaryListCell ()<UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *descLabel;

@property (nonatomic, strong) NSMutableParagraphStyle *style;
@end

@implementation DiaryListCell


- (void)configureCellWithDiary:(Diary *)diary {
    NSString *day = [self getDayString:diary.date];
    NSString *contentString = nil;
    if (diary.content.length > 80) {
        contentString = [diary.content substringToIndex:80];
    }else {
        contentString = diary.content;
    }
    NSString *totalString = [NSString stringWithFormat:@"%@%@", day, contentString];
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:totalString];
    [attributeString addAttribute:NSForegroundColorAttributeName value:kNaviBarColor range:NSMakeRange(0, day.length)];
    [attributeString addAttribute:NSParagraphStyleAttributeName value:self.style range:NSMakeRange(0, totalString.length)];
    [attributeString addAttribute:NSKernAttributeName value:@8 range:NSMakeRange(day.length - 1, 1)];
    
    [self.descLabel setAttributedText:attributeString];
}

- (NSString *)getDayString:(NSDate*)date {
    NSString *day = [[NSString getToDayStringFromDate:date] componentsSeparatedByString:@"-"].lastObject;
    return day;
}

- (NSMutableParagraphStyle *)style {
    if (!_style) {
        _style = [[NSMutableParagraphStyle alloc] init];
        _style.lineSpacing = 8.0;
    }
    return _style;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}


#pragma mark - UIGestureRecognizerDelegate 


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

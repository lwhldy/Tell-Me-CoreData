//
//  DCButton.m
//  DailyCost
//
//  Created by lwhldy on 2017/8/2.
//  Copyright © 2017年 lwhldy. All rights reserved.
//

#import "DCButton.h"

@implementation DCButton

-(void)layoutSubviews {
    [super layoutSubviews];
    
    [self.titleLabel sizeToFit];
    CGSize imageSize = self.imageView.image.size;
    CGSize titleSize = self.titleLabel.frame.size;
    
    self.imageView.frame = CGRectMake((self.frame.size.width - imageSize.width)/2.0, (self.frame.size.height - imageSize.height - titleSize.height) /2.0, imageSize.width, imageSize.height);
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    CGFloat bottomHeight = self.frame.size.height - CGRectGetMaxY(self.imageView.frame);
    
    self.titleLabel.frame = CGRectMake(0,  CGRectGetMaxY(self.imageView.frame) + (bottomHeight - titleSize.height)/2.0, self.frame.size.width, titleSize.height);
    [self.titleLabel setTextAlignment:NSTextAlignmentCenter];
}

@end

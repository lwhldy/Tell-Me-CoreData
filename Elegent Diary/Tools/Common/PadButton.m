//
//  PadButton.m
//  DailyCost
//
//  Created by lwhldy on 2017/8/1.
//  Copyright © 2017年 lwhldy. All rights reserved.
//

#import "PadButton.h"3
@interface PadButton ()

@property (nonatomic, strong) UIView *bgcView;

@end

@implementation PadButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setSubView];
    }
    return self;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    [self setSubView];
}

- (void)setSubView {
    //setBgcView
    if (!self.bgcView) {
        CGFloat layerH = self.frame.size.height >= kScreenWidth / 5.0 ? kScreenWidth / 5.0 : self.frame.size.height;
        CGFloat layerW = self.frame.size.width;
        CGFloat orginX = (layerW - layerH)/2.0;
        
        CGFloat orginY = (self.frame.size.height - layerH) / 2.0;
        
        UIView *bgcView = [[UIView alloc] initWithFrame:CGRectMake(orginX, orginY, layerH, layerH)];
        
        [self addSubview:bgcView];
        [self setSubViewStyle:bgcView];
        self.bgcView = bgcView;
        [self.bgcView setHidden:YES];
        [self addTarget:self action:@selector(holdBtn) forControlEvents:UIControlEventTouchDown];
        [self addTarget:self action:@selector(hideBgcView) forControlEvents:UIControlEventTouchUpOutside];
        [self sendSubviewToBack:bgcView];
    }
    
}

- (void)setSubViewStyle:(UIView *)view {
    [view setBackgroundColor:[[UIColor whiteColor] colorWithAlphaComponent:0.4]];
    view.layer.cornerRadius = view.frame.size.width/2.0;
    view.layer.masksToBounds = YES;
    [view setHidden:YES];
}


- (void)holdBtn {
    if (self.currentImage || self.titleLabel.text) {
        
        [UIView animateWithDuration:0.2f animations:^{
            [self.bgcView setHidden:NO];
            self.bgcView.transform = CGAffineTransformMakeScale(1.2, 1.2);
        }];
    }
    
}

- (void)setType:(DCButtonType)type {
    _type = type;
    switch (type) {
        case DCButtonTypeEqual:
            [self setImage:[UIImage imageNamed:@"equal"] forState:UIControlStateNormal];
            break;
        case DCButtonTypeComplete:
            [self setImage:[UIImage imageNamed:@"complete"] forState:UIControlStateNormal];
            break;
        case DCButtonTypeCancel:
            [self setImage:[UIImage imageNamed:@"cancel"] forState:UIControlStateNormal];
            break;
            
        default:
            break;
    }
}


- (void)hideBgcView {
    
    [UIView animateWithDuration:0.2f animations:^{
        self.bgcView.transform = CGAffineTransformIdentity;
        [self.bgcView setHidden:YES];
    }];
    
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

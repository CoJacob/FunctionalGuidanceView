//
//  GFollowSlideTableViewCell.m
//  GFunctionalGuidanceView
//
//  Created by Caoguo on 2018/6/6.
//  Copyright © 2018年 Caoguo. All rights reserved.
//

#import "GFollowSlideTableViewCell.h"
#import "GFunctionalGuidanceView.h"

@implementation GFollowSlideTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.showGuideButton];
    }
    return self;
}

#pragma mark - Getter

- (UIButton *)showGuideButton {
    if (!_showGuideButton) {
        _showGuideButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _showGuideButton.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/2.0-40, 50, 80, 40);
        [_showGuideButton setBackgroundColor:[UIColor colorWithRed:0.00f green:0.68f blue:0.98f alpha:1.00f]];
        _showGuideButton.clipsToBounds = YES;
        _showGuideButton.layer.cornerRadius = 5.f;
        [_showGuideButton addTarget:self action:@selector(showGuideButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _showGuideButton;
}

#pragma mark - IBAction

- (void)showGuideButtonAction: (UIButton *)button {
    !self.guideButtonHandle?:self.guideButtonHandle();
    NSLog(@"Call Button Action");
}

@end

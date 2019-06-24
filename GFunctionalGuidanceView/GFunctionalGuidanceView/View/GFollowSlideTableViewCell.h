//
//  GFollowSlideTableViewCell.h
//  GFunctionalGuidanceView
//
//  Created by Caoguo on 2018/6/6.
//  Copyright © 2018年 Caoguo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GFollowSlideTableViewCell : UITableViewCell

@property (nonatomic ,strong) UIButton *showGuideButton;
@property (nonatomic, copy)  void(^guideButtonHandle)(void);

@end

//
//  GFunctionalGuidanceView.h
//  GFunctionalGuidanceView
//
//  Created by Caoguo on 2018/6/4.
//  Copyright © 2018年 Caoguo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GFunctionalGuidanceView : UIView

@property (nonatomic, copy) void(^lastTapBlock)(void);

+ (instancetype)functionalGuideWithItem: (UIView *)item
                        guideIdentifier: (NSString *)guideIdentifier
                                tapView: (UIView *)tapView;

@end


@interface GGuideManager : NSObject

+ (GGuideManager * )sharedManager;

- (void)addGuideIdentifer: (NSString *)identifier;
- (BOOL)shouldShowGuideViewForIdentifier: (NSString *)identifier;

@end



//
//  NextGuideViewController.m
//  GFunctionalGuidanceView
//
//  Created by Caoguo on 2018/6/4.
//  Copyright © 2018年 Caoguo. All rights reserved.
//

#import "NextGuideViewController.h"
#import "GFunctionalGuidanceView.h"

@interface NextGuideViewController ()

@property (nonatomic, strong) UIButton *guideButton;
@property (nonatomic, strong) NSMutableArray *guideItems;
@property (nonatomic, strong) UIButton *skipButton;

@end

@implementation NextGuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Two Guide";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.guideButton];
    [self.view addSubview:self.skipButton];
    [self setUp];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setUp {
    NSArray *imageNameArray = @[@"guide00",@"guide01",@"guide02"];
    for (int i = 0; i < 3; i ++) {
        CGRect frame = CGRectMake(0, 20, 250, 480);
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
        imageView.image = [UIImage imageNamed:imageNameArray[i]];
        imageView.userInteractionEnabled = YES;
        [self.guideItems addObject:imageView];
    }
}

#pragma mark - Getter

- (UIButton *)guideButton {
    if (!_guideButton) {
        _guideButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _guideButton.bounds = CGRectMake(0, 50, 100, 45);
        _guideButton.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height/2);
        [_guideButton setTitle:@"Show Guide" forState:UIControlStateNormal];
        [_guideButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_guideButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
        [_guideButton addTarget:self action:@selector(guideButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _guideButton;
}

- (UIButton *)skipButton {
    if (!_skipButton) {
        _skipButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _skipButton.frame = CGRectMake(255, 300, 60, 40);
        [_skipButton setBackgroundColor:[UIColor colorWithRed:0.00f green:0.68f blue:0.98f alpha:1.00f]];
        _skipButton.clipsToBounds = YES;
        _skipButton.layer.cornerRadius = 5.f;
        [_skipButton setTitle:@"SKIP" forState:UIControlStateNormal];
        [_skipButton addTarget:self action:@selector(tapButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _skipButton;
}

- (NSMutableArray *)guideItems {
    if (!_guideItems) {
        _guideItems = [NSMutableArray array];
    }
    return _guideItems;
}

- (void)showGuideView {
    UIImageView *_guideItem = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 70, 35)];
    _guideItem.contentMode = UIViewContentModeScaleAspectFill;
    _guideItem.clipsToBounds = YES;
    _guideItem.image = [UIImage imageNamed:@"follow"];
    [GFunctionalGuidanceView functionalGuideWithItem:_guideItem
                                     guideIdentifier:@"Follow"
                                             tapView:self.skipButton];
}

#pragma mark - IBAction

- (void)guideButtonAction: (UIButton *)button {
    [self performSelector:@selector(showGuideView)
               withObject:nil
               afterDelay:0.3f];
}

- (void)tapButtonAction: (UIButton *)button {
    [self.skipButton setTitle:@"Login" forState:UIControlStateNormal];
}



@end

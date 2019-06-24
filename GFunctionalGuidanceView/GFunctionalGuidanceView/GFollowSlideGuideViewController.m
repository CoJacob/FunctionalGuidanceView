//
//  GFollowSlideGuideViewController.m
//  GFunctionalGuidanceView
//
//  Created by Caoguo on 2018/6/6.
//  Copyright © 2018年 Caoguo. All rights reserved.
//

#import "GFollowSlideGuideViewController.h"
#import "GFunctionalGuidanceView.h"
#import "GFollowSlideTableViewCell.h"

@interface GFollowSlideGuideViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView    *tableView;
@property (nonatomic, strong) NSArray        *guideArray;

@end

@implementation GFollowSlideGuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Follow Slide Guide";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    self.guideArray = @[@"Top",@"Left",@"Bottom",@"Right",@"Top",@"Left",@"Bottom",@"Right"];
    {
        for (int i = 0; i < self.guideArray.count; i ++) {
            [self.tableView registerClass:[GFollowSlideTableViewCell class] forCellReuseIdentifier:[NSString stringWithFormat:@"%@%d",NSStringFromClass([GFollowSlideTableViewCell class]),i]];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.tableView.frame = CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-64);
    [self.tableView reloadData];
}

#pragma mark - Getter

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-64) style:UITableViewStylePlain];
//        _tableView.contentSize = CGSizeMake( [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height * 2);
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (NSArray *)guideArray {
    if (!_guideArray) {
        _guideArray = [NSArray array];
    }
    return _guideArray;
}

#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.guideArray.count;
}

- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 140;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GFollowSlideTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"%@%ld",NSStringFromClass([GFollowSlideTableViewCell class]),(long)indexPath.row] forIndexPath:indexPath];
    if (indexPath.row == 1) {
        cell.showGuideButton.frame = CGRectMake([UIScreen mainScreen].bounds.size.width-100, 50, 80, 40);
    }else if (indexPath.row == 3) {
        cell.showGuideButton.frame = CGRectMake(20, 50, 80, 40);
    }
    [cell.showGuideButton setTitle:self.guideArray[indexPath.row] forState:UIControlStateNormal];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
//    __weak __typeof__(self) weakSelf = self;
    cell.guideButtonHandle = ^{
        
    };
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    GFollowSlideTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    UILabel *_titleLabel = [[UILabel alloc] init];
    _titleLabel.font = [UIFont systemFontOfSize:15 weight:UIFontWeightSemibold];
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.text = @"打开这里, 可以收到主题推送";
    CGSize titleSize = [_titleLabel sizeThatFits:CGSizeMake(MAXFLOAT, 21)];
    _titleLabel.bounds = CGRectMake(0, 0, titleSize.width, titleSize.height);
    
//    UIImageView *_guideItem = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 70, 35)];
//    _guideItem.contentMode = UIViewContentModeScaleAspectFill;
//    _guideItem.clipsToBounds = YES;
//    _guideItem.image = [UIImage imageNamed:@"follow"];
    [GFunctionalGuidanceView functionalGuideWithItem:_titleLabel
                                     guideIdentifier:@"Follow"
                                             tapView:cell.showGuideButton];
    
}

@end

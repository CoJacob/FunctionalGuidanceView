//
//  ViewController.m
//  GFunctionalGuidanceView
//
//  Created by Caoguo on 2018/6/4.
//  Copyright © 2018年 Caoguo. All rights reserved.
//

#import "ViewController.h"
#import "GFunctionalGuidanceView.h"
#import "NextGuideViewController.h"
#import "GFollowSlideGuideViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView    *tableView;
@property (nonatomic, strong) NSArray        *guideModes;
@property (nonatomic, strong) NSMutableArray *guideItems;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"One Guide";
    [self.view addSubview:self.tableView];
    [self setUp];
}

#pragma mark - Getter

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-64) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (NSArray *)guideModes {
    if (!_guideModes) {
        _guideModes = [NSArray array];
    }
    return _guideModes;
}

- (NSMutableArray *)guideItems {
    if (!_guideItems) {
        _guideItems = [NSMutableArray array];
    }
    return _guideItems;
}

- (void)showGuideView {
    
//    [GFunctionalGuidanceView functionalGuideWithItems:self.guideItems guideIdentifier:@"testGuide1"];
}

- (void)setUp {
    self.guideModes = @[@"Show Guide",@"Next ViewController",@"Clean Record",@"Follow slide"];
    NSArray *imageNameArray = @[@"guide00",@"guide01",@"guide02"];
    for (int i = 0; i < 3; i ++) {
        CGRect frame = CGRectMake(0, 20, 320, 480);
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
        imageView.image = [UIImage imageNamed:imageNameArray[i]];
        [self.guideItems addObject:imageView];
    }
}

#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.guideModes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = self.guideModes[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
            {
                [self performSelector:@selector(showGuideView)
                           withObject:nil
                           afterDelay:0.3f];
            }
            break;
        
        case 1:
        {
            [self.navigationController pushViewController:[[NextGuideViewController alloc] init] animated:YES];
        }
            break;
            
        case 2:
        {
            [[NSUserDefaults standardUserDefaults] setObject:@[] forKey:@"KFunctionalGuidanceKey"];
        }
            break;
        
        case 3:
        {
            [self.navigationController pushViewController:[[GFollowSlideGuideViewController alloc] init] animated:YES];
        }
            break;
            
        default:
            break;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

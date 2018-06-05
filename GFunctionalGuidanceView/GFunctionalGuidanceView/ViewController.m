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

@interface ViewController ()

@property (nonatomic, strong) NSMutableArray *guideItems;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"One Guide";
    [self setUp];
}

#pragma mark - Getter

- (NSMutableArray *)guideItems {
    if (!_guideItems) {
        _guideItems = [NSMutableArray array];
    }
    return _guideItems;
}

- (void)showGuideView {
    
    [GFunctionalGuidanceView functionalGuideWithItems:self.guideItems guideIdentifier:@"testGuide1"];
}

- (void)setUp {
    NSArray *imageNameArray = @[@"guide00",@"guide01",@"guide02"];
    for (int i = 0; i < 3; i ++) {
        CGRect frame = CGRectMake(0, 20, 320, 480);
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
        imageView.image = [UIImage imageNamed:imageNameArray[i]];
        [self.guideItems addObject:imageView];
    }
}

- (IBAction)guideButtonAction:(id)sender {
    [self performSelector:@selector(showGuideView)
               withObject:nil
               afterDelay:0.3f];
}

- (IBAction)nextVCButtonAction:(id)sender {
    [self.navigationController pushViewController:[[NextGuideViewController alloc] init] animated:YES];
}
- (IBAction)cleanRecordButtonAction:(id)sender {
    [[NSUserDefaults standardUserDefaults] setObject:@[] forKey:@"KFunctionalGuidanceKey"];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

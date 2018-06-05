//
//  GFunctionalGuidanceView.m
//  GFunctionalGuidanceView
//
//  Created by Caoguo on 2018/6/4.
//  Copyright © 2018年 Caoguo. All rights reserved.
//

#import "GFunctionalGuidanceView.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface GFunctionalGuidanceView ()

@property (nonatomic, strong) NSArray  *items;
@property (nonatomic, copy)   NSString *guideIdentifier;
@property (nonatomic, strong) UIView   *tapView;

@end


@interface GGuideManager ()

@property (nonatomic, strong) NSMutableArray *identifiers;

@end



@implementation GFunctionalGuidanceView

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

+ (instancetype)functionalGuideWithItems: (NSArray *)items guideIdentifier: (NSString *)guideIdentifier {
    return [[self alloc] initWithItems:items guideIdentifier:guideIdentifier tapView:nil];
}


+ (instancetype)functionalGuideWithItems: (NSArray *)items guideIdentifier: (NSString *)guideIdentifier tapView: (UIView *)tapView {
    GFunctionalGuidanceView *guideView = [[self alloc] initWithItems:items guideIdentifier:guideIdentifier tapView:tapView];
    
    return guideView;
}

- (instancetype)initWithItems: (NSArray *)items guideIdentifier: (NSString *)guideIdentifier tapView: (UIView *)tapView {
    self = [super init];
    if (self) {
//        if (![[GGuideManager sharedManager] shouldShowGuideViewForIdentifier:guideIdentifier] || items.count == 0) {
//            return nil;
//        }
        [[GGuideManager sharedManager] addGuideIdentifer:guideIdentifier];
        
        self.items           = items;
        self.guideIdentifier = guideIdentifier;
        self.tapView         = tapView;
        [self configUI];
        if (!self.tapView) {
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureHandle:)];
            [self addGestureRecognizer:tapGesture];
        }
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(screenRotateNotification:)
                                                     name:UIDeviceOrientationDidChangeNotification
                                                   object:nil];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
}

- (void)configUI {
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
     self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4f];
    for (int i = 0; i < self.items.count; i ++) {
        UIView *guideItem = self.items[i];
        guideItem.tag = 100 + i;
        [guideItem setHidden:!(i == 0)];
        
        if (!self.tapView) {
            guideItem.userInteractionEnabled = YES;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(touchGuideView:)];
            [guideItem addGestureRecognizer:tap];
        }
        
        [self addSubview:guideItem];
    }
    [keyWindow addSubview:self];
}

#pragma mark - 

- (void)hidden {
    [self removeFromSuperview];
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    if (point.x >= self.tapView.frame.origin.x && point.x <= (self.tapView.frame.origin.x + CGRectGetWidth(self.tapView.frame)) && point.y >= self.tapView.frame.origin.y && point.y <= (self.tapView.frame.origin.y + CGRectGetHeight(self.tapView.frame))) {
        [self hidden];
        return [super hitTest:point withEvent:event];
    }else {
        return [super hitTest:point withEvent:event];
    }
    
}

#pragma mark - Gesture

- (void)touchGuideView: (UITapGestureRecognizer *)gesture {
    UIView *tapView = gesture.view;
    [self tapView:tapView];
}

- (void)tapView: (UIView *)tapView {
    [tapView removeFromSuperview];
    NSInteger index = (tapView.tag - 100);
    if (self.items.count > (index + 1)) {
        UIView *nextView = [self viewWithTag:(index + 101)];
        [nextView setHidden:NO];
    }
    if (index - (self.items.count - 1) == 0) {
        !self.lastTapBlock?:self.lastTapBlock();
        [self hidden];
    }
}

- (void)tapGestureHandle: (UITapGestureRecognizer *)gesture {
    for (UIView *view in self.items) {
        if (!view.hidden && [view superview]) {
            [self tapView:view];
            break;
        }
    }
}

#pragma mark - Notification

- (void)screenRotateNotification: (NSNotification *)notification {
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    [self setNeedsLayout];
}

@end


@implementation GGuideManager

+ (GGuideManager * )sharedManager {
    static dispatch_once_t pred;
    static GGuideManager *_manager;
    dispatch_once(&pred, ^{
        _manager = [[self alloc] init];
        if ([[NSUserDefaults standardUserDefaults] objectForKey:@"KFunctionalGuidanceKey"]) {
            NSArray *idens = [[NSUserDefaults standardUserDefaults] stringArrayForKey:@"KFunctionalGuidanceKey"];
            _manager.identifiers = [NSMutableArray arrayWithArray:idens];
        }
    });
    return _manager;
}

#pragma mark - Getter

- (NSMutableArray *)identifiers {
    if (!_identifiers) {
        _identifiers = [NSMutableArray array];
    }
    return _identifiers;
}

- (void)addGuideIdentifer: (NSString *)identifier {
    [self.identifiers addObject:identifier];
    [[NSUserDefaults standardUserDefaults] setObject:self.identifiers forKey:@"KFunctionalGuidanceKey"];
}


- (BOOL)shouldShowGuideViewForIdentifier: (NSString *)identifier {
    return ![self.identifiers containsObject:identifier];
}

@end


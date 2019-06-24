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
@property (nonatomic, strong) UIView   *alphaBackgroundView;
@property (nonatomic, strong) CAShapeLayer *guideShapeLayer;

@end


@interface GGuideManager ()

@property (nonatomic, strong) NSMutableArray *identifiers;

@end



@implementation GFunctionalGuidanceView

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

+ (instancetype)functionalGuideWithItem: (UIView *)item
                        guideIdentifier: (NSString *)guideIdentifier
                                tapView: (UIView *)tapView {
    GFunctionalGuidanceView *guideView = [[self alloc] initWithItems:@[item] guideIdentifier:guideIdentifier tapView:tapView];
    return guideView;
}

- (instancetype)initWithItems: (NSArray *)items
              guideIdentifier: (NSString *)guideIdentifier
                      tapView: (UIView *)tapView {
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
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(screenRotateNotification:)
                                                     name:UIDeviceOrientationDidChangeNotification
                                                   object:nil];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.alphaBackgroundView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    [self drawShaperLayer];
    [self addGuideItemToSuperView];
}

#pragma mark - Getter

- (UIView *)alphaBackgroundView {
    if (!_alphaBackgroundView) {
        _alphaBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAlphaBgView:)];
        [_alphaBackgroundView addGestureRecognizer:tapGesture];
    }
    return _alphaBackgroundView;
}

- (CAShapeLayer *)guideShapeLayer {
    if (!_guideShapeLayer) {
        _guideShapeLayer = [CAShapeLayer layer];
    }
    return _guideShapeLayer;
}

- (void)configUI {
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    for (int i = 0; i < self.items.count; i ++) {
        UIView *guideItem = self.items[i];
        guideItem.tag = 100 + i;
        [guideItem setHidden:!(i == 0)];
//        if (!self.tapView) {
//            guideItem.userInteractionEnabled = YES;
//            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(touchGuideView:)];
//            [guideItem addGestureRecognizer:tap];
//        }
        if (!guideItem.superview) {
            [self addSubview:guideItem];
        }
    }
    {
        UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
        if (!self.alphaBackgroundView.superview) {
            [keyWindow addSubview:self.alphaBackgroundView];
        }
        [self drawShaperLayer];
    }
    [self addGuideItemToSuperView];
}

- (void)drawShaperLayer {
    CGRect rect = [self.tapView convertRect:self.tapView.bounds toView:self.alphaBackgroundView];
    CGPoint point = CGPointMake(rect.origin.x + rect.size.width/2.0, rect.origin.y + rect.size.height / 2.0);
    [self drawGuideViewWithCircularPoint:point];
}

- (void)drawGuideViewWithCircularPoint:(CGPoint)point {
    self.guideShapeLayer.fillColor = [[UIColor blackColor] colorWithAlphaComponent:0.4].CGColor;
    [self.alphaBackgroundView.layer addSublayer:self.guideShapeLayer];
    
    UIBezierPath *pPath = [UIBezierPath bezierPathWithArcCenter:point radius:CGRectGetWidth(self.tapView.frame)/2.0 + 5 startAngle:0.0 endAngle:M_PI*2 clockwise:YES];
    self.guideShapeLayer.path = pPath.CGPath;
    
    UIBezierPath *pOtherPath = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    self.guideShapeLayer.path = pOtherPath.CGPath;
    
    [pOtherPath appendPath:pPath];
    self.guideShapeLayer.path = pOtherPath.CGPath;

    self.guideShapeLayer.fillRule = kCAFillRuleEvenOdd;
}

- (void)addGuideItemToSuperView {
    [self addGuideItemToSuperViewIfSurround];
}

- (void)addGuideItemToSuperViewIfSurround {
    
    self.backgroundColor = [UIColor clearColor];
    UIView *guideItem = [self.items firstObject];
    
    CGRect targetRect = [self.tapView convertRect:self.tapView.bounds toView:self.alphaBackgroundView];
    
    // Default on the top
    CGFloat _guideItemOriginX = (targetRect.origin.x + targetRect.size.width/2.0) - CGRectGetWidth(guideItem.frame) / 2.0;
    CGFloat _guideItemOriginY = (targetRect.origin.y) - CGRectGetHeight(guideItem.frame) - CGRectGetWidth(self.tapView.frame) / 2.0;
    
    if ([self outOfBoundsForOriginX:_guideItemOriginX originY:_guideItemOriginY guideItem:guideItem]) {
        // On the left
        _guideItemOriginX = CGRectGetMinX(targetRect) - 10 - CGRectGetWidth(guideItem.frame);
        _guideItemOriginY = (targetRect.origin.y + targetRect.size.height/2.0) - CGRectGetHeight(guideItem.frame)/2.0;
        
        if ([self outOfBoundsForOriginX:_guideItemOriginX originY:_guideItemOriginY guideItem:guideItem]) {
            // on the bottom
            _guideItemOriginX = (targetRect.origin.x + targetRect.size.width/2.0) - CGRectGetWidth(guideItem.frame) / 2.0;
            _guideItemOriginY = (targetRect.origin.y) + CGRectGetHeight(guideItem.frame) + CGRectGetWidth(self.tapView.frame) / 2.0 + 10;
            
            if ([self outOfBoundsForOriginX:_guideItemOriginX originY:_guideItemOriginY guideItem:guideItem]) {
                // on the right
                _guideItemOriginX = CGRectGetMaxX(targetRect) + 10;
                _guideItemOriginY = (targetRect.origin.y + targetRect.size.height/2.0) - CGRectGetHeight(guideItem.frame)/2.0;
            }
        }
    }
    
    guideItem.frame = CGRectMake(_guideItemOriginX,_guideItemOriginY,CGRectGetWidth(guideItem.frame), CGRectGetHeight(guideItem.frame));
    if (!self.superview) {
        [self.alphaBackgroundView addSubview:self];
    }else {
        [self.alphaBackgroundView bringSubviewToFront:self];
    }
}

- (BOOL )outOfBoundsForOriginX: (CGFloat )originX
                       originY: (CGFloat )originY
                     guideItem: (UIView *)guideItem {
    if (originX > 0 && (originX + CGRectGetWidth(guideItem.frame)) < SCREEN_WIDTH && originY > 20 && (originY + CGRectGetHeight(guideItem.frame)) < SCREEN_HEIGHT) {
        return NO;
    }else {
        return YES;
    }
}

#pragma mark -

- (void)hidden {
    [self.alphaBackgroundView removeFromSuperview];
    [self removeFromSuperview];
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    CGRect targetRect = [self.tapView convertRect:self.tapView.bounds toView:self.alphaBackgroundView];
    
    if (point.x >= targetRect.origin.x && point.x <= (targetRect.origin.x + CGRectGetWidth(self.tapView.frame)) && point.y >= targetRect.origin.y && point.y <= (targetRect.origin.y + CGRectGetHeight(self.tapView.frame))) {
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

- (void)tapAlphaBgView: (UITapGestureRecognizer *)tapGesture {
    [self hidden];
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


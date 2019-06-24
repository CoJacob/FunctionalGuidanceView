# FunctionalGuidanceView
一个通用的iOS新功能引导组件(iOS Objective-C)
An iOS FunctionalGuidanceView (自动设置引导提示视图位置,并且带有穿透效果, 可以正常点击功能按钮)


# Usage

    UIImageView *_guideItem = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 70, 35)];
    _guideItem.image = [UIImage imageNamed:@"follow"];
    [GFunctionalGuidanceView functionalGuideWithItem:_guideItem
    guideIdentifier:@"Follow"
    tapView:self.skipButton];

@end


# Preview

![img](https://github.com/Winerywine/FunctionalGuidanceView/blob/master/guide_record.gif)

//
//  PanelView.h
//  Chart
//
//  Created by Jakub Hladík on 03.10.12.
//  Copyright (c) 2012 Jakub Hladík. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 protokol
 - senam zprav ktery nas PanelView bude zasilat svemu delagatovi
 */
@protocol PanelViewProtocol <NSObject>

- (void)panelViewShrinkSliderValueChangedTo:(CGFloat)newValue;
- (void)panelViewAmpSliderValueChangedTo:(CGFloat)newValue;
- (void)animate:(double)a b:(double)b;

@end

@interface PanelView : UIView

@property (nonatomic, assign) CGFloat a;
@property (nonatomic, assign) CGFloat b;

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, weak) id<PanelViewProtocol> delegate;

@property (nonatomic, weak) UIButton *button;

@property (nonatomic, weak) UILabel *ampSliderLabel;
@property (nonatomic, weak) UISlider *ampSlider;

@property (nonatomic, weak) UILabel *shrinkSliderLabel;
@property (nonatomic, weak) UISlider *shrinkSlider;

@property (nonatomic, weak) UILabel *switchLabel;
@property (nonatomic, weak) UISwitch *aSwitch;

- (void)turnAnimateOn;
- (void)turnAnimateOff;

@end

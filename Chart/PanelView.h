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

- (void)panelViewButtonTapped;
- (void)panelViewSliderValueChangedTo:(CGFloat)newValue;

@end

@interface PanelView : UIView

@property (nonatomic, weak) id<PanelViewProtocol> delegate;

@property (nonatomic, weak) UIButton *button;
@property (nonatomic, weak) UISlider *slider;
@property (nonatomic, weak) UISwitch *aSwitch;

@end

//
//  PanelView.m
//  Chart
//
//  Created by Jakub Hladík on 03.10.12.
//  Copyright (c) 2012 Jakub Hladík. All rights reserved.
//

#import "PanelView.h"

@implementation PanelView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    self.backgroundColor = [UIColor greenColor];
    
    UISlider *slider = [[UISlider alloc] init];
    slider.minimumValue = 1;
    slider.maximumValue = 3;
	slider.value = 2;
	[self sliderValueChanged:slider];
    [slider addTarget:self
               action:@selector(sliderValueChanged:)
     forControlEvents:UIControlEventValueChanged];
    [self addSubview:slider];
    _slider = slider;
	
	UILabel* switchLabel = [[UILabel alloc] init];
	switchLabel.text = @"Animate:";
	switchLabel.backgroundColor = [UIColor clearColor];
	[self addSubview:switchLabel];
	_switchLabel = switchLabel;
    
    UISwitch *aSwitch = [[UISwitch alloc] init];
	[aSwitch addTarget:self action:@selector(switchTurned:) forControlEvents:UIControlEventValueChanged];
	aSwitch.on = YES;
	[self switchTurned:aSwitch];
    [self addSubview:aSwitch];
    _aSwitch = aSwitch;
    
    UILabel *sliderLabel = [[UILabel alloc] init];
    sliderLabel.text = @"Shrinkness:";
	sliderLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:sliderLabel];
	_sliderLabel = sliderLabel;
}

- (void)layoutSubviews
{
    [super layoutSubviews];

	_sliderLabel.frame = CGRectMake(8, self.bounds.size.height-32-8-32, self.bounds.size.width-16, 16);
    _slider.frame = CGRectMake(8, self.bounds.size.height-32-8, self.bounds.size.width-16, 16);
	
	_switchLabel.frame = CGRectMake(8, 16, self.bounds.size.width-16, 16);
    _aSwitch.frame = CGRectMake(8, 48, 79, 27);
}

- (void)switchTurned:(UISwitch*) aSwitch
{
	if ([_delegate respondsToSelector:@selector(switchTurned:)]) {
        [_delegate switchTurned:aSwitch.on];
    }
}

- (void)sliderValueChanged:(UISlider *)aSlider
{
	[_aSwitch setOn:NO animated:YES];
	[self switchTurned:_aSwitch];
    if ([_delegate respondsToSelector:@selector(panelViewSliderValueChangedTo:)]) {
        [_delegate panelViewSliderValueChangedTo:aSlider.value];
    }
}

- (void)stopAnimating
{
	[_aSwitch setOn:NO animated:YES];
	[self switchTurned:_aSwitch];
}

@end

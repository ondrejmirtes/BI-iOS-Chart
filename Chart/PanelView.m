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
	
	UILabel *ampSliderLabel = [[UILabel alloc] init];
    ampSliderLabel.text = @"Amplitude:";
	ampSliderLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:ampSliderLabel];
	_ampSliderLabel = ampSliderLabel;
    
    UISlider *ampSlider = [[UISlider alloc] init];
    ampSlider.minimumValue = -1;
    ampSlider.maximumValue = 1;
	ampSlider.value = _a = 0;
	[self ampSliderValueChanged:ampSlider];
    [ampSlider addTarget:self
					 action:@selector(ampSliderValueChanged:)
		   forControlEvents:UIControlEventValueChanged];
    [self addSubview:ampSlider];
    _ampSlider = ampSlider;
	
	UILabel *shrinkSliderLabel = [[UILabel alloc] init];
    shrinkSliderLabel.text = @"Shrinkness:";
	shrinkSliderLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:shrinkSliderLabel];
	_shrinkSliderLabel = shrinkSliderLabel;
    
    UISlider *shrinkSlider = [[UISlider alloc] init];
    shrinkSlider.minimumValue = 1;
    shrinkSlider.maximumValue = 3;
	shrinkSlider.value = _b = 2;
	[self shrinkSliderValueChanged:shrinkSlider];
    [shrinkSlider addTarget:self
               action:@selector(shrinkSliderValueChanged:)
     forControlEvents:UIControlEventValueChanged];
    [self addSubview:shrinkSlider];
    _shrinkSlider = shrinkSlider;
	
	UILabel* switchLabel = [[UILabel alloc] init];
	switchLabel.text = @"Animate:";
	switchLabel.backgroundColor = [UIColor clearColor];
	[self addSubview:switchLabel];
	_switchLabel = switchLabel;
    
    UISwitch *aSwitch = [[UISwitch alloc] init];
	[aSwitch addTarget:self action:@selector(switchTurned:) forControlEvents:UIControlEventValueChanged];
	aSwitch.on = YES;
	[self turnAnimateOn];
    [self addSubview:aSwitch];
    _aSwitch = aSwitch;
}

- (void)switchTurned:(UISwitch*)aSwitch
{
	if (aSwitch.on) {
		[self turnAnimateOn];
	} else {
		[self turnAnimateOff];
	}
}

- (void)layoutSubviews
{
    [super layoutSubviews];
	
	_ampSliderLabel.frame = CGRectMake(8, self.bounds.size.height-140, self.bounds.size.width-16, 16);
    _ampSlider.frame = CGRectMake(8, self.bounds.size.height-108, self.bounds.size.width-16, 16);

	_shrinkSliderLabel.frame = CGRectMake(8, self.bounds.size.height-74, self.bounds.size.width-16, 16);
    _shrinkSlider.frame = CGRectMake(8, self.bounds.size.height-42, self.bounds.size.width-16, 16);
	
	_switchLabel.frame = CGRectMake(8, 16, self.bounds.size.width-16, 16);
    _aSwitch.frame = CGRectMake(8, 48, 79, 27);
}

- (void)shrinkSliderValueChanged:(UISlider *)aSlider
{
	//[self turnAnimateOff];
	_b = aSlider.value;
    if ([_delegate respondsToSelector:@selector(panelViewShrinkSliderValueChangedTo:)]) {
        [_delegate panelViewShrinkSliderValueChangedTo:aSlider.value];
    }
}

- (void)ampSliderValueChanged:(UISlider *)aSlider
{
	[self turnAnimateOff];
	_a = aSlider.value;
    if ([_delegate respondsToSelector:@selector(panelViewAmpSliderValueChangedTo:)]) {
        [_delegate panelViewAmpSliderValueChangedTo:aSlider.value];
    }
}

- (void)turnAnimateOff
{
	[_aSwitch setOn:NO animated:YES];
	[_timer invalidate];
	_timer = nil;
}

- (void)turnAnimateOn
{
	_timer = [NSTimer scheduledTimerWithTimeInterval:0.008 target:self selector:@selector(animate) userInfo:nil repeats:YES];
	[_timer fire];
}

- (void)animate
{
    static BOOL diretion = YES;
	
    /*
     animujeme _a mezi <-1, 1>
     */
    if (diretion) {
        _a += 0.01;
    }
    else {
        _a -= 0.01;
    }
    
    /*
     smer se prehodi pri prekroceni mezni hodnoty
     */
    if (_a > 1.0) {
        _a = 1.0;
        diretion = NO;
    }
    if (_a < -1.0) {
        _a = -1.0;
        diretion = YES;
    }
    
    /*
     rekneme systemu, ze tenhle view je potreba prekreslit
     system zavola autmaticky drawRect: jakmile bude mit volne prostredky
     NIKDY nevolat drawRect primo!
     */
	[_ampSlider setValue:_a];
    [_delegate animate:_a b:_b];
}

@end

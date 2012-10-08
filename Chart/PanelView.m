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
    
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [button setTitle:@"Draw"
                forState:UIControlStateNormal];
        [button addTarget:self
                   action:@selector(buttonTapped:)
         forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        _button = button;
    }
    
    UISlider *slider = [[UISlider alloc] init];
    slider.minimumValue = 0;
    slider.maximumValue = 1;
    [slider addTarget:self
               action:@selector(sliderValueChanged:)
     forControlEvents:UIControlEventValueChanged];
    [self addSubview:slider];
    _slider = slider;
    
    UIImage *image = [UIImage imageNamed:@"itunesIcon"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.frame = CGRectMake(72, 4, image.size.width, image.size.height);
    [self addSubview:imageView];
    
    UISwitch *aSwitch = [[UISwitch alloc] init];
    [self addSubview:aSwitch];
    _aSwitch = aSwitch;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(120, 50, 100, 20)];
    label.text = @"ymLabel";
    [self addSubview:label];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _button.frame = CGRectMake(4, 4, 64, 44);
    _slider.frame = CGRectMake(4, self.bounds.size.height-16-4, self.bounds.size.width-8, 16);
    _aSwitch.frame = CGRectMake(200, 4, 79, 27);
}

- (void)buttonTapped:(UIButton *)aButton
{
    NSLog(@"button tapped");
    
    /*
     nejdriv se delegate zeptame jestli dokaze odpovedet na danou zpravu
     pokud ano (ma ji implementovanou), tak mu ji posleme
     */
    if ([_delegate respondsToSelector:@selector(draw)]) {
        [_delegate panelViewButtonTapped];
    }
}

- (void)sliderValueChanged:(UISlider *)aSlider
{
    NSLog(@"slider value: %f", aSlider.value);
    
    if ([_delegate respondsToSelector:@selector(valueChangedTo:)]) {
        [_delegate panelViewSliderValueChangedTo:aSlider.value];
    }
}

@end

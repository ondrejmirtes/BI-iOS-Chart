//
//  ChartView.h
//  Chart
//
//  Created by Jakub Hladík on 03.10.12.
//  Copyright (c) 2012 Jakub Hladík. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChartView : UIView

@property (nonatomic, assign) CGFloat a;
@property (nonatomic, assign) CGFloat b;

@property (nonatomic, strong) NSTimer *timer;

- (void)turnAnimateOff;
- (void)turnAnimateOn;

@end

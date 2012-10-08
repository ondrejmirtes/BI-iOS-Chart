//
//  ViewController.h
//  Chart
//
//  Created by Jakub Hladík on 03.10.12.
//  Copyright (c) 2012 Jakub Hladík. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChartView.h"
#import "PanelView.h"

@interface ChartViewController : UIViewController <PanelViewProtocol>

@property (weak, nonatomic) IBOutlet ChartView *chartView;
@property (weak, nonatomic) IBOutlet PanelView *panelView;

@end

//
//  ViewController.m
//  Chart
//
//  Created by Jakub Hladík on 03.10.12.
//  Copyright (c) 2012 Jakub Hladík. All rights reserved.
//

#import "ChartViewController.h"

@interface ChartViewController ()

@end

@implementation ChartViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    /*
     zde nastavime sebe (controller) jako delegate nasemu ovladacimu panelu (je to mozne udelat i pres storyboard)
     */
    _panelView.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - PanelViewDelegate

- (void)panelViewButtonTapped
{
    [_chartView setNeedsDisplay];
}

- (void)panelViewSliderValueChangedTo:(CGFloat)newValue
{
    _chartView.b = newValue;
    [_chartView setNeedsDisplay];
}

@end

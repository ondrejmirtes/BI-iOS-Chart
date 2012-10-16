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

- (IBAction)handlePan:(UIPanGestureRecognizer *)recognizer
{
	CGPoint translation = [recognizer translationInView:self.view];
    recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x,
                                         recognizer.view.center.y + translation.y);
    [recognizer setTranslation:CGPointMake(0, 0) inView:self.view];
	
	[_panelView stopAnimating];
	
	if (recognizer.state == UIGestureRecognizerStateEnded) {
		[UIView beginAnimations:@"button_in" context:nil];
		[UIView setAnimationDelegate:self];
		[UIView setAnimationDuration:0.25];
		[UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
		[UIView setAnimationBeginsFromCurrentState:YES];
		recognizer.view.frame = CGRectMake(0, 0, recognizer.view.frame.size.width, recognizer.view.frame.size.height);
		[UIView commitAnimations];
	}
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

- (void)switchTurned:(BOOL)on
{
	if (on) {
		[_chartView turnAnimateOn];
	} else {
		[_chartView turnAnimateOff];
	}
}

@end

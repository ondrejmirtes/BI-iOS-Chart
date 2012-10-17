//
//  ChartView.m
//  Chart
//
//  Created by Jakub Hladík on 03.10.12.
//  Copyright (c) 2012 Jakub Hladík. All rights reserved.
//

#import "ChartView.h"
#import <QuartzCore/QuartzCore.h>

@implementation ChartView

/*
 manualni alokace
 */
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

/*
 nacteni z interface builderu (storyboard)
 */
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
    _a = 1;
    _b = 2;
	
	UIColor *backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"chart.png"]];
	self.backgroundColor = backgroundColor;
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    /*
     vytahneme si aktualni kontext
     - objekt to ktereho lze kreslit (vetsinou nejaky buffer co se vykresli na obrazovku)
     - muze to ale byt i pdf
     - muze to byt bitmapa do ktere budeme kreslit a pak ji pouzijeme jako obrazek
     */
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    
    /*
     posuneme souradny system do (8, 8), kde zacneme prvnim bodem
     pridame caru do druheho bodu
     nastavime barvu cary
     nastavime tloustku
     barva stinu
     vykreslime
     
     misto StrokePath je mozne samozrejme FillPath (kresleni do uzavreneho polygonu)
     */
    CGContextMoveToPoint(contextRef, 0, [self getY:0]);
	for (int x = 0; x <= self.bounds.size.width; x++) {
		CGContextAddLineToPoint(contextRef, x, [self getY:x]);
	}
    CGContextSetStrokeColorWithColor(contextRef, [UIColor whiteColor].CGColor);
    CGContextSetLineWidth(contextRef, 4);
    CGContextSetShadowWithColor(contextRef, CGSizeMake(0, 2), 1, [UIColor grayColor].CGColor);
    CGContextStrokePath(contextRef);
}

- (int) getY:(int)x
{
	// <-PI, PI>
	double xx = (x / self.bounds.size.width * 2 * M_PI) - M_PI;
	int half = self.bounds.size.height / 2;
	return (_a * half * sin(_b * xx)) + half;
}


@end

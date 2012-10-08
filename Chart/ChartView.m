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
    _a = 0;
    _b = 0;
    
    /*
     kazdych 0.02 sekundy posli me (self) zpravu animate
     */
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.02 target:self selector:@selector(animate) userInfo:nil repeats:YES];
    [_timer fire];
}

- (void)animate
{
    static BOOL diretion = YES;

    /*
     animujeme _b mezi <0, 1>
     */
    if (diretion) {
        _b += 0.01;
    }
    else {
        _b -= 0.01;
    }
    
    /*
     smer se prehodi pri prekroceni mezni hodnoty
     */
    if (_b > 1.0) {
        _b = 1.0;
        diretion = NO;
    }
    if (_b < 0.0) {
        _b = 0.0;
        diretion = YES;
    }
    
    /*
     rekneme systemu, ze tenhle view je potreba prekreslit
     system zavola autmaticky drawRect: jakmile bude mit volne prostredky
     NIKDY nevolat drawRect primo!
     */
    [self setNeedsDisplay];
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
    CGContextMoveToPoint(contextRef, 8, 8);
    CGContextAddLineToPoint(contextRef, self.bounds.size.width-8, _b*(self.bounds.size.height - 16)+8);
    CGContextSetStrokeColorWithColor(contextRef, [UIColor whiteColor].CGColor);
    CGContextSetLineWidth(contextRef, 4);
    CGContextSetShadowWithColor(contextRef, CGSizeMake(0, 2), 1, [UIColor grayColor].CGColor);
    CGContextStrokePath(contextRef);
}


@end

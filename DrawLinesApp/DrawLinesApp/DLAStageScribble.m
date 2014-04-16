//
//  DLAStageScribble.m
//  DrawLinesApp
//
//  Created by Austen Johnson on 4/15/14.
//  Copyright (c) 2014 Austen Johnson. All rights reserved.
//

#import "DLAStageScribble.h"

@implementation DLAStageScribble
{
    NSMutableArray * scribbles;
    UIButton * colorButtonRed;
    UIButton * colorButtonYellow;
    UIButton * colorButtonBlue;
    UISlider * slider;
    NSArray * sliderrange;
    UIView * colorDrawer;

}

- (id)initWithFrame:(CGRect)frame
{
    
    

    self = [super initWithFrame:frame];
    if (self)
    {
        self.lineWidth = 2.0;
        self.lineColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor blackColor];
        
        scribbles = [@[] mutableCopy];
        
//        colorButtonRed = [[UIButton alloc] initWithFrame:CGRectMake(60, 400, 60, 40)];
//        [colorButtonRed setTitle:@"Red" forState:UIControlStateNormal];
//        [colorButtonRed addTarget:self action:@selector(changeLineColor:) forControlEvents: UIControlEventTouchUpInside];
//        colorButtonRed.backgroundColor = [UIColor redColor];
//        colorButtonRed.layer.cornerRadius = 6;
//        colorButtonRed.tag = 0;
//        colorButtonRed.titleLabel.font = [UIFont boldSystemFontOfSize:12];
//        [colorButtonRed setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        [self addSubview:colorButtonRed];
//        
//        colorButtonYellow = [[UIButton alloc] initWithFrame:CGRectMake(130, 400, 60, 40)];
//        [colorButtonYellow setTitle:@"Yellow" forState:UIControlStateNormal];
//        [colorButtonYellow addTarget:self action:@selector(changeLineColor:) forControlEvents: UIControlEventTouchUpInside];
//        colorButtonYellow.backgroundColor = [UIColor yellowColor];
//        colorButtonYellow.layer.cornerRadius = 6;
//        colorButtonYellow.tag = 1;
//        colorButtonYellow.titleLabel.font = [UIFont boldSystemFontOfSize:12];
//        [colorButtonYellow setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        [self addSubview:colorButtonYellow];
//        
//        colorButtonBlue = [[UIButton alloc] initWithFrame:CGRectMake(200, 400, 60, 40)];
//        [colorButtonBlue setTitle:@"Blue" forState:UIControlStateNormal];
//        [colorButtonBlue addTarget:self action:@selector(changeLineColor:) forControlEvents: UIControlEventTouchUpInside];
//        colorButtonBlue.backgroundColor = [UIColor blueColor];
//        colorButtonBlue.layer.cornerRadius = 6;
//        colorButtonBlue.tag = 2;
//        colorButtonBlue.titleLabel.font = [UIFont boldSystemFontOfSize:12];
//        [colorButtonBlue setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        [self addSubview:colorButtonBlue];
        
        slider = [[UISlider alloc] initWithFrame:CGRectMake(20, 460, 280, 10)];
        slider.backgroundColor = [UIColor greenColor];
        slider.layer.cornerRadius = 5;
        slider.minimumValue = 2;
        slider.maximumValue = 20.0;
        [slider addTarget:self action:@selector(changeSizes:) forControlEvents:UIControlEventAllEvents];
        [self addSubview:slider];
        
        colorDrawer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
        NSArray * colors = @[
                             [UIColor colorWithRed:0.251f green:0.251f blue:0.251f alpha:1.0f],
                             [UIColor colorWithRed:0.008f green:0.353f blue:0.431f alpha:1.0f],
                             [UIColor colorWithRed:0.016f green:0.604f blue:0.671f alpha:1.0f],
                             [UIColor colorWithRed:1.000f green:0.988f blue:0.910f alpha:1.0f],
                             [UIColor colorWithRed:1.000f green:0.298f blue:0.153f alpha:1.0f]
                             ];
        float buttonWidth = SCREEN_WIDTH / [colors count];
        
        for (UIColor * color in colors)
        {
            int index =  [colors indexOfObject:color];

            UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(buttonWidth * index, 0, buttonWidth, 40)];
            button.backgroundColor = color;
            [button addTarget:self action:@selector(changeLineColor:) forControlEvents:UIControlEventTouchUpInside];
            [colorDrawer addSubview:button];
            
//            UIButton * toggle = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 120, 50, 50, 50)];
//            toggle.backgroundColor = [UIColor redColor];
//            [toggle addTarget:self action:@selector(toggleStage) forControlEvents:
//             UIControlEventTouchUpInside];
//            [self addSubview:toggle];
            
//            
//            UIButton * clearButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 60, 50, 50, 50)];
//            clearButton.backgroundColor = [UIColor lightGrayColor];
//            [toggle addTarget:self action:@selector(clearStage) forControlEvents:
//            UIControlEventTouchUpInside];
//            [self addSubview:clearButton];
//            
//            UIButton * undoButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 60, 50, 50, 50)];
//            undoButton.backgroundColor = [UIColor lightGrayColor];
//            [toggle addTarget:self action:@selector(clearStage) forControlEvents:
//             UIControlEventTouchUpInside];
//            [self addSubview:undoButton];
            
            
        }
        
        [self addSubview:colorDrawer];
        
    }
    return self;
}

//-(void)clearStage
//{
//
//}

//-(void)toggleStage
//{

//    [sribbleView removeFromSuperview];

//    if ([scribbleView isMemberOfClass:[DLAStageScribble class]])
//    {
//        scribbleView = [DLAStageScribble alloc] initWithFrame:[self.view.frame];
//    }else {
//        [[DLAStageScribble alloc] initWithFrame:self.view.frame];
//    }
//}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
-(void)changeLineColor: (UIButton *) sender
{
    [self setLineColor:sender.backgroundColor];
}

-(void)changeSizes: (UISlider *) sender
{
    self.lineWidth = sender.value;
}

//-(void)setLineWidth:(float)lineWidth
//{
//    
//}

-(void)setLineColor:(UIColor *)lineColor
{
    _lineColor = lineColor;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineWidth(context, self.lineWidth);
    
    [self.lineColor set];

    for (NSDictionary * scribble in scribbles)
    {
        CGContextSetLineWidth(context, [scribble[@"width"] floatValue]);
        
        [(UIColor *) scribble[@"color"] set];
        NSArray * points = scribble[@"points"];
        CGPoint start = [points[0] CGPointValue];
        CGContextMoveToPoint(context, start.x, start.y);
        for (NSValue * value in points)
        {
            CGPoint point = [value CGPointValue];
         CGContextAddLineToPoint(context, point.x, point.y);
        }
        CGContextStrokePath(context);
    }
}

-(void)undo
{
    [scribbles removeLastObject];
    [self setNeedsDisplay];
}

-(void)clearStage
{
    [scribbles removeAllObjects];
    [self setNeedsDisplay];
}

-(void)setLineWidth:(float)lineWidth
{
    _lineWidth = lineWidth;
    [self setNeedsDisplay];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch * touch in touches) {
        CGPoint location = [touch locationInView:self];
        [scribbles addObject:[@{
                                @"color": self.lineColor,
                                @"width": @(self.lineWidth),
                                @"points": [@[[NSValue valueWithCGPoint:location]] mutableCopy]
                                } mutableCopy]];
    }
    [self setNeedsDisplay];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch * touch in touches)
    {
        CGPoint location = [touch locationInView:self];
        [[scribbles lastObject][@"points"][1] addObject:[NSValue valueWithCGPoint:location]];
    }
    [self setNeedsDisplay];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch * touch in touches)
    {
        CGPoint location = [touch locationInView:self];
        [[scribbles lastObject][@"points"] addObject:[NSValue valueWithCGPoint:location]];
    }
    [self setNeedsDisplay];
}


@end

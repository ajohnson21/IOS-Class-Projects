//
//  DLAViewController.m
//  DrawLinesApp
//
//  Created by Austen Johnson on 4/15/14.
//  Copyright (c) 2014 Austen Johnson. All rights reserved.
//

#import "DLAViewController.h"
#import "DLAStageLines.h"
#import "DLAStageScribble.h"

@implementation DLAViewController
{
    DLAStageScribble * scribbleView;
    UISlider * slider;
    NSArray * sliderrange;
    UIView * colorDrawer;
    UIColor * lineColor;
    float lineWidth;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    lineColor = [UIColor purpleColor];
    lineWidth = 5.0;
    
    [self toggleStage];
    [self.view addSubview:scribbleView];
    
    slider = [[UISlider alloc] initWithFrame:CGRectMake(20, 460, 280, 10)];
    slider.layer.cornerRadius = 5;
    slider.minimumValue = 2;
    slider.maximumValue = 20.0;
    slider.value = lineWidth;
    [slider addTarget:self action:@selector(changeSizes:) forControlEvents:UIControlEventAllEvents];
    slider.transform = CGAffineTransformMakeRotation(-90 * M_PI / 180);
    slider.frame = CGRectMake(SCREEN_WIDTH - 315, SCREEN_HEIGHT - 390, 23, 280);
    [self.view addSubview:slider];
    
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
        
        
    }
    
    [self.view addSubview:colorDrawer];
    
    UISwitch * toggleSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(10, 50, 50, 50)];
//    toggleSwitch.backgroundColor = [UIColor blackColor];
//    [toggleSwitch setTitle:@"T" forState:UIControlStateNormal];
    [toggleSwitch addTarget:self action:@selector(toggleStage) forControlEvents: UIControlEventTouchUpInside];
    toggleSwitch.tintColor = [UIColor redColor];
    toggleSwitch.onTintColor = [UIColor redColor];
    [self.view addSubview:toggleSwitch];

    
    UIButton * clearButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 55, 40, 50, 50)];
    clearButton.backgroundColor = [UIColor clearColor];
    [clearButton setImage:[UIImage imageNamed: @"DeleteRed.png"] forState:UIControlStateNormal];
    [clearButton addTarget:self action:@selector(clearStage) forControlEvents:
     UIControlEventTouchUpInside];
    clearButton.layer.cornerRadius = 25;
    [self.view addSubview:clearButton];
    
    UIButton * undoButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 110, 40, 50, 50)];
    undoButton.backgroundColor = [UIColor clearColor];
    [undoButton setImage:[UIImage imageNamed: @"draw_eraser.png"] forState:UIControlStateNormal];
    [undoButton addTarget:self action:@selector(undo) forControlEvents:
     UIControlEventTouchUpInside];
    undoButton.layer.cornerRadius = 25;
    [self.view addSubview:undoButton];

    
    
    
    
}

-(void)changeSizes: (UISlider *) sender
{
    scribbleView.lineWidth = lineWidth;
    lineWidth = sender.value;
}

-(void)toggleStage
{
    
    NSMutableArray * lines = scribbleView.lines;
    
    [scribbleView removeFromSuperview];
    
    if ([scribbleView isMemberOfClass:[DLAStageScribble class]])
    {
        scribbleView = [[DLAStageLines alloc] initWithFrame:self.view.frame];
    }
    else
    {
        scribbleView = [[DLAStageScribble alloc] initWithFrame: self.view.frame];
    }
    
    scribbleView.lineWidth = lineWidth;
    scribbleView.lineColor = lineColor;
    
    if (lines != nil) scribbleView.lines = lines;
    
    //TODO understand this
    [self.view insertSubview:scribbleView atIndex:0];
}

-(void)undo
{
    [scribbleView undo];
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
-(void)changeLineColor: (UIButton *) sender
{
    [scribbleView setLineColor:sender.backgroundColor];
    lineColor = sender.backgroundColor;
}

-(void)clearStage
{
    [scribbleView clearStage];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

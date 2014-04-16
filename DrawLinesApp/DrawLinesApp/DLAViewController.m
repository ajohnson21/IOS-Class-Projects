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
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //do nothing so long
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    scribbleView = [[DLAStageLines alloc] initWithFrame:self.view.frame];
    [self.view addSubview:scribbleView];
    
    //    scribbleView.lineColor = [UIColor blueColor];
    
    slider = [[UISlider alloc] initWithFrame:CGRectMake(20, 460, 280, 10)];
    slider.backgroundColor = [UIColor greenColor];
    slider.layer.cornerRadius = 5;
    slider.minimumValue = 2;
    slider.maximumValue = 20.0;
    [slider addTarget:self action:@selector(changeSizes:) forControlEvents:UIControlEventAllEvents];
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
    
    UIButton * toggle = [[UIButton alloc] initWithFrame:CGRectMake(10, 50, 50, 50)];
    toggle.backgroundColor = [UIColor greenColor];
    [toggle addTarget:self action:@selector(toggleStage) forControlEvents:
     UIControlEventTouchUpInside];
    [self.view addSubview:toggle];
    
    
    UIButton * clearButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 120, 50, 50, 50)];
    clearButton.backgroundColor = [UIColor blueColor];
    [clearButton addTarget:self action:@selector(clearStage) forControlEvents:
     UIControlEventTouchUpInside];
    [self.view addSubview:clearButton];
    
    UIButton * undoButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 60, 50, 50, 50)];
    undoButton.backgroundColor = [UIColor lightGrayColor];
    [undoButton addTarget:self action:@selector(undo) forControlEvents:
     UIControlEventTouchUpInside];
    [self.view addSubview:undoButton];

    
    
    
    
}

-(void)changeSizes: (UISlider *) sender
{
    scribbleView.lineWidth = sender.value;
}

-(void)toggleStage
{
    
    [scribbleView removeFromSuperview];
    
    if ([scribbleView isMemberOfClass:[DLAStageScribble class]])
    {
        scribbleView = [[DLAStageLines alloc] initWithFrame:self.view.frame];
    }
    else
    {
        scribbleView = [[DLAStageScribble alloc] initWithFrame: self.view.frame];
    }
    
    //TODO understand this
    [self.view insertSubview:scribbleView atIndex:0];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
-(void)changeLineColor: (UIButton *) sender
{
    [scribbleView setLineColor:sender.backgroundColor];
}

-(void)undo
{
    NSLog(@"undo vc");
    [scribbleView undo];
}

-(void)clearStage
{
    NSLog(@"clear vc");
    [scribbleView clearStage];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

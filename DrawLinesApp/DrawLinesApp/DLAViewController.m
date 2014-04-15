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

@interface DLAViewController ()

@end

@implementation DLAViewController
{
    DLAStageScribble * scribbleView;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        
        
//        self.view = [[DLAStageLines alloc] initWithFrame:self.view.frame];
        self.view = [[DLAStageScribble alloc] initWithFrame:self.view.frame];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    scribbleView = [[DLAStageScribble alloc] initWithFrame:self.view.frame];
//    [self.view addSubview:scribbleView];
    
//    scribbleView.lineColor = [UIColor blueColor];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

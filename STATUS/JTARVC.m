//
//  JTARVC.m
//  STATUS
//
//  Created by Austen Johnson on 5/19/14.
//  Copyright (c) 2014 Austen Johnson. All rights reserved.
//

#import "JTARVC.h"
#import "JTASmileViewController.h"
#import "JTASelectedViewController.h"

@interface JTARVC ()

@property (nonatomic) NSMutableArray * squares;


@end

@implementation JTARVC
{
    UIButton * moveButton1;
    NSMutableArray * colors;
    UIImageView * chooseColor;
    UIButton * square;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        self.view.backgroundColor = [UIColor whiteColor];
        
        moveButton1 = [UIButton buttonWithType:UIButtonTypeCustom];
        [moveButton1 setFrame:CGRectMake(self.view.frame.size.width / 2 - 40, 400, 48, 66)];
        [moveButton1 setImage:[UIImage imageNamed:@"arrow"] forState:UIControlStateNormal];
        [moveButton1 addTarget:self action:@selector(launchSmiley) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:moveButton1];
        
        colors = [@[@"colors_1", @"colors_2", @"colors_3", @"colors_4", @"colors_5", @"colors_6", @"colors_7", @"colors_8", @"colors_9"] mutableCopy];
        
        chooseColor = [[UIImageView alloc] initWithFrame:CGRectMake(64, 128, 64, 64)];
        [chooseColor setImage:[UIImage imageNamed:@"squares"]];
        [self.view insertSubview:chooseColor atIndex:0];
        
        [self createSquares];
        
        
    }
    return self;
}

- (void)createSquares
{
    NSLog(@"createSquares(): about to create color buttons");
    int cols = 2;
    int rows = 3;
    float width = 64;
    float height = 64;
    
    for (int c = 0; c < cols; c++)
    {
        for (int r = 0; r < rows; r++)
        {
            float squareX = ((width) * c) + 64;
            float squareY = ((height) * r) + 128;
            
            square = [[UIButton alloc] initWithFrame:CGRectMake(squareX + 8, squareY + 8, width - 16, height - 16)];
            [square addTarget:self action:@selector(chosenColor:) forControlEvents:UIControlEventTouchUpInside];
            [square setImage:[UIImage imageNamed:colors[r*3+c]] forState:UIControlStateNormal];
            square.tag = c*3+r;
            [self.view addSubview:square];
        }
    }
}

- (void)chosenColor:(UIButton *)sender
{
    // set a global for your selected color
    self.colorTag = sender.tag;
    CGPoint location = CGPointMake(sender.frame.origin.x, sender.frame.origin.y);
    chooseColor.frame = CGRectMake(location.x - 8, location.y - 8, 64, 64);
}

- (void)launchSmiley
{
    JTASmileViewController * smileView = [[JTASmileViewController alloc] initWithNibName:nil bundle:nil];
    // smileView set color based on selected color
    
    smileView.colorTag = self.colorTag;
    [self.navigationController pushViewController:smileView animated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

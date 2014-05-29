//
//  JTASmileViewController.m
//  STATUS
//
//  Created by Austen Johnson on 5/19/14.
//  Copyright (c) 2014 Austen Johnson. All rights reserved.
//

#import "JTASmileViewController.h"
#import "JTARVC.h"
#import "JTASelectedViewController.h"


@interface JTASmileViewController ()
@end

@implementation JTASmileViewController
{
    JTASelectedViewController * selectedView;
    UIButton * moveButton2;
    NSMutableArray * smiles;
    NSMutableArray * angry;
    UIImageView * chosenButton;
    int faceTag;
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
        
        self.view.backgroundColor = [UIColor whiteColor];
        
        moveButton2 = [UIButton buttonWithType:UIButtonTypeCustom];
        [moveButton2 setFrame:CGRectMake(self.view.frame.size.width / 2 - 40, 400, 48, 66)];
        [moveButton2 setImage:[UIImage imageNamed:@"arrow"] forState:UIControlStateNormal];
        [moveButton2 addTarget:self action:@selector(smileView) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:moveButton2];
        
        smiles = [@[@"smilies_1", @"smilies_2", @"smilies_3", @"smilies_4", @"smilies_5", @"smilies_6", @"smilies_7", @"smilies_8", @"smilies_9"] mutableCopy];
        
        angry = [@[@"angry_1", @"angry_2", @"angry_3", @"angry_4", @"angry_5", @"angry_6", @"angry_7", @"angry_8", @"angry_9",] mutableCopy];
        
        chosenButton = [[UIImageView alloc] initWithFrame:CGRectMake(64, 192, 48, 48)];
        [chosenButton setImage:[UIImage imageNamed:@"squares"]];
//        [self createSmiles];
    }
    return self;
}

- (void)createSmiles
{
    int cols = 3;
    int rows = 3;
    float width = 64;
    float height = 64;
    
    for (int c = 0; c < cols; c++)
    {
        for (int r = 0; r < rows; r++)
        {
            float squareX = ((width) * c) + 64;
            float squareY = ((height) * r) + 128;
            
            // change array based on selected color property
            
            UIButton * smile = [[UIButton alloc] initWithFrame:CGRectMake(squareX + 8, squareY + 8, width -16, height - 16)];
            [smile addTarget:self action:@selector(chosenSmile:) forControlEvents:UIControlEventTouchUpInside];
            [smile setImage:[UIImage imageNamed:smiles[r*3+c]] forState:UIControlStateNormal];
            smile.tag = r*3+c;
            if (self.colorTag == 3)
            {
                [smile setImage:[UIImage imageNamed:angry[r*3+c]] forState:UIControlStateNormal];
            }
            [self.view addSubview:smile];
        }
    }
}

- (void)chosenSmile:(UIButton *)sender
{
    faceTag = sender.tag;
    CGPoint location = CGPointMake(sender.frame.origin.x, sender.frame.origin.y);
    chosenButton.frame = CGRectMake(location.x - 8, location.y - 8, 64, 64);
    [self.view insertSubview:chosenButton atIndex:0];
}

- (void)smileView
{
    selectedView = [[JTASelectedViewController alloc] init];
    selectedView.faceTag = faceTag;
    [self.navigationController pushViewController:selectedView animated:YES];
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

-(void)setColorTag:(int)colorTag
{
    _colorTag = colorTag;
    [self createSmiles];
}

@end

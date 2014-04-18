//
//  BBAViewController.m
//  BrickBreaker
//
//  Created by Austen Johnson on 4/17/14.
//  Copyright (c) 2014 Austen Johnson. All rights reserved.
//

#import "BBAViewController.h"
#import "BBALevelController.h"

@interface BBAViewController () <BBALevelDelegate>

@end

@implementation BBAViewController
{
    BBALevelController * level;
    UIButton * startButton;
    UILabel * scoreBoard;
    UIView * footer;
    UILabel * footerText;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        footer = [[UIView alloc] initWithFrame:CGRectMake(0, 280, 480, 40)];
        footer.backgroundColor = [UIColor greenColor];
        
        footerText = [[UILabel alloc] initWithFrame:CGRectMake(20, 280, 200, 40)];
        footerText.textColor = [UIColor blackColor];
//        footerText.text = @"Additional Lives  5";
        footerText.backgroundColor = [UIColor clearColor];
        [self.view addSubview:footer];
        [footer addSubview:footerText];
        
        scoreBoard = [[UILabel alloc] initWithFrame:CGRectMake(370, 250, 300, 100)];
        scoreBoard.textColor = [UIColor blackColor];
        scoreBoard.text = @"Score  0";
        scoreBoard.backgroundColor = [UIColor clearColor];
        [self.view addSubview:scoreBoard];
        
        
        
        // Custom initialization
    }
    return self;
}

-(void)reduceLives:(int)lives
{
    footerText.text = [NSString stringWithFormat:@"Additional Lives  %d", lives];
    [self.view addSubview:footerText];
}

- (void)addPoints:(int)points
{
    scoreBoard.text = [NSString stringWithFormat:@"Score  %d", points];
    [self.view addSubview:scoreBoard];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    startButton = [[UIButton alloc] initWithFrame:CGRectMake(180, 120, 140, 60)];
    [startButton setTitle:@"START" forState:UIControlStateNormal];
    [startButton addTarget:self action:@selector(resetNewGame) forControlEvents: UIControlEventTouchUpInside];
    startButton.backgroundColor = [UIColor yellowColor];
    startButton.layer.cornerRadius = 30;
    startButton.titleLabel.font = [UIFont boldSystemFontOfSize:12];
    [startButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:startButton];

}

- (void)gameDone
{
    [level.view removeFromSuperview];
    [self.view addSubview:startButton];
}

-(void)resetNewGame
{
    level = [[BBALevelController alloc] initWithNibName:nil bundle:nil];
    level.delegate = self;
    
    level.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 40);
    [self.view addSubview:level.view];
    
    [startButton removeFromSuperview];
    [level resetLevel];
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

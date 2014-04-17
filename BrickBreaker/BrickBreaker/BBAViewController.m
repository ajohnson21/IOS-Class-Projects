//
//  BBAViewController.m
//  BrickBreaker
//
//  Created by Austen Johnson on 4/17/14.
//  Copyright (c) 2014 Austen Johnson. All rights reserved.
//

#import "BBAViewController.h"
#import "BBALevelController.h"

@interface BBAViewController ()

@end

@implementation BBAViewController
{
    BBALevelController * level;
    UIButton * startButton;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        
        
        
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    level = [[BBALevelController alloc] initWithNibName:nil bundle:nil];
    [self.view addSubview:level.view];
    
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

-(void)resetNewGame
{
    
   [level resetLevel];
    [startButton removeFromSuperview];
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

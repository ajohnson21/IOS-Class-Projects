//
//  CARRootViewController.m
//  Car
//
//  Created by Austen Johnson on 4/1/14.
//  Copyright (c) 2014 Austen Johnson. All rights reserved.
//

#import "CARRootViewController.h"
#import "CARGasPedal.h"
#import "CARIgnition.h"
#import "CARBrake.h"
#import "CARWheel.h"
#import "CARBumper.h"
#import "CARWindow.h"

@interface CARRootViewController ()

@end

@implementation CARRootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CARGasPedal *gasPEDAL = [[CARGasPedal alloc] init];
    gasPEDAL.frame = CGRectMake(120, 75, 25, 25);
    [gasPEDAL setTitle:@"GO" forState:UIControlStateNormal];
    [gasPEDAL addTarget:self action:@selector(pressgasPEDAL) forControlEvents: UIControlEventTouchUpInside];
    [self.view addSubview:gasPEDAL];
    
    CARBrake *brakePEDAL = [[CARBrake alloc] init];
    brakePEDAL.frame = CGRectMake(100, 75, 25, 25);
    [brakePEDAL setTitle:@"Stop" forState: UIControlStateNormal];
    [brakePEDAL addTarget:self action:@selector(pressbrakePEDAL) forControlEvents: UIControlEventTouchUpInside];
    [self.view addSubview:brakePEDAL];
    
    CARIgnition *startBUTTON = [[CARIgnition alloc] init];
    startBUTTON.frame = CGRectMake(150, 120, 15, 15);
    [startBUTTON setTitle:@"Start" forState:UIControlStateNormal];
    [startBUTTON addTarget:self action:@selector(pressstartBUTTON) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:startBUTTON];
    
    CARBumper *bumper = [[CARBumper alloc] init];
    //bumper.frame = CGRectMake(100, 100, 100, 100);
    [self.view addSubview:bumper];
    
    CARWindow *windshield = [[CARWindow alloc] init];
    windshield.frame = CGRectMake(20, 160, 280, 200);
    windshield.backgroundColor = [UIColor blackColor];
    windshield.alpha = 0.2;
    [self.view addSubview:windshield];
    
    
    CARWheel *wheel1 = [[CARWheel alloc] init];
    wheel1.frame = CGRectMake(20, 40, 40, 40);
    [self.view addSubview:wheel1];
    CARWheel *wheel2 = [[CARWheel alloc] init];
    wheel2.frame = CGRectMake(80, 40, 40, 40);
    [self.view addSubview:wheel2];
    CARWheel *wheel3 = [[CARWheel alloc] init];
    wheel3.frame = CGRectMake(140, 40, 40, 40);
    [self.view addSubview:wheel3];
    CARWheel *wheel4 = [[CARWheel alloc] init];
    wheel4.frame = CGRectMake(200, 40, 40, 40);
    [self.view addSubview:wheel4];
    
}

- (void) pressgasPEDAL
{
    NSLog(@"Pressed Gas");
}

- (void) pressbrakePEDAL
{
    NSLog(@"Pressed Break");
}

- (void) pressstartBUTTON
{
    NSLog(@"Pressed Start");
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

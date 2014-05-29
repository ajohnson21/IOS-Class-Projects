//
//  JTASelectedViewController.m
//  STATUS
//
//  Created by Austen Johnson on 5/19/14.
//  Copyright (c) 2014 Austen Johnson. All rights reserved.
//

#import "JTASelectedViewController.h"
#import "STTwitter.h"
#import <CoreLocation/CoreLocation.h>

@interface JTASelectedViewController () <CLLocationManagerDelegate>

@end

@implementation JTASelectedViewController
{
    UIButton * selectButton;
    UIImageView * bigSmile;
    UIButton * gPlus;
    UIButton * twitter;
    UIButton * fbook;
    STTwitterAPI * tweeter;
    UITextField * tweet;
    CLLocationManager * lManager;
    CLLocation * currentLocation;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        self.view.backgroundColor = [UIColor whiteColor];
        
        selectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [selectButton setFrame:CGRectMake(self.view.frame.size.width / 2 - 40, 400, 48, 66)];
        [selectButton setImage:[UIImage imageNamed:@"check"] forState:UIControlStateNormal];
        [selectButton addTarget:self action:@selector(endApp) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:selectButton];
        
        lManager = [[CLLocationManager alloc] init];
        lManager.delegate = self;
        [lManager startUpdatingLocation];

    }
    return self;
}
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    currentLocation = [locations objectAtIndex:0];
    [lManager stopUpdatingLocation];
    CLGeocoder * geoCoder = [[CLGeocoder alloc] init];
    
    [geoCoder reverseGeocodeLocation: currentLocation completionHandler:^(NSArray *placemarks, NSError *error)
     {
         CLPlacemark * placemark = [placemarks objectAtIndex:0];
         NSLog(@"Current Location Detected");
         NSLog(@"placemark %@", placemark);
         NSString * locatedAt = [[placemark.addressDictionary valueForKey:@"FormattedAddressLines"]componentsJoinedByString:@","];
         NSString * address = [[NSString alloc]initWithString:locatedAt];
         NSString * area = [[NSString alloc]initWithString:placemark.locality];
         NSLog(@"%@, %@", address, area);
     }];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    int w = [UIScreen mainScreen].bounds.size.width;
    int h = [UIScreen mainScreen].bounds.size.height;
    
    tweet = [[UITextField alloc] initWithFrame:CGRectMake(20, 20, w - 40, h - 296)];
    [self.view addSubview:tweet];
 
    twitter = [[UIButton alloc] initWithFrame:CGRectMake(96, 32, 48, 48)];
    [twitter setImage:[UIImage imageNamed:@"sm_twitter_g"] forState:UIControlStateNormal];
    [twitter addTarget:self action:@selector(tweet:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:twitter];
    
    fbook = [[UIButton alloc] initWithFrame:CGRectMake(162, 32, 48, 48)];
    [fbook setImage:[UIImage imageNamed:@"sm_facebook_g"] forState:UIControlStateNormal];
    [fbook addTarget:self action:@selector(facebook:) forControlEvents:UIControlEventTouchUpInside];
     [self.view addSubview:fbook];
    
}

- (void)bigSmiles
{
    NSArray * bigSmiles = @[@"yellow_1.png", @"yellow_2.png", @"yellow_3.png", @"yellow_4.png", @"yellow_5.png", @"yellow_6.png", @"yellow_7.png", @"yellow_8.png", @"yellow_9.png"];
    
    bigSmile = [[UIImageView alloc]initWithImage: [UIImage imageNamed:bigSmiles[self.faceTag]]];
    bigSmile.frame = CGRectMake(self.view.frame.size.width /2 - 100,self.view.frame.size.height /2 - 100, 192, 192);
    [self.view addSubview:bigSmile];
}

- (void)tweet:(id)sender
{
    _toggleIsOn1 = !_toggleIsOn1;

    if (_toggleIsOn1)
    {
        [twitter setImage:[UIImage imageNamed:@"sm_twitter"] forState:UIControlStateNormal];
        tweeter = [STTwitterAPI twitterAPIOSWithFirstAccount];
        [tweeter verifyCredentialsWithSuccessBlock:^(NSString *username) {
            
            NSLog(@"%@", username);
            
        } errorBlock:^(NSError *error) {
            NSLog(@"%@", error.userInfo);
        }];
    }
    else
    {
        [twitter setImage:[UIImage imageNamed:@"sm_twitter_g"] forState:UIControlStateNormal];
    }
}

- (void)facebook:(id)sender
{
    _toggleIsOn = !_toggleIsOn;
    
    if (_toggleIsOn)
    {
        [fbook setImage:[UIImage imageNamed:@"sm_facebook"] forState:UIControlStateNormal];
    }
    else
    {
        [fbook setImage:[UIImage imageNamed:@"sm_facebook_g"] forState:UIControlStateNormal];
    }
}

-(void)setFaceTag:(int)faceTag
{
    _faceTag = faceTag;
    [self bigSmiles];
}

-(void)endApp
{
    NSLog(@"This is the end!");
    [tweeter postStatusUpdate:tweet.text inReplyToStatusID:nil latitude:nil longitude:nil placeID:nil displayCoordinates:nil trimUser:nil successBlock:^(NSDictionary *status) {
        NSLog(@"%@", status);
    } errorBlock:^(NSError *error) {
        NSLog(@"%@", error.userInfo);
    }];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

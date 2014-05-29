//
//  LPAViewController.m
//  LilPlayA
//
//  Created by Austen Johnson on 5/13/14.
//  Copyright (c) 2014 Austen Johnson. All rights reserved.
//

#import "LPAViewController.h"
#import <AVFoundation/AVFoundation.h>


@interface LPAViewController ()

@end

@implementation LPAViewController
{
    AVAudioPlayer * player;
    UIButton * play;
    UIButton * stop;
    UIView * progressBar;
    UIView * ball;
    UILabel * timeLeftLabel;
    UIView * playedBar;
    UILabel * totalTimeLabel;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        int w = [UIScreen mainScreen].bounds.size.width;
        int h = [UIScreen mainScreen].bounds.size.height;
        

        
        UISlider * volume = [[UISlider alloc] initWithFrame:CGRectMake(70, (h-50)/2+100, w-140, 2)];
        volume.backgroundColor = [UIColor lightGrayColor];
        [volume addTarget:self action:@selector(sliderValue:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:volume];
        
        timeLeftLabel = [[UILabel alloc] initWithFrame:CGRectMake(260, (h-50)/2, 50, 100)];
        
        totalTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, h-50/2, 50, 100)];
        
        play = [UIButton buttonWithType:UIButtonTypeCustom];
        [play setFrame:CGRectMake(80, 200, 50, 50)];
        play.backgroundColor = [UIColor clearColor];
        play.layer.cornerRadius = 25;

        [play setImage:[UIImage imageNamed:@"playbutton.png"] forState:UIControlStateNormal];
        [play setImage: [UIImage imageNamed:@"1400014137_25_Pause.png"] forState:UIControlStateSelected];
        [self.view addSubview:play];
        
        
        stop = [[UIButton alloc] initWithFrame:CGRectMake(180, 200, 50, 50)];
        stop.backgroundColor = [UIColor clearColor];
        stop.layer.cornerRadius = 25;
        [stop setImage:[UIImage imageNamed:@"stopbutton.png"] forState:UIControlStateNormal];
        [self.view addSubview:stop];
        
        playedBar = [[UIView alloc] initWithFrame:CGRectMake(70, (h-50)/2+47, w-140, 7)];
        playedBar.backgroundColor = [UIColor orangeColor];
        [self.view addSubview:playedBar];
        
        
        progressBar = [[UIView alloc] initWithFrame:CGRectMake(70, (h - 50)/2+47, w - 140, 7)];
        progressBar.backgroundColor = [UIColor lightGrayColor];
        [self.view addSubview:progressBar];
        
        ball = [[UIView alloc] initWithFrame:CGRectMake(0, -2, 10, 10)];
        ball.backgroundColor = [UIColor redColor];
        ball.layer.cornerRadius = 5;
        [progressBar addSubview:ball];
        
       
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, (unsigned long)NULL), ^{
            
            NSURL * url = [NSURL URLWithString:@"https://api.soundcloud.com/tracks/147445565/download?client_id=2d87025c8392069f828c446b965862e3"];
            
             NSData * data = [NSData dataWithContentsOfURL:url];
            
            dispatch_async(dispatch_get_main_queue(), ^{
            
    //        NSError * error = nil;
           
            
            player = [[AVAudioPlayer alloc] initWithData:data error:nil];
                [play addTarget:self action:@selector(play:) forControlEvents:UIControlEventTouchUpInside];
                [stop addTarget:self action:@selector(stop:) forControlEvents:UIControlEventTouchUpInside];
                
            });
        });
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [player pause];
    [self.timer invalidate];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch * touch in touches)
    {
        CGPoint location = [touch locationInView:playedBar];
        ball.frame = CGRectMake(location.x, 0, 10, 10);
        [player play];
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch * touch in touches)
    {
        CGPoint location = [touch locationInView:playedBar];
        ball.frame = CGRectMake(location.x, 0, 10, 10);
        player.currentTime = location.x;
        [player play];
    }
}

-(void)sliderValue:(UISlider *)slider
{
    player.volume = slider.value;
}

-(void)play:(UIButton *)sender
{
    if(sender.selected == NO)
    {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateProgressBar) userInfo:nil repeats:YES];
        [player play];
        sender.selected = YES;
    }
    else
    {
        [player pause];
        sender.selected = NO;
    }
}

-(void)stop:(UIButton *)sender
{
    [player stop];
    player.currentTime = 0.0;
    play.selected = NO;
}

- (void)updateProgressBar
{
    
    NSTimeInterval playtime = [player currentTime];
    NSTimeInterval duration = [player duration];
    float pos = playtime/duration;
    NSLog(@"%f", pos);
    float xPosition = progressBar.frame.origin.x - 70;
    
    playedBar = [[UIView alloc] initWithFrame:CGRectMake(xPosition, 0, 180, 10)];
    [progressBar addSubview:playedBar];
    [playedBar addSubview:ball];
    
    
    
    NSTimeInterval timeLeft = player.duration - player.currentTime;
    
    int minutes = floor(timeLeft/ 60);
    int seconds = round(timeLeft - minutes * 60);
    
    timeLeftLabel.backgroundColor = [UIColor clearColor];
    timeLeftLabel.text = [NSString stringWithFormat:@"%02d:%02d", (int)minutes, (int)seconds];
 

    [self.view addSubview:timeLeftLabel];
    

    int mins = floor(player.currentTime/ 60);
    int secs = round(player.currentTime - minutes * 60);
    
    totalTimeLabel.backgroundColor = [UIColor clearColor];
    totalTimeLabel.textColor = [UIColor orangeColor];
    totalTimeLabel.text = [NSString stringWithFormat:@"%02d:%02d", (int)mins, (int)secs];

    [self.view addSubview:totalTimeLabel];
    
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

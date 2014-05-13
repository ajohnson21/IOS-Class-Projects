//
//  PNAViewController.m
//  PixelNoice
//
//  Created by Austen Johnson on 5/5/14.
//  Copyright (c) 2014 Austen Johnson. All rights reserved.
//

#import "PNAViewController.h"
#import <UIKit/UIKit.h>
#import "PNAPixelSounds.h"
#import <AVFoundation/AVFoundation.h>

@interface PNAViewController () <UICollisionBehaviorDelegate>

@property (nonatomic) UIDynamicAnimator * animator;

@property (nonatomic) UIView * ball;

@property (nonatomic) UICollisionBehavior * collider;


@end

@implementation PNAViewController
{
    UIGravityBehavior * gravityBeahvior;
    UICollisionBehavior * collisionBehavior;
    
    PNAViewController * sounds;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.view.backgroundColor = [UIColor blackColor];
        

        
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    UITouch * touch = [touches allObjects][0];
    CGPoint location = [touch locationInView:self.view];
    UIView * ball = [[UIView alloc] initWithFrame:CGRectMake(location.x,location.y, 10, 10)];
    ball.backgroundColor = [UIColor redColor];
    ball.layer.cornerRadius = 5;
    [self.view addSubview:ball];
    
  
    
    UIDynamicAnimator * animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    gravityBeahvior = [[UIGravityBehavior alloc] initWithItems:@[ball]];
    collisionBehavior = [[UICollisionBehavior alloc] initWithItems:@[ball]];
    [animator addBehavior:gravityBeahvior];
//    collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
    collisionBehavior.collisionDelegate = self;
    [animator addBehavior:collisionBehavior];
    self.animator = animator;
    
    int w = self.view.frame.size.width;
    int h = self.view.frame.size.height;
    
    [collisionBehavior addBoundaryWithIdentifier:@"floor" fromPoint:CGPointMake(0, h) toPoint:CGPointMake(w, h)];
    
}

-(void)playSoundWithName:(NSString *)soundName
{
    NSString * file = [[NSBundle mainBundle] pathForResource:soundName ofType:@"wav"];
    
    NSData * fileData = [NSData dataWithContentsOfFile:file];
    
    self.player = [[AVAudioPlayer alloc] initWithData:fileData error:nil];
    
    self.player.numberOfLoops = 0;
    
    [self.player play];
    
}



-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}

-(void)collisionBehavior:(UICollisionBehavior *)behavior beganContactForItem:(id<UIDynamicItem>)item withBoundaryIdentifier:(id<NSCopying>)identifier atPoint:(CGPoint)p
{
    NSLog(@"%@",identifier);
    if ([(NSString *)identifier isEqualToString:@"floor"])
       
    {
         [self playSoundWithName:@"electric_alert"];
        UIView * ball = (UIView *)item;
//        [ball removeFromSuperview];
        [self.collider removeItem:ball];
        
    }
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

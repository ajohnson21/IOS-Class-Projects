//
//  BBALevelController.m
//  BrickBreaker
//
//  Created by Austen Johnson on 4/17/14.
//  Copyright (c) 2014 Austen Johnson. All rights reserved.
//

#import "BBALevelController.h"

@interface BBALevelController () <UICollisionBehaviorDelegate>

@property (nonatomic) UIView * paddle;
@property (nonatomic) NSMutableArray * balls;
@property (nonatomic) NSMutableArray * bricks;

// dynamics animator
@property (nonatomic) UIDynamicAnimator * animator;

// pushes the ball
@property (nonatomic) UIPushBehavior * pusher;

// handles collisions
@property (nonatomic) UICollisionBehavior * collider;

// item behavior properties
@property (nonatomic) UIDynamicItemBehavior * paddleDynamicsProperties;
@property (nonatomic) UIDynamicItemBehavior * ballsDynamicsProperties;
@property (nonatomic) UIDynamicItemBehavior * bricksDynamicsProperties;

// item attachment
@property (nonatomic) UIAttachmentBehavior * attacher;

@end

////////////////////////////////////////////////////////////////////////////////////////

@implementation BBALevelController
{
    float paddleWidth;
    float points;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.bricks = [@[] mutableCopy];
        self.balls = [@[] mutableCopy];
        
        paddleWidth = 80;
        self.view.backgroundColor = [UIColor colorWithWhite:0.1 alpha:1.0];
        
        points = 0;
        
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
}

-(void)resetLevel
{
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    
    [self createPaddle];
    [self createBall];
    [self createBricks];
    
    self.collider = [[UICollisionBehavior alloc] initWithItems:[self allItems]];
    
    self.collider.collisionDelegate = self;
    self.collider.collisionMode = UICollisionBehaviorModeEverything;
    self.collider.translatesReferenceBoundsIntoBoundary = YES;
    
    [self.animator addBehavior:self.collider];
    
    self.ballsDynamicsProperties = [self createPropertiesForItems:self.balls];
    self.bricksDynamicsProperties = [self createPropertiesForItems:self.bricks];
    self.paddleDynamicsProperties = [self createPropertiesForItems:@[self.paddle]];
    
    self.paddleDynamicsProperties.density = 1000000.0f;
    self.bricksDynamicsProperties.density = 1000000.0f;
    
    self.ballsDynamicsProperties.elasticity = 1.0;
    self.ballsDynamicsProperties.resistance = 0;

    
//    self.ballsDynamicsProperties = [[UIDynamicItemBehavior alloc] initWithItems:self.balls];
}

-(void)collisionBehavior:(UICollisionBehavior *)behavior beganContactForItem:(id<UIDynamicItem>)item1 withItem:(id<UIDynamicItem>)item2 atPoint:(CGPoint)p;
{
    UIView * tempBrick;
    for (UIView * brick in self.bricks)
    {
        if ([item1 isEqual:brick] || [item2 isEqual:brick])
        {
            if (brick.alpha == 0.5)
            {
                tempBrick = brick;
                
                UILabel * brickLabel = [[UILabel alloc] initWithFrame:CGRectMake(tempBrick.frame.origin.x, 0, 100, 30)];
                brickLabel.text = @"+100";
                brickLabel.backgroundColor = [UIColor clearColor];
                brickLabel.textColor = [UIColor redColor];
                [self.view addSubview:brickLabel];
                

                
                [brick removeFromSuperview];
                [self.collider removeItem:brick];
        
                points += 100;

                
                NSLog(@"Total Points =  %f", points);
                
            }
            
                brick.alpha = 0.5;
            
        }
    }
//
    
    if (tempBrick != nil) [self.bricks removeObjectIdenticalTo:tempBrick];
    
}

-(UIDynamicItemBehavior *)createPropertiesForItems:(NSArray *)items
{

    UIDynamicItemBehavior * properties = [[UIDynamicItemBehavior alloc] initWithItems:items];
    properties.allowsRotation = NO;
    properties.friction = 0;
    [self.animator addBehavior:properties];
    return properties;
}

-(NSArray *)allItems
{
    NSMutableArray * items = [@[self.paddle] mutableCopy];
    
    for (UIView * item in self.balls) [items addObject:item];
    for (UIView * item in self.bricks) [items addObject:item];
    
    return items;
}

-(void)createPaddle
{
    self.paddle = [[UIView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - paddleWidth) / 2, SCREEN_HEIGHT - 20, paddleWidth, 6)];
    
    self.paddle.backgroundColor = [UIColor colorWithWhite:0.5 alpha:1.0];
    self.paddle.layer.cornerRadius = 3;
    
    [self.view addSubview:self.paddle];
}

-(void)createBricks
{
    int brickCols = 8;
    float brickWidth = (SCREEN_WIDTH - (10 * (brickCols + 1))) / brickCols;
    
    for (int i = 0; i < brickCols; i++)
    {
        float brickX = ((brickWidth + 10) * i) + 10;
        UIView * brick = [[UIView alloc] initWithFrame:CGRectMake(brickX, 10, brickWidth, 30)];
        
        brick.layer.cornerRadius = 6;
        brick.backgroundColor = [UIColor colorWithWhite:0.3 alpha:1.0];
        
        [self.view addSubview:brick];
        [self.bricks addObject:brick];
    }
}

-(void)createBall
{
    CGRect frame = self.paddle.frame;
    
    UIView * ball = [[UIView alloc] initWithFrame:CGRectMake(frame.origin.x, frame.origin.y -12, 10, 10)];
    ball.backgroundColor = [UIColor redColor];
    ball.layer.cornerRadius = 5;
    
    [self.view addSubview:ball];
    
    // add ball to balls array
    [self.balls addObject:ball];
    
    // start ball off with a push
    self.pusher = [[UIPushBehavior alloc] initWithItems:self.balls mode:UIPushBehaviorModeInstantaneous];
    
    
    self.pusher.pushDirection = CGVectorMake(0.04, 0.04);
    self.pusher.active = YES;
    
    [self.animator addBehavior:self.pusher];
}

@end

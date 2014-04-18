//
//  BBALevelController.m
//  BrickBreaker
//
//  Created by Austen Johnson on 4/17/14.
//  Copyright (c) 2014 Austen Johnson. All rights reserved.
//

#import "BBALevelController.h"
#import "MOVE.h"

@interface BBALevelController () <UICollisionBehaviorDelegate>

@property (nonatomic) UIImageView * paddle;
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
    int points;
    int lives;
    UILabel * footerText;
    UIView * footer;
    UILabel * scoreBoard;
    UIImageView * ball1;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.bricks = [@[] mutableCopy];
        self.balls = [@[] mutableCopy];
        
        paddleWidth = 80;
        points = 0;
        lives = 5;
        
        self.view.backgroundColor = [UIColor colorWithWhite:0.1 alpha:1.0];
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapScreen:)];
        [self.view addGestureRecognizer:tap];
        
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
    [self.delegate reduceLives:(int)lives];

    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    
    [self createPaddle];
    [self createBall];
    [self createBricks];
    
    self.collider = [[UICollisionBehavior alloc] initWithItems:[self allItems]];
    
    self.collider.collisionDelegate = self;
    self.collider.collisionMode = UICollisionBehaviorModeEverything;
//        self.collider.translatesReferenceBoundsIntoBoundary = YES;
    
    int w = self.view.frame.size.width;
    int h = self.view.frame.size.height;
    
    [self.collider addBoundaryWithIdentifier:@"ceiling" fromPoint:CGPointMake(0,0) toPoint:CGPointMake
     (w, 0)];
    
    [self.collider addBoundaryWithIdentifier:@"leftWall" fromPoint:CGPointMake(0,0) toPoint:CGPointMake(0, h)];
    
    [self.collider addBoundaryWithIdentifier:@"rightWall" fromPoint:CGPointMake(w, 0) toPoint:CGPointMake(w, h)];
    
    [self.collider addBoundaryWithIdentifier:@"floor" fromPoint:CGPointMake(0, h + 10) toPoint:CGPointMake(w, h + 10)];
    
    
    [self.animator addBehavior:self.collider];
    
    self.ballsDynamicsProperties = [self createPropertiesForItems:self.balls];
    self.bricksDynamicsProperties = [self createPropertiesForItems:self.bricks];
    self.paddleDynamicsProperties = [self createPropertiesForItems:@[self.paddle]];
    
    self.paddleDynamicsProperties.density = 1000000.0f;
    self.bricksDynamicsProperties.density = 1000000.0f;
    
    self.ballsDynamicsProperties.elasticity = 1.0;
    self.ballsDynamicsProperties.resistance = 0;
    
    footerText.text = @"Additional Lives  5";

    
    
    
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
                
                UILabel * brickLabel = [[UILabel alloc] initWithFrame:brick.frame];
                brickLabel.text = [NSString stringWithFormat:@"+%d",(int)brick.tag];
                brickLabel.backgroundColor = [UIColor clearColor];
                brickLabel.textColor = [UIColor redColor];
                [self.view addSubview:brickLabel];
                [MOVE animateView:brickLabel properties:@{@"alpha":@0, @"duration":@0.6,@"delay":@0.0,@"remove":@YES}];
                
                [brick removeFromSuperview];
                [self.collider removeItem:brick];
                
                NSLog(@"Total Points =  %d", points);
                points += brick.tag;
                [self.delegate addPoints:(int)points];
            }
            brick.alpha = 0.5;
        }
        
    }
    if (tempBrick != nil) [self.bricks removeObjectIdenticalTo:tempBrick];
}

-(void)collisionBehavior:(UICollisionBehavior *)behavior beganContactForItem:(id<UIDynamicItem>)item withBoundaryIdentifier:(id<NSCopying>)identifier atPoint:(CGPoint)p
{
    if ([(NSString *)identifier isEqualToString:@"floor"])
    {
        UIView * ball = (UIView *)item;
        [ball removeFromSuperview];
        [self.collider removeItem:ball];
        lives -= 1;
        
        [self.delegate reduceLives:(int)lives];
        
        if ([self.delegate respondsToSelector:@selector(gameDone)])
        {
            [self.delegate gameDone];
        }
    }
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
    self.paddle = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - paddleWidth) / 2, SCREEN_HEIGHT - 60, paddleWidth, 10)];
    self.paddle.image = [UIImage imageNamed:@"baseball2"];
    
    //    self.paddle.backgroundColor = [UIColor colorWithWhite:0.5 alpha:1.0];
    self.paddle.backgroundColor = [UIColor clearColor];
    self.paddle.layer.cornerRadius = 3;
    
    [self.view addSubview:self.paddle];
    
    
    self.attacher = [[UIAttachmentBehavior alloc] initWithItem:self.paddle attachedToAnchor:CGPointMake(CGRectGetMidX(self.paddle.frame), CGRectGetMidY(self.paddle.frame))];
    
    [self.animator addBehavior:self.attacher];
    
}

-(void)createBricks
{
    int brickCols = 8;
    int brickRows = 4;
    float brickWidth = (SCREEN_WIDTH - (10 * (brickCols + 1))) / brickCols;
    float brickHeight = 20;
    
    for (int c = 0; c < brickCols; c++)
    {
        for (int r = 0; r < brickRows; r++)
        {
            float brickX = ((brickWidth + 10) * c) + 10;
            float brickY = ((brickHeight + 10) * r) + 10;
            
            UIView * brick = [[UIView alloc] initWithFrame:CGRectMake(brickX, brickY, brickWidth, brickHeight)];
            
            brick.layer.cornerRadius = 6;
            brick.backgroundColor = [UIColor colorWithWhite:0.3 alpha:1.0];
            
            [self.view addSubview:brick];
            [self.bricks addObject:brick];
            
            int random = arc4random_uniform(5) * 50;
            brick.tag = random;
        }
    }
}

-(void)createBall
{
    int ballcount = 4;
    
    for (int i = 0; i < ballcount; i++)
    {
        
        CGRect frame = self.paddle.frame;
        
        
        ball1 = [[UIImageView alloc] initWithFrame:CGRectMake(frame.origin.x, frame.origin.y -12, 10, 10)];
        ball1.image = [UIImage imageNamed:@"BaseBallB.png"];
        ball1.backgroundColor = [UIColor redColor];
        ball1.layer.cornerRadius = 5;
        
        [self.view addSubview:ball1];
        
        // add ball to balls array
        [self.balls addObject:ball1];
        
        // start ball off with a push
        self.pusher = [[UIPushBehavior alloc] initWithItems:self.balls mode:UIPushBehaviorModeInstantaneous];
        
        
        self.pusher.pushDirection = CGVectorMake(0.009, 0.009);
        self.pusher.active = YES;
        
        [self.animator addBehavior:self.pusher];
    }
}
-(void)tapScreen:(UITapGestureRecognizer *)gr
{
    CGPoint location = [gr locationInView:self.view];
    self.attacher.anchorPoint = CGPointMake(location.x, self.attacher.anchorPoint.y);
}

@end

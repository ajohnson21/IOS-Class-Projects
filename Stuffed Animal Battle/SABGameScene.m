//
//  SABGameScene.m
//  Stuffed Animal Battle
//
//  Created by Austen Johnson on 5/15/14.
//  Copyright (c) 2014 Austen Johnson. All rights reserved.
//

#import "SABGameScene.h"

////////

// health points for players
// make the hp bars represent HP points per player
// make fireball remove HP points
// sound effects to explosion, landing after jumping

// research sprite characters
// find random pictures online for character

////////


@interface SABGameScene () <SKPhysicsContactDelegate>

@end

@implementation SABGameScene
{

    
    SKLabelNode * timerLabel;
    SKSpriteNode * player1HPBar;
    SKSpriteNode * player2HPBar;
    
    SKSpriteNode * buttonA;
    SKSpriteNode * buttonB;
    
    SKSpriteNode * dPadUp;
    SKSpriteNode * dPadDown;
    SKSpriteNode * dPadLeft;
    SKSpriteNode * dPadRight;
    
    SKSpriteNode * player1;
    SKSpriteNode * player2;
    
    SKTextureAtlas * charAtlas;
    
    float barArea;
}

- (instancetype)initWithSize:(CGSize)size
{
    self = [super initWithSize:size];
    if (self)
    {
        
        SKPhysicsBody * scenePhysics = [SKPhysicsBody bodyWithEdgeLoopFromRect:CGRectMake(0, 0, size.width, size.height)];
        self.physicsBody = scenePhysics;
        self.physicsWorld.contactDelegate = self;
        
        timerLabel = [SKLabelNode node];
        timerLabel.position = CGPointMake(SCREEN_WIDTH / 2.0, SCREEN_HEIGHT - 25);
        timerLabel.text = @"00:00";
        timerLabel.fontColor = [SKColor greenColor];
        timerLabel.fontSize = 20.0;
        [self addChild:timerLabel];
        
         barArea = ((SCREEN_WIDTH - 60) / 2.0) - 20;
        
        
        SKSpriteNode * floor = [SKSpriteNode spriteNodeWithColor:[SKColor yellowColor] size:CGSizeMake(SCREEN_WIDTH, 30)];
        floor.position = CGPointMake(SCREEN_WIDTH / 2.0, 10);
        [self addChild:floor];
        
        SKPhysicsBody * floorPhysics = [SKPhysicsBody bodyWithRectangleOfSize:floor.size];
        floorPhysics.affectedByGravity = NO;
        floorPhysics.dynamic = NO;
        floor.physicsBody = floorPhysics;
        
        player1HPBar = [SKSpriteNode spriteNodeWithColor:[SKColor lightGrayColor] size:CGSizeMake(barArea, 20)];
        player1HPBar.position = CGPointMake((barArea + 20) / 2, SCREEN_HEIGHT - 20.0);
        [self addChild:player1HPBar];
        
        player2HPBar = [SKSpriteNode spriteNodeWithColor:[SKColor lightGrayColor] size:CGSizeMake(barArea, 20)];
        player2HPBar.position = CGPointMake(SCREEN_WIDTH - (barArea + 20) / 2, SCREEN_HEIGHT - 20.0);
        [self addChild:player2HPBar];
        
        buttonA = [SKSpriteNode spriteNodeWithColor:[SKColor redColor] size:CGSizeMake(40, 40)];
        buttonA.position = CGPointMake(SCREEN_WIDTH - 40, 90);
        [self addChild:buttonA];
        
        buttonB = [SKSpriteNode spriteNodeWithColor:[SKColor redColor] size:CGSizeMake(40, 40)];
        buttonB.position = CGPointMake(SCREEN_WIDTH - 80, 50);
        [self addChild:buttonB];
        
        dPadDown = [SKSpriteNode spriteNodeWithColor:[SKColor blueColor] size:CGSizeMake(30, 30)];
        dPadDown.position = CGPointMake(80, 40);
        [self addChild:dPadDown];
        
        dPadUp = [SKSpriteNode spriteNodeWithColor:[SKColor blueColor] size:CGSizeMake(30, 30)];
        dPadUp.position = CGPointMake(80, 120);
        [self addChild:dPadUp];
        
        dPadLeft = [SKSpriteNode spriteNodeWithColor:[SKColor blueColor] size:CGSizeMake(30, 30)];
        dPadLeft.position = CGPointMake(40, 80);
        [self addChild:dPadLeft];
        
        dPadRight = [SKSpriteNode spriteNodeWithColor:[SKColor blueColor] size:CGSizeMake(30, 30)];
        dPadRight.position = CGPointMake(120, 80);
        [self addChild:dPadRight];
        
        charAtlas = [SKTextureAtlas atlasNamed:@"char"];
        
        
        
        player1 = [SKSpriteNode spriteNodeWithImageNamed:charAtlas.textureNames[0]];
        player1.position = CGPointMake(SCREEN_WIDTH / 4.0, 80);
        [self addChild:player1];
        
        player2 = [SKSpriteNode spriteNodeWithImageNamed:charAtlas.textureNames[0]];
        player2.position = CGPointMake(SCREEN_WIDTH * 0.75, 80);
        [self addChild:player2];
        
        SKPhysicsBody * playerPhysics = [SKPhysicsBody bodyWithRectangleOfSize:player1.size];
        player1.physicsBody = playerPhysics;
        
        SKPhysicsBody * playerPhysics2 = [SKPhysicsBody bodyWithRectangleOfSize:player2.size];
        player2.physicsBody = playerPhysics2;
        player2.userData = [@{@"type":@"player2"} mutableCopy];
        player2.physicsBody.contactTestBitMask = 1;

        
    }
    return self;
}

- (void)update:(NSTimeInterval)currentTime
{
    
}

-(void)didBeginContact:(SKPhysicsContact *)contact
{
    NSArray * nodes = @[contact.bodyA.node, contact.bodyB.node];
    
    for (SKNode * node in nodes)
    {
        if ([node.userData[@"type"] isEqualToString:@"fireball"])
        {
            [node removeFromParent];
            
            NSString *myParticlePath = [[NSBundle mainBundle] pathForResource:@"MyParticle" ofType:@"sks"];
            
            SKEmitterNode * explosion = [NSKeyedUnarchiver unarchiveObjectWithFile:myParticlePath];
            explosion.position = contact.contactPoint;
            explosion.numParticlesToEmit = 100;
            [self addChild:explosion];
            
            barArea -= 20;
            
//            [player1HPBar removeFromParent];
//            player1HPBar = [SKSpriteNode spriteNodeWithColor:[SKColor lightGrayColor] size:CGSizeMake(barArea, 20)];
//            player1HPBar.position = CGPointMake((barArea + 20) / 2, SCREEN_HEIGHT - 20.0);
//            [self addChild:player1HPBar];
            
            
            [player2HPBar removeFromParent];
            player2HPBar = [SKSpriteNode spriteNodeWithColor:[SKColor lightGrayColor] size:CGSizeMake(barArea, 20)];
            player2HPBar.position = CGPointMake(SCREEN_WIDTH - (barArea + 20) / 2, SCREEN_HEIGHT - 20.0);
            [self addChild:player2HPBar];
    
        }
    }
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch * touch = [touches anyObject];
    
    CGPoint location = [touch locationInNode:self];
    
    [self testButtonWithLocation:location];
}

-(void)buttonClick:(UIButton *)sender
{
    NSLog(@"%@", sender);
}

- (void)testButtonWithLocation:(CGPoint)location;
{
    NSArray * buttons = @[buttonA, buttonB, dPadUp, dPadDown, dPadLeft, dPadRight];
    
    for (SKNode * button in buttons)
    {
        if ([button containsPoint:location])
        {
            switch ([buttons indexOfObject:button])
            {
                case 0:
                {
                    NSLog(@"Fire"); // A Button
                    
                    NSString *myParticlePath = [[NSBundle mainBundle] pathForResource:@"MyParticleFire" ofType:@"sks"];
                    
                    SKEmitterNode * fireball = [NSKeyedUnarchiver unarchiveObjectWithFile:myParticlePath];
                    
                    fireball.position = CGPointMake(player1.position.x + 40, player1.position.y);
                    SKPhysicsBody * fireballPhysics = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(10, 10)];
                    fireball.physicsBody.categoryBitMask = 1;
                    fireball.physicsBody = fireballPhysics;
                    fireballPhysics.affectedByGravity = NO;
                    fireball.userData = [@{@"type":@"fireball"} mutableCopy];
                    [self addChild:fireball];
                    [fireball.physicsBody applyImpulse:CGVectorMake(6.0, 0.0)];

                }
                    break;
                case 1:
                    NSLog(@"Kick"); // B Button
                    break;
                    
                case 2:
                
                    NSLog(@"Jump"); //Up
                {
//                    for (NSString * textureName in charAtlas.textureNames)
//                    {
//                        NSLog(@"%@", textureName);
//                    }
                    
                    NSMutableArray * textures = [@[] mutableCopy];
                    
                    for (int i = 1; i < charAtlas.textureNames.count + 1; i++)
                    {
                        [textures addObject:[charAtlas textureNamed:[NSString stringWithFormat:@"charframe%d", i]]];
                    }
            
                    
                    SKAction * setFrame2 = [SKAction animateWithTextures:textures timePerFrame:0.2];
                    [player1 runAction:setFrame2];
                    
                    [player1.physicsBody applyImpulse:CGVectorMake(0.0, 100.0)];
                }
                    break;
                case 3:
                {
                    NSLog(@"Duck"); //Down
                    
                    SKAction *moveDuck = [SKAction moveToY:player1.position.y - 40 duration:0.1];
                    [player1 runAction:moveDuck];
                }
                    break;
                case 4:
                
                    NSLog(@"Left"); //Left
                    
                    [player1.physicsBody applyImpulse:CGVectorMake(-20.0, 0.0)];

                
                    break;
                case 5:
                {
                    NSLog(@"Right"); //Right
                    
                    [player1.physicsBody applyImpulse:CGVectorMake(20.0, 0.0)];
                }
                    break;
                    
            }
        }
    }
}

@end

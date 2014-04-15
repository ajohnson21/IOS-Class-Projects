//
//  SCGstageVC.m
//  squares
//
//  Created by Austen Johnson on 4/11/14.
//  Copyright (c) 2014 Austen Johnson. All rights reserved.
//

#import "SCGStageVC.h"

#import "SCGSquare.h"


@implementation SCGStageVC
{
    int gameSize;   //declares throughout entire file
    NSArray * playerColors;
    int playerTurn;
    NSMutableDictionary * tappedDots;
    NSMutableDictionary * allSquares;
    UIView * gameBoard;
    UIButton * backButton;
    UIButton * newGame;
    UIButton * sizeButton1;
    UIButton * sizeButton2;
    UIButton * sizeButton3;
//    UIView * home;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        playerColors = @[BLUE_COLOR, ORANGE_COLOR];
        playerTurn = 0;
        tappedDots = [@{} mutableCopy];
        allSquares = [@{} mutableCopy];
        
        gameSize = 6;
    }
    return self;
}


- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    
    sizeButton1 = [[UIButton alloc] initWithFrame:CGRectMake(50, 400, 100, 40)];
    [sizeButton1 setTitle:@"6" forState:UIControlStateNormal];
    [sizeButton1 addTarget:self action:@selector(gameSizeChange1) forControlEvents: UIControlEventTouchUpInside];
    sizeButton1.backgroundColor = [UIColor blackColor];
    sizeButton1.layer.cornerRadius = 6;
    sizeButton1.titleLabel.font = [UIFont boldSystemFontOfSize:12];
    [sizeButton1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:sizeButton1];
    
    sizeButton2 = [[UIButton alloc] initWithFrame:CGRectMake(110, 400, 100, 40)];
    [sizeButton2 setTitle:@"8" forState:UIControlStateNormal];
    [sizeButton2 addTarget:self action:@selector(gameSizeChange2) forControlEvents: UIControlEventTouchUpInside];
    sizeButton2.backgroundColor = [UIColor blackColor];
    sizeButton2.layer.cornerRadius = 6;
    sizeButton2.titleLabel.font = [UIFont boldSystemFontOfSize:12];
    [sizeButton2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:sizeButton2];
    
    sizeButton3 = [[UIButton alloc] initWithFrame:CGRectMake(170, 400, 100, 40)];
    [sizeButton3 setTitle:@"12" forState:UIControlStateNormal];
    [sizeButton3 addTarget:self action:@selector(gameSizeChange3) forControlEvents: UIControlEventTouchUpInside];
    sizeButton3.backgroundColor = [UIColor blackColor];
    sizeButton3.layer.cornerRadius = 6;
    sizeButton3.titleLabel.font = [UIFont boldSystemFontOfSize:12];
    [sizeButton3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:sizeButton3];

    
    newGame = [[UIButton alloc] initWithFrame:CGRectMake(110, 400, 100, 40)];
    [newGame setTitle:@"Play" forState:UIControlStateNormal];
    [newGame addTarget:self action:@selector(resetNewGame) forControlEvents: UIControlEventTouchUpInside];
    newGame.backgroundColor = [UIColor blackColor];
    newGame.layer.cornerRadius = 6;
    newGame.titleLabel.font = [UIFont boldSystemFontOfSize:12];
    [newGame setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [self.view addSubview:newGame];
    
    backButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 20, 80, 20)];
    [backButton setTitle:@"Back" forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(goHome) forControlEvents: UIControlEventTouchUpInside];
    backButton.backgroundColor = [UIColor blackColor];
    backButton.layer.cornerRadius = 6;
    backButton.titleLabel.font = [UIFont boldSystemFontOfSize:12];
    [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    
    
}

-(void)gameSizeChange1
{
    gameSize = 6;
    [sizeButton1 removeFromSuperview];
    [sizeButton2 removeFromSuperview];
    [sizeButton3 removeFromSuperview];
    [self.view addSubview:newGame];
}

-(void)gameSizeChange2
{
    gameSize = 8;
    [sizeButton1 removeFromSuperview];
    [sizeButton2 removeFromSuperview];
    [sizeButton3 removeFromSuperview];
    [self.view addSubview:newGame];
}

-(void)gameSizeChange3
{
    gameSize = 12;
    [sizeButton1 removeFromSuperview];
    [sizeButton2 removeFromSuperview];
    [sizeButton3 removeFromSuperview];
    [self.view addSubview:newGame];
}



-(void)goHome
{
    [gameBoard removeFromSuperview];
    [backButton removeFromSuperview];
    [self.view addSubview:newGame];
    [self.view addSubview:sizeButton1];
    [self.view addSubview:sizeButton2];
    [self.view addSubview:sizeButton3];
//    [self.view addSubview:newGame];
}


-(void)resetNewGame
{
    [self.view addSubview:backButton];

    gameBoard = [[UIView alloc] initWithFrame:self.view.frame];
    
    [self.view insertSubview:gameBoard belowSubview:backButton];
    
    float circleWidth = SCREEN_WIDTH / gameSize;
    float squareWidth = circleWidth / 2 ;
    
    // create squares
    for (int sRow = 0; sRow < gameSize - 1; sRow++)
    {
        for (int sCol = 0; sCol < gameSize - 1; sCol++)
        {
            float squareX = ((circleWidth - squareWidth) * 1.5) + (circleWidth * sCol) ;
            float squareY = ((circleWidth - squareWidth) * 1.5) + (circleWidth *sRow) + ((SCREEN_HEIGHT - SCREEN_WIDTH) / 2);
            
            SCGSquare * square = [[SCGSquare alloc] initWithFrame:CGRectMake(squareX, squareY, squareWidth, squareWidth)];
            square.backgroundColor = [UIColor lightGrayColor];
            square.layer.cornerRadius = 5;
            
            NSString * key = [NSString stringWithFormat:@"c%dr%d", sCol,sRow];
            
            allSquares[key] = square;
            
            [gameBoard addSubview:square];
            [newGame removeFromSuperview];
        }
    }
    
    // create circles
    for (int row = 0; row < gameSize; row++)
    {
        for (int col = 0; col < gameSize; col++)
        {
            
            float cirlceX = circleWidth * col;
            float circleY = (circleWidth * row) + ((SCREEN_HEIGHT - SCREEN_WIDTH) / 2);
            
            SCGCircle * circle = [[SCGCircle alloc] initWithFrame:CGRectMake(cirlceX, circleY, circleWidth, circleWidth)];
            
            circle.position = (CGPoint){col,row};
            
            circle.delegate = self;
            
            NSString * key = [NSString stringWithFormat:@"c%dr%d", col,row]; // 0,1 c0r1
            
            tappedDots[key] = @2;
            
            [gameBoard addSubview:circle];
            
            
        }
    }
    
}

- (UIColor *)circleTappedWithgPosition:(CGPoint)position
{
    
    // get tappedDots key from position
    NSString * key = [NSString stringWithFormat:@"c%dr%d",(int)position.x, (int)position.y];
    
    // set player num to value in tappedDots
    tappedDots[key] = @(playerTurn);
    
    // check for square
    [self checkForSquareAroundPosition:position];
    
    UIColor * currentColor = playerColors[playerTurn];
    
    playerTurn = (playerTurn) ? 0 : 1;
    
    return currentColor;
}

-(void)checkForSquareAroundPosition:(CGPoint)position
{
    int pX = position.x;
    int pY = position.y;
    
    BOOL above = (pY > 0);
    BOOL below = (pY < gameSize - 1);
    BOOL left = (pX > 0);
    BOOL right = (pX < gameSize - 1);
    
    
    //    @{@"r0c0": @0,
    //      @"r0c1": @1,
    //      @"r0c2": @2
    //      };
    
    
    // x = col and y = row
    
    if (above && left)
    {
        for (UIColor * color in playerColors)
        {
            int player = (int)[playerColors indexOfObject:color];
            
            // -1,-1 0,-1 -1,0 0,0
            
            NSString * topLeftDot = [NSString stringWithFormat:@"c%dr%d", pX-1,pY-1];
            NSString * topRightDot = [NSString stringWithFormat:@"c%dr%d", pX,pY-1];
            NSString * bottomLeftDot = [NSString stringWithFormat:@"c%dr%d", pX-1,pY];
            NSString * bottomRightDot = [NSString stringWithFormat:@"c%dr%d", pX,pY];
            
            // checks if top left and top right are the same
            BOOL topDotsSame = ([tappedDots[topLeftDot] isEqualToValue:tappedDots[topRightDot]]);
            // checks if bottom left and bottom right are the same
            BOOL bottomDotSame = ([tappedDots[bottomLeftDot] isEqualToValue:tappedDots[bottomRightDot]]);
            // checks if top left and bottom left are the same
            BOOL leftDotSame = ([tappedDots[topLeftDot] isEqualToValue:tappedDots[bottomLeftDot]]);
            
            //if top, left, & bottom dots the same as player...then they own square
            if (topDotsSame && bottomDotSame && leftDotSame && [tappedDots[topLeftDot] isEqualToValue:@(player)])
            {
                SCGSquare * currentSquare = allSquares[topLeftDot];
                currentSquare.backgroundColor = color;
                // player owns square
            }
        };
        
    }
    if (above && right)
    {
        for (UIColor * color in playerColors)
        {
            int player = [playerColors indexOfObject:color];
            
            NSString * topLeftDot = [NSString stringWithFormat:@"c%dr%d",pX,pY-1];
            NSString * topRightDot = [NSString stringWithFormat:@"c%dr%d",pX+1,pY-1];
            NSString * bottomLeftDot = [NSString stringWithFormat:@"c%dr%d",pX,pY];
            NSString * bottomRightDot = [NSString stringWithFormat:@"c%dr%d",pX+1,pY];
            
            // checks if top left and top right are the same
            BOOL topDotsSame = ([tappedDots[topLeftDot] isEqualToValue:tappedDots[topRightDot]]);
            // checks if bottom left and bottom right are the same
            BOOL bottomDotsSame = ([tappedDots[bottomLeftDot] isEqualToValue:tappedDots[bottomRightDot]]);
            // checks if top left and bottom left are the same
            BOOL leftDotsSame = ([tappedDots[topLeftDot] isEqualToValue:tappedDots[bottomLeftDot]]);
            
            //if top, left, & bottom dots the same as player... then they own square
            if(topDotsSame && bottomDotsSame && leftDotsSame && [tappedDots[topLeftDot] isEqual:@(player)])
            {
                SCGSquare * currentSquare = allSquares[topLeftDot];
                currentSquare.backgroundColor = color;
            }
            
        }
    }
    if (below && left)
    {
        for (UIColor * color in playerColors)
        {
            int player = [playerColors indexOfObject:color];
            
            NSString * topLeftDot = [NSString stringWithFormat:@"c%dr%d",pX-1,pY];
            NSString * topRightDot = [NSString stringWithFormat:@"c%dr%d",pX,pY];
            NSString * bottomLeftDot = [NSString stringWithFormat:@"c%dr%d",pX-1,pY+1];
            NSString * bottomRightDot = [NSString stringWithFormat:@"c%dr%d",pX,pY+1];
            
            // checks if top left and top right are the same
            BOOL topDotsSame = ([tappedDots[topLeftDot] isEqualToValue:tappedDots[topRightDot]]);
            // checks if bottom left and bottom right are the same
            BOOL bottomDotsSame = ([tappedDots[bottomLeftDot] isEqualToValue:tappedDots[bottomRightDot]]);
            // checks if top left and bottom left are the same
            BOOL leftDotsSame = ([tappedDots[topLeftDot] isEqualToValue:tappedDots[bottomLeftDot]]);
            
            //if top, left, & bottom dots the same as player... then they own square
            if(topDotsSame && bottomDotsSame && leftDotsSame && [tappedDots[topLeftDot] isEqual:@(player)])
            {
                SCGSquare * currentSquare = allSquares[topLeftDot];
                currentSquare.backgroundColor = color;
            }
            
        }
    }
    if (below && right)
    {
        for (UIColor * color in playerColors)
        {
            int player = [playerColors indexOfObject:color];
            
            NSString * topLeftDot = [NSString stringWithFormat:@"c%dr%d",pX,pY];
            NSString * topRightDot = [NSString stringWithFormat:@"c%dr%d",pX+1,pY];
            NSString * bottomLeftDot = [NSString stringWithFormat:@"c%dr%d",pX,pY+1];
            NSString * bottomRightDot = [NSString stringWithFormat:@"c%dr%d",pX+1,pY+1];
            
            // checks if top left and top right are the same
            BOOL topDotsSame = ([tappedDots[topLeftDot] isEqualToValue:tappedDots[topRightDot]]);
            // checks if bottom left and bottom right are the same
            BOOL bottomDotsSame = ([tappedDots[bottomLeftDot] isEqualToValue:tappedDots[bottomRightDot]]);
            // checks if top left and bottom left are the same
            BOOL leftDotsSame = ([tappedDots[topLeftDot] isEqualToValue:tappedDots[bottomLeftDot]]);
            
            //if top, left, & bottom dots the same as player... then they own square
            if(topDotsSame && bottomDotsSame && leftDotsSame && [tappedDots[topLeftDot] isEqual:@(player)])
            {
                SCGSquare * currentSquare = allSquares[topLeftDot];
                currentSquare.backgroundColor = color;
            }
            
        }
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
- (BOOL)prefersStatusBarHidden { return YES; }

@end

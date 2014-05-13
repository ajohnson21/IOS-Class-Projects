//
//  PNARootVC.m
//  PixelNoice
//
//  Created by Austen Johnson on 5/5/14.
//  Copyright (c) 2014 Austen Johnson. All rights reserved.
//

#import "PNARootVC.h"
#import "PNAPixelSounds.h"

@interface PNARootVC ()

@end

@implementation PNARootVC
{
    PNAPixelSounds * sounds;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        sounds = [[PNAPixelSounds alloc] init];
        
    }
    return self;
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

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"Play Sound");
    [sounds playSoundWithName:@"click_alert"];
}

@end

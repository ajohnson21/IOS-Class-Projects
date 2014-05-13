//
//  PNAPixelSounds.m
//  PixelNoice
//
//  Created by Austen Johnson on 5/5/14.
//  Copyright (c) 2014 Austen Johnson. All rights reserved.
//

#import "PNAPixelSounds.h"

@implementation PNAPixelSounds
{

}

-(void)playSoundWithName:(NSString *)soundName
{
    NSString * file = [[NSBundle mainBundle] pathForResource:soundName ofType:@"wav"];
    
    NSData * fileData = [NSData dataWithContentsOfFile:file];
    
    self.player = [[AVAudioPlayer alloc] initWithData:fileData error:nil];
    
    self.player.numberOfLoops = 0;
    
    [self.player play];
    
}




@end







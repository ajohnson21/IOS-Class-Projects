//
//  PNAPixelSounds.h
//  PixelNoice
//
//  Created by Austen Johnson on 5/5/14.
//  Copyright (c) 2014 Austen Johnson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface PNAPixelSounds : NSObject

@property (nonatomic)AVAudioPlayer * player;

-(void)playSoundWithName:(NSString *)soundName;


@end


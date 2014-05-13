//
//  PNAViewController.h
//  PixelNoice
//
//  Created by Austen Johnson on 5/5/14.
//  Copyright (c) 2014 Austen Johnson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface PNAViewController : UIViewController

@property (nonatomic)AVAudioPlayer * player;

-(void)playSoundWithName:(NSString *)soundName;

@end

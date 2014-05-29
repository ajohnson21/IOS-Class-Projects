//
//  JTAAppDelegate.m
//  STATUS
//
//  Created by Austen Johnson on 5/19/14.
//  Copyright (c) 2014 Austen Johnson. All rights reserved.
//

#import "JTAAppDelegate.h"
#import "JTARVC.h"
#import "STTwitter.h"

@implementation JTAAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    JTARVC * vc = [[JTARVC alloc] init];
    UINavigationController * nc = [[UINavigationController alloc] initWithRootViewController:vc];
    
    [nc setNavigationBarHidden:YES];
    self.window.rootViewController = nc;
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

@end

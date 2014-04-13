//
//  SCGAppDelegate.m
//  squares
//
//  Created by Austen Johnson on 4/11/14.
//  Copyright (c) 2014 Austen Johnson. All rights reserved.
//

#import "SCGAppDelegate.h"
#import "SCGStageVC.h"

@implementation SCGAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    // keeps us from having to rewrite nib by setting nib to nil
    self.window.rootViewController = [[SCGStageVC alloc] initWithNibName:nil bundle:nil];
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    
}

- (void)applicationWillTerminate:(UIApplication *)application
{
   
}

@end

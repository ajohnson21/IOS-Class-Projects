//
//  TDLAppDelegate.m
//  todo
//
//  Created by Austen Johnson on 4/2/14.
//  Copyright (c) 2014 Austen Johnson. All rights reserved.
//

#import "TDLAppDelegate.h"
#import "TDLRootTableViewController.h"

@implementation TDLAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    TDLRootTableViewController * rootViewController = [[TDLRootTableViewController alloc] initWithStyle:UITableViewStylePlain];
    
    UINavigationController * navController = [[UINavigationController alloc] initWithRootViewController: rootViewController];

    self.window.rootViewController = [[TDLRootTableViewController alloc] initWithStyle:UITableViewStylePlain];
    
    self.window.rootViewController = navController;
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

@end

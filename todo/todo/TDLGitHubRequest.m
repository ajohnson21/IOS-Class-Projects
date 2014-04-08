//
//  TDLGitHubRequest.m
//  todo
//
//  Created by Austen Johnson on 4/8/14.
//  Copyright (c) 2014 Austen Johnson. All rights reserved.
//

#import "TDLGitHubRequest.h"

@implementation TDLGitHubRequest

+ (NSDictionary *)getUserWithUsername:(NSString *)username
{
    NSMutableDictionary *userInfo = [@{} mutableCopy];
    
    NSString *githubUrl = [NSString stringWithFormat:@"https://api.github.com/users/%@", username];
    NSURL *url = [NSURL URLWithString:githubUrl];
    NSLog(@"Trying to connect to %@", githubUrl);
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSError *requestError = nil;
    NSURLResponse *response = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&requestError];
    
    
    NSError *jsonError = nil;
    NSDictionary *gitHubProfileDetails = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&jsonError];
    //NSLog(@"JSON: %@", gitHubProfileDetails);
    
    if (gitHubProfileDetails[@"name"] != nil)
    {
        userInfo[@"name"] = gitHubProfileDetails[@"name"];
    }
    else
    {
        NSLog(@"%@: %@", username, gitHubProfileDetails[@"message"]);
        NSString *message = gitHubProfileDetails[@"message"];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"%@", message]
                              
                                                        message:[NSString stringWithFormat:@"GitHub user: %@", username]
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        
        [alert show];
    }
    
    if (gitHubProfileDetails[@"html_url"] != nil) userInfo[@"github"] = gitHubProfileDetails[@"html_url"];
    
    // Image related
    if (gitHubProfileDetails[@"avatar_url"] != nil)
    {
        NSURL* imageURL = [NSURL URLWithString:gitHubProfileDetails[@"avatar_url"]];
        NSData* imageData = [NSData dataWithContentsOfURL:imageURL];
        userInfo[@"image"] = [UIImage imageWithData:imageData];
    }
    
    return userInfo;
}

@end

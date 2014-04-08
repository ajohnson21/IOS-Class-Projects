//
//  TDLGitHubRequest.h
//  todo
//
//  Created by Austen Johnson on 4/8/14.
//  Copyright (c) 2014 Austen Johnson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TDLGitHubRequest : NSObject

+ (NSDictionary *)getUserWithUsername:(NSString *)username;

@end

//
//  TDLSingleton.h
//  todo
//
//  Created by Austen Johnson on 5/6/14.
//  Copyright (c) 2014 Austen Johnson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TDLSingleton : NSObject

+ (TDLSingleton *)sharedCollection;

-(void)addListItem:(NSDictionary *)listItems;
-(void)removeListItem:(NSDictionary *)listItem;
-(void)removeListItemAtIndex:(NSInteger)index;
- (NSArray *)allListItems;


@end

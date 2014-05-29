//
//  JTAArhitecture.m
//  STATUS
//
//  Created by Austen Johnson on 5/29/14.
//  Copyright (c) 2014 Austen Johnson. All rights reserved.
//

#import "JTAArhitecture.h"

@implementation JTAArhitecture
{
    NSArray * colors;
    NSDictionary * colorDictionary;
    
    NSDictionary *faces;
}

- (void)addFace:(NSDictionary *)face withColor:(int)colorIndex
{
    [colors[colorIndex][@"faces"] addObject:face];
}

- (void)setupArchitecture
{
    colorDictionary = @{
                        @"yellow" : @"image1",
                        @"red" : @"image2"
                        };
    
    faces = @{
              @"yellow" : @[@"face1",@"face1"],
              @"red" : @[@"face1",@"face1"]
              };
    
    
    colorDictionary = @{
                        @"yellow" : @{
                                @"image" : @"colors_1",
                                @"faces" : @[
                       @{
                           @"emotion" : @"happy",
                           @"image" : @"yellow_1"
                           },
                       @{
                           @"emotion" : @"smirk",
                           @"image" : @"yellow_2"
                           },
                       ]
                    }
                };
    
    

//    NSArray * colors = [[NSArray alloc] init];
    colors = @[
                         @{
                             @"color" : @"yellow",
                             @"image" : @"colors_1",
                             @"faces" : @[
                                        @{
                                     @"emotion" : @"happy",
                                     @"image" : @"yellow_1"
                                     },
                                        @{
                                            @"emotion" : @"smirk",
                                            @"image" : @"yellow_2"
                                            },
                                        ]
                             },
                         @{
                             @"color" : @"red",
                             @"image" : @"colors_2"
                             },
                         @{
                             @"color" : @"blue",
                             @"image" : @"colors_3"
                             },
                         @{
                             @"color" : @"orange",
                             @"image" : @"colors_4"
                             },
                         @{},
                         @{},
                         @{},
                         @{},
                         @{}
                         ];

}

- (void)createColors
{
    NSString * yellowKey = [colorDictionary allKeys] [0];
    NSDictionary * yellowColor = colorDictionary[yellowKey];
    
    for (NSString *key in [colorDictionary allKeys])
    {
        NSDictionary * color = colorDictionary[key];
        
        
        NSLog(@"%@", colors);
    }
    
    for (NSDictionary * color in colors)
    {
        NSString * colorName = color[@"color"];
        NSString * imageName = color[@"image"];
        
        UIImage * image = [UIImage imageNamed:color[@"image"]];
        
        NSArray * faces = color[@"faces"];

        for (NSDictionary *face in faces)
        {
            NSString * faceImage = face[@"image"];
        }
        
    }

    NSDictionary * face = colors[0][@"faces"][1];
}

- (void)createFacesWithColor:(NSString *)color
{
    NSArray *faces = colorDictionary[color][@"faces"];
    
    for (NSDictionary *face in faces)
    {
        NSLog(@"%@", face);
    }
}

- (void)createFacesWithColorDictionary:(NSDictionary *)color
{
    NSArray * faces = color[@"faces"];
    
    for (NSDictionary *face in faces) {
        NSLog(@"%@", face);
    }
}

@end

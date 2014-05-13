//
//  PLAFilterViewController.h
//  PhotoLibraryApp
//
//  Created by Austen Johnson on 5/1/14.
//  Copyright (c) 2014 Austen Johnson. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PLAFilterViewControllerDelegate;

@interface PLAFilterViewController : UIViewController

@property (nonatomic, assign) id<PLAFilterViewControllerDelegate> delegate;

@property (nonatomic) UIImage * imageToFilter;

@end

@protocol PLAFilterViewControllerDelegate <NSObject>

- (void)updateCurrentImageWithFilteredImage:(UIImage *)image;

@end

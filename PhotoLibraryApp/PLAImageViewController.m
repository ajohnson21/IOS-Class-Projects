//
//  PLAImageViewController.m
//  PhotoLibraryApp
//
//  Created by Austen Johnson on 4/30/14.
//  Copyright (c) 2014 Austen Johnson. All rights reserved.
//

#import "PLAImageViewController.h"
#import "PLAFilterViewController.h"

@interface PLAImageViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate, PLAFilterViewControllerDelegate>
@property (nonatomic) UIImage * originalImage;

@end

@implementation PLAImageViewController
{
    UIImageView * imageView;
    PLAFilterViewController * filterVC;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    imageView = [[UIImageView alloc] initWithFrame:self.view.frame];
    
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:imageView];
    
    UIView * navBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 560, 50)];
    navBar.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.8];
    [self.view addSubview:navBar];
    
    
    UIButton * headerButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 30, 30)];
    [headerButton addTarget:self action:@selector(pickPhoto) forControlEvents: UIControlEventTouchUpInside];
    headerButton.backgroundColor = [UIColor whiteColor];
    headerButton.layer.cornerRadius = 15;
    [navBar addSubview:headerButton];
    
    filterVC = [[PLAFilterViewController alloc] initWithNibName:nil bundle:nil];
    filterVC.delegate = self;
    filterVC.view.frame = CGRectMake(0, SCREEN_HEIGHT - 100, SCREEN_WIDTH, 100);
    [self.view addSubview:filterVC.view];
    
}

-(void) pickPhoto
{
    UIImagePickerController * photoLibrary = [[UIImagePickerController alloc] init];
        photoLibrary.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    photoLibrary.delegate = self;
    [self presentViewController:photoLibrary animated:YES completion:nil];
    

}

-(IBAction)getPhoto:(id) sender
{
    
    NSLog(@"testing");
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    self.originalImage = info[UIImagePickerControllerOriginalImage];
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
    
}

-(void)setOriginalImage:(UIImage *)originalImage
{
    _originalImage = originalImage;
    
    filterVC.imageToFilter = originalImage;
    imageView.image = originalImage;
}

-(void)updateCurrentImageWithFilteredImage:(UIImage *)image
{
    imageView.image = image;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end

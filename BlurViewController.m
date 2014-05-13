//
//  BlurViewController.m
//  
//
//  Created by Austen Johnson on 5/2/14.
//
//

#import "BlurViewController.h"

@interface BlurViewController ()
@property (nonatomic) NSString * currentFilter;

@end

@implementation BlurViewController
{
    UISwitch * toggleSwitch;
    UISlider * slider;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    toggleSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(280, 25, 20, 50)];
    [toggleSwitch addTarget:self action:@selector(toggleChange) forControlEvents: UIControlEventTouchUpInside];
    toggleSwitch.tintColor = [UIColor redColor];
    toggleSwitch.onTintColor = [UIColor redColor];
    [self.view addSubview:toggleSwitch];
    
    slider = [[UISlider alloc] initWithFrame:CGRectMake(20, 25, 250, 50)];
    slider.layer.cornerRadius = 5;
    slider.minimumValue = 0;
    slider.maximumValue = 20;
    slider.value = 10;
    [slider addTarget:self action:@selector(toggleChange) forControlEvents:UIControlEventAllEvents];
    [self.view addSubview:slider];

}

-(void)toggleChange
{
    if ([toggleSwitch isOn] == YES)
    {
       self.currentFilter = @"CIBoxBlur";
    }
    else
    {
         self.currentFilter = @"CIGaussianBlur";
    }
    
    UIImage * image = [self filterImage:self.imageToFilter filterName:self.currentFilter];
    
    [self.delegate updateCurrentImageWithFilteredImage:image];
}

-(UIImage *)filterImage:(UIImage *)image filterName:(NSString *)filterName
{
    float slideValue = slider.value;
    
    CIImage * CiImage = [CIImage imageWithCGImage:image.CGImage];
    CIFilter * filter = [CIFilter filterWithName:filterName];
    [filter setValue:CiImage forKeyPath:kCIInputRadiusKey];
    [filter setValue: @(slideValue) forKey:kCIInputRadiusKey];
    CIContext * ciContext = [CIContext contextWithOptions:nil];
    CIImage * ciResult = [filter valueForKeyPath:kCIOutputImageKey];
        
    return [UIImage imageWithCGImage:[ciContext createCGImage:ciResult fromRect:[ciResult extent]]];
    
}

-(void)setImageToFilter:(UIImage *)imageToFilter
{
    _imageToFilter = imageToFilter;
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

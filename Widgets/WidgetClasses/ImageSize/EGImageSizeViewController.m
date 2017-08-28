//
//  EGImageSizeViewController.m
//  Widgets
//
//  Created by EG on 2017/8/26.
//  Copyright © 2017年 EGMade. All rights reserved.
//

#import "EGImageSizeViewController.h"

#import "UIImage+Resize.h"

@interface EGImageSizeViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UILabel *sizeLabel;

@end

@implementation EGImageSizeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)segmentReaction:(UISegmentedControl *)sender {
    NSString *imageName;
    switch (sender.selectedSegmentIndex) {
        case 0:
           imageName = @"scenery1";
            break;
        case 1:
            imageName = @"scenery2";
            break;
        case 2:
            imageName = @"scenery3";
            break;
            
        default:
            break;
    }

    CGFloat width = CGImageGetWidth(self.imageView.image.CGImage);
    CGFloat height = CGImageGetHeight(self.imageView.image.CGImage);
    
    self.sizeLabel.text = [NSString stringWithFormat:@"%.5f-%.5f", width, height];
    
    UIImage *resizeImage = [UIImage imageWithContentsOfFile:
                            [[NSBundle mainBundle]pathForResource:imageName ofType:@"jpg"]];
    self.imageView.image = [UIImage imageCompressForWidthScale:resizeImage targetWidth:SCREEN_WIDTH];
}


@end

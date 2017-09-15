//
//  EGLayerUsageController.m
//  Widgets
//
//  Created by EG on 2017/9/2.
//  Copyright © 2017年 EGMade. All rights reserved.
//

#import "EGLayerUsageController.h" 

@implementation EGLayerUsageController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.datasArray = @[
                        @"EGLayerBasicViewController",
                        @"EGLayerContentRectViewController",
                        @"EGCustomeDrawViewController",
                        @"EGGraphicsGeometryViewController",
                        @"EGLayerMaskViewController",
                        @"EGStretchFilterViewController",
                        @"EGTransparentViewController",
                        @"EGViewTransformController",
                        @"EGCAShapeLayerViewController",
                        @"EGCATextLayerController",
                        @"EGGradientLayerViewController",
                        @"EGReplicatorLayerViewController",
                        @"EGScrollLayerViewController",
                        @"EGEmitterLayerViewController",
                        @"EGEAGLLayerViewController"
                        ];
}

@end

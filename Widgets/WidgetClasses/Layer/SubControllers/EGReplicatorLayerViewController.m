//
//  EGReplicatorLayerViewController.m
//  Widgets
//
//  Created by EG on 2017/9/4.
//  Copyright © 2017年 EGMade. All rights reserved.
//

#import "EGReplicatorLayerViewController.h"

/**
 CAReplicatorLayer的目的是为了高效生成许多相似的图层。
 它会绘制一个或多个图层的子图层，并在每个复制体上应用不同的变换。
 */
@interface EGReplicatorLayerViewController ()

@end

@implementation EGReplicatorLayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CAReplicatorLayer *replicator = [CAReplicatorLayer layer];
    replicator.frame = self.view.bounds;
    [self.view.layer addSublayer:replicator];
    
        //configure the replicator
    replicator.instanceCount = 10;
    
        //apply a transform for each instance
    CATransform3D transform = CATransform3DIdentity;
    transform = CATransform3DTranslate(transform, 0, 20, 0);
    transform = CATransform3DTranslate(transform, 20, 0, 0);
//    transform = CATransform3DRotate(transform, M_PI / 2, 0, 0, 1);
    replicator.instanceTransform = transform;
    
        //apply a color shift for each instance
    replicator.instanceBlueOffset = -0.1;
    replicator.instanceGreenOffset = -0.1;
//    replicator.instanceAlphaOffset = - 0.1;

        //create a sublayer and place it inside the replicator
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(0, 0, 100.0f, 100.0f);
    layer.backgroundColor = [UIColor whiteColor].CGColor;
    [replicator addSublayer:layer];
}

@end

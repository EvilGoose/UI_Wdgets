//
//  EGWaveViewController.m
//  Widgets
//
//  Created by EG on 2017/8/28.
//  Copyright © 2017年 EGMade. All rights reserved.
//

#import "EGWaveViewController.h"
#import "EGWaveView.h"

@interface EGWaveViewController ()

/**wave*/
@property (strong, nonatomic)EGWaveView *waveView;

@end

@implementation EGWaveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Action" style:UIBarButtonItemStylePlain target:self action:@selector(drawAction)];
    [self.view addSubview:self.waveView];
}

- (void)drawAction {
    UIAlertController *actions = [UIAlertController alertControllerWithTitle:@"Action"
                                                                     message:@"choose one"
                                                              preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"Sin"
                                                      style:UIAlertActionStyleDefault
                                                    handler:^(UIAlertAction * _Nonnull action) {
                                                        self.waveView.type = DrawActionTypeSin;
                                                    }];
    
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"Cos"
                                                      style:UIAlertActionStyleDefault
                                                    handler:^(UIAlertAction * _Nonnull action) {
                                                        self.waveView.type = DrawActionTypeCos;
                                                    }];
    
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"Mut"
                                                      style:UIAlertActionStyleDefault
                                                    handler:^(UIAlertAction * _Nonnull action) {
                                                        self.waveView.type = DrawActionTypeMutPath;
                                                    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel"
                                                     style:UIAlertActionStyleCancel
                                                   handler:^(UIAlertAction * _Nonnull action) {
                                                   }];
    
    [actions addAction:action1];
    [actions addAction:action2];
    [actions addAction:action3];
    [actions addAction:cancel];
    
    [self presentViewController:actions animated:YES completion:nil];
}

- (EGWaveView *)waveView {
    if (!_waveView) {
        _waveView = [[EGWaveView alloc] initWithFrame:self.view.bounds];
    }
    return _waveView;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

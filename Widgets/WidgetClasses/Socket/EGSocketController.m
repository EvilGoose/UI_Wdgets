//
//  EGSocketController.m
//  Widgets
//
//  Created by EG on 2017/8/31.
//  Copyright © 2017年 EGMade. All rights reserved.
//

#import "EGSocketController.h"
#import <GCDAsyncSocket.h>

@interface EGSocketController ()
<
GCDAsyncSocketDelegate
>
{
	GCDAsyncSocket *_socket;
}

@property (weak, nonatomic) IBOutlet UITextField *ipInputField;

@property (weak, nonatomic) IBOutlet UITextField *portField;

@property (weak, nonatomic) IBOutlet UITextView *resultPresentView;

@property (weak, nonatomic) IBOutlet UITextField *messageInputField;

@end

@implementation EGSocketController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
        //创建一个socket对象
    _socket =
    [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)];
    
//    [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (IBAction)connectToServer:(id)sender {
        //连接
    NSError *error = nil;
    
        // 1.与服务器通过三次握手建立连接
    NSString *host = self.ipInputField.text;
    int port = [self.portField.text intValue];
    [_socket connectToHost:host onPort:port error:&error];
    
    if (error) {
        NSLog(@"%@",error);
    }
}

- (IBAction)sendMessage:(UIButton *)sender {
    if (self.messageInputField.text > 0) {
        NSData *data = [self.messageInputField.text dataUsingEncoding:NSUTF8StringEncoding];
            //withTimeout -1 :无穷大
            //tag： 消息标记
        [_socket writeData:data withTimeout:5 tag:0];
    }
}

- (IBAction)receiveMessageAction:(UIButton *)sender {
    [_socket readDataWithTimeout:5 tag:0];
}

#pragma mark - delegate
    //连接成功
-(void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.resultPresentView.text = @"连接成功\n";
    });
}

    //断开连接
-(void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (err) {
            self.resultPresentView.text = [self.resultPresentView.text stringByAppendingFormat:@"%@\n", @"连接失败\n"];
         }else{
             self.resultPresentView.text = [self.resultPresentView.text stringByAppendingFormat:@"%@\n", @"正常断开\n"];
         }
    });
}

    //数据发送成功
-(void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag{
//    dispatch_async(dispatch_get_main_queue(), ^{
//        self.resultLabel.text = [self.resultLabel.text stringByAppendingFormat:@"%@\n", @"+++++++"];
//    });
        //发送完数据手动读取，-1不设置超时
    [sock readDataWithTimeout:5 tag:tag];
}

    //读取数据
-(void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag{
    NSString *receiverStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    dispatch_async(dispatch_get_main_queue(), ^{
        self.resultPresentView.text = [self.resultPresentView.text stringByAppendingFormat:@"%@\n", receiverStr];
    });
}

@end

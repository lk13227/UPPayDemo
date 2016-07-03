//
//  ViewController.m
//  UPPay
//
//  Created by Kai Liu on 16/7/3.
//  Copyright © 2016年 Kai Liu. All rights reserved.
//

#import "ViewController.h"

#import "AFNetworking.h"

#import "UPPaymentControl.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];//设置相应内容类型
    
    // 声明获取到的数据格式
    manager.responseSerializer = [AFHTTPResponseSerializer serializer]; // AFN不会解析,数据是data，需要自己解析
    
    [manager GET:@"http://101.231.204.84:8091/sim/getacptn" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //成功
        if(responseObject){
            NSString *thStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            
            NSLog(@"th === %@",thStr);
            
            
            [[UPPaymentControl defaultControl] startPay:thStr fromScheme:@"UPPayDemo" mode:@"01" viewController:self];
            
            
        } else {
            NSLog(@"没有数据");
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //失败
        
        NSLog(@"error========%@",error);
        
    }];
    
}


@end

//
//  ViewController.m
//  ScanCode
//
//  Created by liguangjian on 16/9/10.
//  Copyright © 2016年 liguangjian. All rights reserved.
//

#import "ViewController.h"

#import "ScanCodeViewController.h"

@interface ViewController ()<ScanCodeDelegate>{
    BOOL _findAResult;
    UIAlertView *_alert;
    AVCaptureDevice *captureDevice;
}
@property (weak, nonatomic) IBOutlet UILabel *resultText;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}


- (IBAction)clickScan:(id)sender {
    
    ScanCodeViewController *scanVC = [[ScanCodeViewController alloc]init];
    scanVC.delegate = self;
    [self presentViewController:scanVC animated:YES completion:^{
        
    }];
    
}

-(void)resultsStrint:(UIViewController *)vc :(NSString *)resultsStr{
    [vc dismissViewControllerAnimated:YES completion:^{
        
    }];
    _resultText.text = [NSString stringWithFormat:@"扫描结果：%@",resultsStr];
    NSLog(@"resultsStr:::%@",resultsStr);
}

-(void)goScanBack:(UIViewController *)vc{
    [vc dismissViewControllerAnimated:YES completion:^{
        
    }];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

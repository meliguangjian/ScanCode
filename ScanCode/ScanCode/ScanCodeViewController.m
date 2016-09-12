//
//  ScanCodeViewController.m
//  ScanCode
//
//  Created by liguangjian on 16/9/10.
//  Copyright © 2016年 liguangjian. All rights reserved.
//

#import "ScanCodeViewController.h"

#import "ScanCode.h"

@interface ScanCodeViewController ()<AVCaptureMetadataOutputObjectsDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>{
    ScanCode *scan;
    BOOL _findAResult;
    UISlider *slider;
    BOOL isTap;
    NSTimer *timer;
}

@end

@implementation ScanCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    scan = [[ScanCode alloc]init];
    scan.bouth1D2D = YES;
//    [scan identifyCode:[UIImage imageNamed:@"aaaaa"] results:^(NSString *resultsStr) {
//        NSLog(@"resultsStr:%@",resultsStr);
//    }];
    
    [scan setCamara:self.view ObjectsDelegate:self];
    
    [self initSetPanel];
    
    //点击空白处缩键盘
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showSlider:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = YES;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];

}

-(void)showSlider:(UITapGestureRecognizer*)tap{
    
    if (!isTap) {
        [slider setHidden:NO];
        
        timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(hiddenSlider) userInfo:nil repeats:NO];
        
        isTap = YES;
    }
    
}

-(void)hiddenSlider{
    isTap = NO;
    [slider setHidden:YES];
}

-(void)initSetPanel{
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 20, 30, 30)];
    
    [backBtn setImage:[UIImage imageNamed:@"ScanBack"] forState:UIControlStateNormal];
    
    [backBtn addTarget:self action:@selector(goScanBack) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:backBtn];
    
    UIButton *identifyBtn = [[UIButton alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 30 - 10, 20, 30, 30)];
    
    [identifyBtn setImage:[UIImage imageNamed:@"ipc_image_placeholder"] forState:UIControlStateNormal];
    
    [identifyBtn addTarget:self action:@selector(openPhoto) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:identifyBtn];
    
    UISwitch *switchBtn = [[UISwitch alloc]initWithFrame:CGRectMake(identifyBtn.frame.origin.x - 60, identifyBtn.frame.origin.y, 30, 20)];
    
//    UISwitch *switchLed = [[UISwitch alloc]initWithFrame:CGRectMake(15, 60, 20, 10)];
    [switchBtn addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:switchBtn];
    
    
    NSLog(@"heightyyyyyyy:%f", [UIScreen mainScreen].bounds.size.height/2 - 115);
    
    slider = [[UISlider alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 140, [UIScreen mainScreen].bounds.size.height/2 - 20, 230 , 30)];
    //    slider.tag = tag;
    //    slider.value = initvalue;
    slider.transform = CGAffineTransformMakeRotation(-1.57079633);
    slider.minimumValue = 0.0;
    slider.maximumValue = 1.0;
    [self.view addSubview:slider];
    
    [slider setHidden:YES];
    
    [slider addTarget:self action:@selector(TouchDown:) forControlEvents:UIControlEventTouchDown];
    
    [slider addTarget:self action:@selector(updateSliderValue:) forControlEvents:UIControlEventValueChanged];
    
    [slider addTarget:self action:@selector(TouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    
//    UISwitch *switchLed = [[UISwitch alloc]initWithFrame:CGRectMake(15, 60, 20, 10)];
//    [switchLed addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
//    [self.view addSubview:switchLed];
    
}




#pragma mark 更新slider的值
- (void)updateSliderValue:(UISlider *)slider
{
    //    [self setFocalLength:slider.value];
    [scan setFocalLength:slider.value];
    
}

-(void)TouchUpInside:(UISlider *)slider{
    NSLog(@"TouchUpInside");
    [timer setFireDate:[NSDate distantPast]];
}

- (void)TouchDown:(UISlider *)slider{
    NSLog(@"TouchDown");
    [timer setFireDate:[NSDate distantFuture]];
}

-(void)goScanBack{
    
    [scan stopScan];
    
    if ([self.delegate respondsToSelector:@selector(goScanBack:)]) {
        [self.delegate goScanBack:self];
    }

}

-(void)openPhoto{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    //设置选择后的图片可被编辑
    picker.allowsEditing = NO;
    [self presentViewController:picker animated:YES completion:^{
        
    }];
}


#pragma mark 当选择一张图片后进入这个方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSLog(@"info==========%@", info);
    // 关闭相册界面
    
    [picker dismissViewControllerAnimated:YES completion:^{
    }];
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    // 当选择的类型是图片 (public.image)
    if ([mediaType isEqualToString:@"public.image"]) {
        UIImage *images = [info objectForKey:UIImagePickerControllerOriginalImage];
        //        UIImage *img = [UIImage imageWithContentsOfFile:imageUrl];
        [scan identifyCode:images results:^(NSString *resultsStr) {
            NSLog(@"resultsStr:%@",resultsStr);
            
            if ([resultsStr isEqualToString:@""]) {
                UIAlertView  *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"当前图片没有二维码" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
                [alert show];
                
            }else{
                if ([self.delegate respondsToSelector:@selector(resultsStrint::)]) {
                    [self.delegate resultsStrint:self :resultsStr];
                }
            }
            
        }];
        
    }
}

#pragma mark 开关灯
-(void)switchAction:(UISwitch*)sender  {
    [scan openLed:sender.on];
}



#pragma mark - AVCaptureMetadataOutputObjectsDelegate

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{

    if (_findAResult) {
        return;
    }
    if (!metadataObjects || !metadataObjects.count) {
        NSLog(@"No QR code is detected");
        return;
    }
    
    AVMetadataMachineReadableCodeObject *metaDataObj = metadataObjects[0];
    
    NSString *resultStr = metaDataObj.stringValue;
    
    NSLog(@"resultStr:%@",resultStr);
    
    if ([self.delegate respondsToSelector:@selector(resultsStrint::)]) {
        [self.delegate resultsStrint:self :resultStr];
    }
    
    [scan stopScan];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
    
    NSLog(@"dealloc");
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

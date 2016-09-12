//
//  ViewController.h
//  ScanCode
//
//  Created by liguangjian on 16/9/10.
//  Copyright © 2016年 liguangjian. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <AVFoundation/AVFoundation.h>

@interface ViewController : UIViewController

@property (strong,nonatomic)AVCaptureSession *captureSession;

@property (strong,nonatomic)AVCaptureMetadataOutput * output;

@property (strong,nonatomic)AVCaptureConnection *connection;

@property (strong,nonatomic)AVCaptureVideoPreviewLayer *videoPreviewLayer;

@property (strong,nonatomic)UIImageView *scanLine;

@property (strong ,nonatomic)NSTimer *timer;

@property (assign ,nonatomic)CGFloat lineMoveStep;

@end


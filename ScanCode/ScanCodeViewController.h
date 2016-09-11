//
//  ScanCodeViewController.h
//  ScanCode
//
//  Created by liguangjian on 16/9/10.
//  Copyright © 2016年 liguangjian. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ScanCodeDelegate <NSObject>

@optional

- (void)resultsStrint:(UIViewController *)vc :(NSString*)resultsStr;

-(void)goScanBack:(UIViewController *)vc;

@end

@interface ScanCodeViewController : UIViewController

@property (nonatomic,weak) id <ScanCodeDelegate> delegate;

@end

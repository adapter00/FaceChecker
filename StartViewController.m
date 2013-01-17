//
//  ViewController.m
//  Sample2
//
//  Created by 前田 恭男 on 12/11/21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "StartViewController.h"
#import "ViewBuilder.h"
#import "PhotoColorLogic.h"
#import "HealthStatusFacade.h"
#import "SVProgressHUD.h"
#import "HealthResultViewController.h"
#import "GraghViewController.h"
#import "CommonString.h"

@interface StartViewController (){
    UIImageView *imageView;
}

@end



@implementation StartViewController
@synthesize titleBar;


@synthesize imagePicker;



#pragma mark LifeCycle
- (void)viewDidLoad{
    [super viewDidLoad];
    [self initialize];
}

-(void)viewDidAppear:(BOOL)animated{
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]||
        [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        
    }
}

-(void)initialize{
    imagePicker=[[UIImagePickerController alloc] init];
    imagePicker.delegate=self;
    titleBar.delegate=self;
    UIBarButtonItem *graghButton=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(transitionGraghView:)];
    UINavigationItem *item=[titleBar.items objectAtIndex:0];
    item.rightBarButtonItem=graghButton;
    
    
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}


-(void)viewDidUnload{
    [super viewDidUnload];
    [self setTitleBar:nil];
    imageView=nil;
}



- (IBAction)cameraButton:(id)sender {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        imagePicker.sourceType=UIImagePickerControllerSourceTypeCamera;
        imagePicker.modalTransitionStyle=UIModalTransitionStyleFlipHorizontal;
        [self presentModalViewController:imagePicker animated:YES];
    }else{
        UIAlertView *deviceAlert=[ViewBuilder createAlert:ERROR_ALERT_DEVICE_TITLE Message:ERROR_ALERT_DEVICE_CAMERA buttonTitle:COMMON_BACK delegate:self];
        [deviceAlert show];
        
    }
}

- (IBAction)photoLibraryButton:(id)sender {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]){
        imagePicker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
        imagePicker.modalTransitionStyle=UIModalTransitionStyleFlipHorizontal;
        [self presentModalViewController:imagePicker animated:YES];
    }else {
        UIAlertView *deviceAlert=[ViewBuilder createAlert:ERROR_ALERT_DEVICE_TITLE Message:ERROR_ALERT_DEVICE_LIBRARY buttonTitle:COMMON_BACK delegate:self];
        [deviceAlert show];
        
    }
}


-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    //端末がカメラもしくはフォトライブラリーを使用できること
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]||
        [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        
        UIImage *originalImage=(UIImage *)[info objectForKey:UIImagePickerControllerOriginalImage];
        UIImage *resizeImage=[ViewBuilder resizeImage:originalImage];
        imageView=[ViewBuilder createImageView:resizeImage];
        [self.view addSubview:imageView];


        HealthStatusFacade *hManager=[[HealthStatusFacade alloc] init];
        
        //健康状態の所得
        if ([hManager isFace:resizeImage]){
            
            NSNumber *healthStatusNumber=[hManager checkTodayHealth:resizeImage];
            
            //インジケータの表示(4秒間表示させる)
            [SVProgressHUD showWithStatus:DIAGNOSING];
            [self performSelector:@selector(dismissIndicator:) withObject:healthStatusNumber afterDelay:4.0f];
        }else {
            UIAlertView *alert=[ViewBuilder createAlert:ERROR_ALERT_NOFACE_TITLE Message:ERROR_ALERT_NOFACE_MESSAGE buttonTitle:ERROR_ALERT_NOFACE_BUTTON_TITLE delegate:self];
            [alert show];
        }
        [self deleteImageView];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

-(void)deleteImageView{
    [imageView removeFromSuperview];
    imageView=nil;
}


-(id)dismissIndicator:(id)selector{
    [SVProgressHUD dismiss];
    HealthResultViewController *resultView=[[HealthResultViewController alloc]initWithNibName:@"HealthResultViewController" bundle:nil];
    resultView.modalTransitionStyle=UIModalTransitionStyleFlipHorizontal;
    if (selector!=nil) {
        resultView.healthStatus=selector;
    }
    [self deleteImageView];
    [self presentModalViewController:resultView animated:YES];
    return nil;
}

-(void)transitionGraghView:(UIBarButtonItem *)selector{
    GraghViewController *graghView_=[[GraghViewController alloc] initWithNibName:@"GraghViewController" bundle:nil];
    graghView_.modalTransitionStyle=UIModalTransitionStyleFlipHorizontal;
    [self presentModalViewController:graghView_ animated:YES];
}


@end


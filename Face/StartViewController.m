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
//    UIBarButtonItem *graghButton=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(transitionGraghView:)];
//    UINavigationItem *item=[titleBar.items objectAtIndex:0];
//    item.rightBarButtonItem=graghButton;
    
    
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)cameraButton:(id)sender {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        imagePicker.sourceType=UIImagePickerControllerSourceTypeCamera;
        imagePicker.modalTransitionStyle=UIModalTransitionStyleFlipHorizontal;
        [self presentModalViewController:imagePicker animated:YES];
    }else{
        UIAlertView *alert=[ViewBuilder createAlert:@"THIS App can't Use" Message:@"このデバイスではカメラは使用できません" buttonTitle:@"戻る" delegate:self];
        [alert show];
        
    }
}

- (IBAction)photoLibraryButton:(id)sender {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]){
        imagePicker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
        imagePicker.modalTransitionStyle=UIModalTransitionStyleFlipHorizontal;
        [self presentModalViewController:imagePicker animated:YES];
    }else {
        //アラートを出す
        UIAlertView *alert=[ViewBuilder createAlert:@"THIS App can't Use" Message:@"このデバイスではフォトライブラリーが使用できません" buttonTitle:@"戻る" delegate:self];
        [alert show];
        
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
        
        //座標の所得
        PhotoColorLogic *pLogic=[[PhotoColorLogic alloc] init];
        NSArray *pointArray=[pLogic createFacefeature:imageView];
        
        //健康状態の所得
        if (pointArray.count != 0){
            HealthStatusFacade *hManager=[[HealthStatusFacade alloc] init];
            NSNumber *healthStatus=[hManager checkTodayHealth :resizeImage];
            
            //インジケータの表示
            [SVProgressHUD showWithStatus:@"診断中"];
            
            [self performSelector:@selector(dismissIndicator:) withObject:healthStatus afterDelay:4.0f];
        }else {
            UIAlertView *alert=[ViewBuilder createAlert:@"NO FACE" Message:@"これは顔ではない" buttonTitle:@"もう一度撮り直す" delegate:self];
            alert.delegate=self;
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
    return 0;
}

-(void)transitionGraghView:(UIBarButtonItem *)selector{
    GraghViewController *graghView_=[[GraghViewController alloc] initWithNibName:@"GraghViewController" bundle:nil];
    graghView_.modalTransitionStyle=UIModalTransitionStyleFlipHorizontal;
    [self presentModalViewController:graghView_ animated:YES];
}

-(void)viewDidUnload{
    [self setTitleBar:nil];
    imageView=nil;
}


@end


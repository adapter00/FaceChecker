//
//  ViewBuilder.m
//  Face
//
//  Created by takao maeda on 2012/12/09.
//  Copyright (c) 2012年 前田 恭男. All rights reserved.
//

#import "ViewBuilder.h"

@implementation ViewBuilder

+(UIImageView *)createImageView:(UIImage *)image{
    CGRect rect= CGRectMake(0, 0,[[UIScreen mainScreen] applicationFrame].size.width, [[UIScreen mainScreen] applicationFrame].size.height);
    UIGraphicsBeginImageContext(rect.size);
    [image drawInRect:rect];
    UIImage *createImage=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImageView *imageView=[[UIImageView alloc] initWithImage:createImage];
    
    return  imageView;
}

+(UIImage *)resizeImage:(UIImage *)image{
    CGRect rect= CGRectMake(0, 0,[[UIScreen mainScreen] applicationFrame].size.width, [[UIScreen mainScreen] applicationFrame].size.height);
    UIGraphicsBeginImageContext(rect.size);
    [image drawInRect:rect];
    UIImage *createImage=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return createImage;
}

+(UIAlertView *)createAlert:(NSString *)titile Message:(NSString *)message buttonTitle:(NSString *)cancelButtonTitile delegate:(id)delegate{
    UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:titile message:message delegate:delegate cancelButtonTitle:cancelButtonTitile otherButtonTitles:nil, nil];
    return alertView;
}


+(UIActivityIndicatorView *)createIndicator :(UIView *)view Message:(NSString *)message{
    UIActivityIndicatorView *indicator=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    UILabel *examinationLabel=[[UILabel alloc] initWithFrame:CGRectMake(20.0f, 40.0f, view.bounds.size.width/2, view.bounds.size.height/2+20)];
    examinationLabel.text=message;
    [view addSubview:examinationLabel];
    
    indicator.activityIndicatorViewStyle=UIActivityIndicatorViewStyleWhite;
    indicator.alpha=0.5f;
    [indicator setCenter:CGPointMake(view.bounds.size.width/2, view.bounds.size.height/2)];
    
    [view addSubview:indicator];
    [indicator startAnimating];
    return indicator;
}
+(UIButton *)createTranparentButton{
    CGRect rect=[[UIScreen mainScreen] bounds];
    float buttonWidth=30.0f;
    float x=rect.size.width-buttonWidth;
    UIButton *transParentButton=[[UIButton alloc] initWithFrame:CGRectMake(x, 0, buttonWidth, 50)];
    transParentButton.alpha=1.0;
    return transParentButton;
}


@end

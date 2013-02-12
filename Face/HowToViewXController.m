//
//  HowToViewXController.m
//  Face
//
//  Created by 前田 恭男 on 13/02/06.
//  Copyright (c) 2013年 前田 恭男. All rights reserved.
//

#import "HowToViewXController.h"
#import "CommonString.h"
#import <CoreVideo/CoreVideo.h>
#import <CoreMedia/CoreMedia.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <AVFoundation/AVFoundation.h>
#import <math.h>
#import <QuartzCore/QuartzCore.h>




@interface HowToViewXController ()

@end

@implementation HowToViewXController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self initialize];
        
        
    }
    return self;
}

-(void)initialize{
    UIView *baseView=[[UIView alloc] initWithFrame:CGRectMake(0, 0,self.view.bounds.size.width , 1200)];
    _scrollView.contentSize=CGSizeMake(self.view.bounds.size.width, baseView.bounds.size.height);
    _scrollView.scrollEnabled=YES;
    _scrollView.bounces=YES;
    _scrollView.pagingEnabled=NO;
    _scrollView.delegate=self;
    _scrollView.showsVerticalScrollIndicator=YES;
    
    UIImageView *howTo1=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"HOWTO_1"]];
    UIImageView *howTo2=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"HOWTO_2"]];
    UIImageView *howTo3=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"HOWTO_3"]];
    UITextView *text1=[[UITextView alloc] initWithFrame:CGRectMake(20, 400, 300, 40)];
    UITextView *text2=[[UITextView alloc] initWithFrame:CGRectMake(20, 740, 300, 40)];
    UITextView *text3=[[UITextView alloc] initWithFrame:CGRectMake(20, 1080, 300, 40)];
    
    text1.text=@"1、写真をとります";
    text2.text=@"2、結果を見ます";
    text3.text=@"3、自分の健康状態に一喜一憂します";
    howTo1.frame=CGRectMake(20, 100, 300, 300);
    howTo2.frame=CGRectMake(30, 440, 300, 300);
    howTo3.frame=CGRectMake(30, 780, 300, 300);
    [baseView addSubview:howTo1];
    [baseView addSubview:text1];
    [baseView addSubview:howTo2];
    [baseView addSubview:text2];
    [baseView addSubview:howTo3];
    [baseView addSubview:text3];
    [_scrollView addSubview:baseView];
    
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

@end

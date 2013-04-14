//
//  HealthResultView.m
//  Face
//
//  Created by 前田 恭男 on 12/12/18.
//  Copyright (c) 2012年 前田 恭男. All rights reserved.
//

#import "HealthResultViewController.h"

enum{
    GOOD_STATUS=1,
    NORMAL_STATUS=2,
    BAD_STATUS=3,
};

@interface HealthResultViewController ()

@end

@implementation HealthResultViewController
@synthesize resultLabel;
@synthesize healthStatus;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSString *healthString=[NSString stringWithFormat:@"あなたの健康状態は%@\nになります",[self resultText:healthStatus]];
    resultLabel.text=healthString;
    if(resultLabel.text==nil){
            resultLabel.text=@"エラーなので死んでください";
    }
}

- (void)viewDidUnload
{
    [self setResultLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(NSString *)resultText :(NSNumber *)hStatus{
    int healthNumber=[hStatus intValue];
    switch (healthNumber) {
        case GOOD_STATUS:
            return @"健康体です";
            break;
        case NORMAL_STATUS:
            return @"まぁ健康体です";
            break;
        case BAD_STATUS:
            return @"不健康さんです";
            break;
        default:
            return @"不正確な値になっています";
            break;
    }
    return 0;
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [self dismissModalViewControllerAnimated:YES];
}

@end

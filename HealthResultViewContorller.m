//
//  HealthResultView.m
//  Face
//
//  Created by 前田 恭男 on 12/12/18.
//  Copyright (c) 2012年 前田 恭男. All rights reserved.
//

#import "HealthResultViewController.h"
#import "CommonString.h"
#import "CommonNumber.h"

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
    NSString *healthString=[NSString stringWithFormat:HEALTH_STATUS_MESSAGE,[self resultText:healthStatus]];
    resultLabel.text=healthString;
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
            return HEALTH_STATUS_GOOD;
            break;
        case NORMAL_STATUS:
            return HEALTH_STATUS_SO_GOOD;
            break;
        case WORTH_STATUS:
            return HEALTH_STATUS_BAD;
            break;
        default:
            return HEALTH_STATUS_ERROR;
            break;
    }
    return nil;
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [self dismissModalViewControllerAnimated:YES];
}

@end

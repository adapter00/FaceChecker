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
@synthesize healthStatusNumber;

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
    NSString *healthString = [NSString stringWithFormat:HEALTH_STATUS_MESSAGE,[self resultText:healthStatusNumber]];
    resultLabel.text=healthString;
}

- (void)viewDidUnload
{
    [self setResultLabel:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(NSString *)resultText :(NSNumber *)hStatus{
    int healthNumber=[hStatus intValue];
    NSString *healthStatus = [[NSString alloc] init];
    switch (healthNumber) {
        case GOOD_STATUS:
            healthStatus = HEALTH_STATUS_GOOD;
            break;
        case NORMAL_STATUS:
            healthStatus = HEALTH_STATUS_SO_GOOD;
            break;
        case WORTH_STATUS:
            healthStatus = HEALTH_STATUS_BAD;
            break;
        default:
            healthStatus = HEALTH_STATUS_ERROR;
            break;
    }
    return healthStatus;
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [self dismissModalViewControllerAnimated:YES];
}

@end

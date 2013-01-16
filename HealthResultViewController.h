//
//  HealthResultView.h
//  Face
//
//  Created by 前田 恭男 on 12/12/18.
//  Copyright (c) 2012年 前田 恭男. All rights reserved.
//

#import "StartViewController.h"

@interface HealthResultViewController : StartViewController<UIAlertViewDelegate>

@property (strong, nonatomic) IBOutlet UILabel *resultLabel;
@property (strong, nonatomic)NSNumber *healthStatus;

@end

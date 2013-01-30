//
//  graghView.m
//  Face
//
//  Created by 前田 恭男 on 12/12/19.
//  Copyright (c) 2012年 前田 恭男. All rights reserved.
//

#import "GraghViewController.h"
#import "HealthDatabaseHelp.h"
#import "HealthDataDxo.h"
#import "HealthEntity.h"
#import "HealthDto.h"
#import "ViewBuilder.h"
#import "HealthStatusFacade.h"
#import "CommonString.h"

@interface GraghViewController (){
    NSMutableArray *allData;
    UIButton *deleteButton;
}

@end

@implementation GraghViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initialize];
    [self.view addSubview:deleteButton];
    // Do any additional setup after loading the view from its nib.
}

-(void)initialize{
    HealthDatabaseHelp *dbHelper=[[HealthDatabaseHelp alloc] init];
    allData=[dbHelper selectAllData];
    if ( allData.count !=0) {
        CGRect rect=[[UIScreen mainScreen] bounds];
        graghView_=[[S7GraphView alloc] initWithFrame:rect];
        graghView_.dataSource=self;
        allData=[dbHelper selectAllData];
        graghView_.backgroundColor=[UIColor whiteColor];
        graghView_.drawAxisX=YES;
        graghView_.drawAxisY=YES;
        graghView_.drawGridX=YES;
        graghView_.drawGridY=YES;
        graghView_.xValuesColor=[UIColor blackColor];
        graghView_.yValuesColor=[UIColor blackColor];
        graghView_.infoColor=[UIColor blackColor];
        graghView_.drawInfo=NO;
        [self createXFormatter];
        [self createYFormatter];
        self.view=graghView_;
        deleteButton=[ViewBuilder createTranparentButton];
        [deleteButton addTarget:self action:@selector(deleteButton:) forControlEvents:UITouchPhaseEnded];
    }
    else{
        UITextView *text=[[UITextView alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
        text.text=NO_DATA;
        [self.view addSubview:text];
    }
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    self.modalTransitionStyle=UIModalTransitionStyleFlipHorizontal;
    [self dismissModalViewControllerAnimated:YES];
}


#pragma mark delegateMethod

-(NSUInteger)graphViewNumberOfPlots:(S7GraphView *)graphView{
    return 1;
}


-(NSArray *)graphViewXValues:(S7GraphView *)graphView{
    NSMutableArray *arrayX=[[NSMutableArray alloc] initWithCapacity:20];
    
    for (int i=0; i<allData.count; i++) {
        
        HealthEntity *entity=[allData objectAtIndex:i];
        HealthDto *dto=[HealthDataDxo createHealthDto:entity];
        
        if (dto.recordDate !=nil) {
            NSLog(@"dtoDate:%@",dto.recordDate);
            [arrayX addObject:dto.recordDate];
        }
    }
    return arrayX;
    
}
-(NSArray *)graphView:(S7GraphView *)graphView yValuesForPlot:(NSUInteger)plotIndex{
    NSMutableArray *arrayY=[[NSMutableArray alloc] initWithCapacity:20];
    switch (plotIndex) {
        case 0:
            for (int i=0; i<allData.count; i++) {
                
                HealthEntity *entity=[allData objectAtIndex:i];
                HealthDto *dto=[HealthDataDxo createHealthDto:entity];
                if (dto.healthStatus !=0) {
                    [arrayY addObject:[NSNumber numberWithInt:dto.healthStatus]];
                }
                
            }
            break;
    }
    return arrayY;
}

#pragma mark graghPrivateMethod


-(void)createXFormatter{
    NSDateFormatter *formatter=[NSDateFormatter new];
    [formatter setTimeStyle:NSDateFormatterMediumStyle];
    [formatter setDateStyle:NSDateFormatterNoStyle];
    [formatter setLocale:[[NSLocale alloc]initWithLocaleIdentifier:JAPANESE]];
    
    graghView_.xValuesFormatter=formatter;
}

-(void)createYFormatter{
    NSNumberFormatter *formatter=[NSNumberFormatter new];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [formatter setMinimumFractionDigits:0];
    [formatter setMaximumFractionDigits:0];
    graghView_.yValuesFormatter=formatter;
}

-(IBAction)deleteButton:(id)sender{
    HealthStatusFacade *facade=[[HealthStatusFacade alloc] init];
    [facade deleteAllData];
}

@end

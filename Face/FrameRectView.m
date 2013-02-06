
//
//  FrameRectView.m
//  Face
//
//  Created by 前田 恭男 on 13/02/06.
//  Copyright (c) 2013年 前田 恭男. All rights reserved.
//

#import "FrameRectView.h"


static const CGFloat kDefaultRectMinWidth =50.0f;
static const CGFloat kDefaultRectMinHeight=30.0f;

static const CGFloat kDefaultRectWidth=220.0f;
static const CGFloat kDefaultRectHeight=50.0f;
static const CGFloat kDefaultStrokeSize=5.0f;


@interface FrameRectView ()

-(void)updateRectImge;
@property (nonatomic ,retain)UIColor *strokeColor;
@property (nonatomic ,retain)UIColor *fillColor;


@end





@implementation FrameRectView

@synthesize strokeColor=_strokeColor;
@synthesize fillColor=_fillColor;

#pragma mark -

-(id)initWithFrame:(CGRect)frame withCenterY:(CGFloat)y{
    self=[super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
        
        
        // --set position parameter
        
        {
            CGFloat startX=frame.size.width/2 - kDefaultRectWidth/2;
            if (y>0) {
                centerY=y;
            }
            else {
                centerY=frame.size.height/2;
            }
            targetFrameRect=CGRectMake(startX, centerY-kDefaultRectMinHeight / 2, kDefaultRectWidth, kDefaultRectHeight);
        }
        
        // --set color parameter
        
        {
            [self setStrokeColor:[UIColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:1.0f]];
            [self setFillColor:[UIColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:0.2f]];
        }
        
        // --set getturerecognizer
        {
            UIGestureRecognizer *dragGesture=[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(dragView:)];

#pragma mark- FIXME:これは使わない
//            [self addGestureRecognizer:dragGesture];
        }
    }
    return  self;
}


#pragma  mark- 


-(void)drawRect:(CGRect)rect{
    //create bezierPath Instance
    [self updateRectImge];
}

#pragma mark-
#pragma mark touch handling

-(void)draggedView:(id)sender{
    UIPanGestureRecognizer *pan=(UIPanGestureRecognizer *)sender;
    CGPoint location=[pan locationInView:self];
    
    if (pan.state==UIGestureRecognizerStateBegan) {

    }
}


#pragma mark- 
#pragma mark- private methods

-(void)updateRectImge{
    UIBezierPath *aPath=[UIBezierPath bezierPath];
    
    //setrrender color and style
    [self.strokeColor setStroke];
    [self.fillColor setFill];
    aPath.lineWidth=2;
    
    //set start point
    
    {
        CGFloat originX=targetFrameRect.origin.x;
        CGFloat originY=targetFrameRect.origin.y;
        CGFloat wifth=targetFrameRect.size.width;
        CGFloat height=targetFrameRect.size.height;
        
        [aPath moveToPoint:CGPointMake(originX, originY)];
        [aPath addLineToPoint:CGPointMake(originX+wifth, originY+height)];
        [aPath addLineToPoint:CGPointMake(originX, originY+height)];
        [aPath addLineToPoint:CGPointMake(originX, originY)];
        
    }
    //close path so thst successes to create pentagon
    
    [aPath closePath];
    
    //rendering
    [aPath stroke];
    [aPath fill];

}

@end

//
//  BSAlert.m
//  BSAlert
//
//  Created by Kayle Gishen on 7/4/12.
//  Copyright (c) 2012 Baked Software. All rights reserved.
//

#import "BSAlert.h"

static const float kBSAlertHeight = 30.0f;
static const float kBSAlertWidth = 280.0f;
static const float kBSAlertCornerRadius = 8.0f;
static NSString *kBSAlertShowContext = @"bsalertshow";

static const float kBSAlertWarningColor[4] = { 0.95f, 0.302f, 0.294f, 1.0f };
static const float kBSAlertInfoColor[4] = { 0.3f, 0.48f, 0.95f, 1.0f };
static const float kBSAlertSuccessColor[4] = { 0.514f, 0.91f, 0.5, 1.0f };

#import <QuartzCore/QuartzCore.h>

@interface BSAlert ()
{
    UILabel *titleLabel;
}

@end

@implementation BSAlert

- (id)initWithStyle:(enum BSAlertStyle)style andTitle:(NSString*)title
{
    self = [super initWithFrame:CGRectMake(20, -kBSAlertHeight, kBSAlertWidth, kBSAlertHeight)];
    if(self)
    {
        self.layer.cornerRadius = kBSAlertCornerRadius;
        self.layer.shadowColor = [UIColor blackColor].CGColor;
        self.layer.shadowOffset = CGSizeMake(0, 2);
        self.layer.shadowOpacity = 0.3f;
        self.layer.shadowRadius = 1;
        CAGradientLayer *gradient = [CAGradientLayer layer];
        const CGFloat *cs;
        switch (style) {
            case BSAlertStyleInfo:
                cs = kBSAlertInfoColor;
                break;
            case BSAlertStyleSuccess:
                cs = kBSAlertSuccessColor;
                break;
            case BSAlertStyleWarning:
                cs = kBSAlertWarningColor;
            default:
                cs = kBSAlertWarningColor;
                break;
        }
        
        gradient.colors = [NSArray arrayWithObjects:
                           (id)[[UIColor colorWithRed:cs[0] green:cs[1] blue:cs[2] alpha:1] CGColor],
                           (id)[[UIColor colorWithRed:0.7f*cs[0]
                                                green:0.7f*cs[1]
                                                 blue:0.7f*cs[2]
                                                alpha:1] CGColor],
                           nil];
        gradient.locations = [NSArray arrayWithObjects:
                              [NSNumber numberWithFloat:0.0f],
                              [NSNumber numberWithFloat:1.0f],
                              nil];
        gradient.frame = self.bounds;
        gradient.cornerRadius = kBSAlertCornerRadius;
        [self.layer insertSublayer:gradient atIndex:0];
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kBSAlertWidth, kBSAlertHeight)];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.text = title;
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.textColor = [UIColor whiteColor];
        [self addSubview:titleLabel];
    }
    
    return self;
}

- (void)show
{
    [[[UIApplication sharedApplication] keyWindow] addSubview:self];
    
    [UIView animateWithDuration:0.3f
                     animations:^{
                         CGRect newFrame = self.frame;
                         newFrame.origin.y = kBSAlertHeight;
                         self.frame = newFrame;
                     }
                     completion:^(BOOL finished){
                         if(finished)
                         {
                             [UIView animateWithDuration:0.2f
                                                   delay:1.5f
                                                 options:UIViewAnimationOptionCurveEaseIn
                                              animations:^{
                                                 CGRect newFrame = self.frame;
                                                 newFrame.origin.y = -kBSAlertHeight;
                                                 self.frame = newFrame;
                                              }
                                              completion:^(BOOL finished){ if(finished) [self removeFromSuperview];
                                              }];
                         }
                     }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end

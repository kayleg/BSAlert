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

static const float kBSAlertErrorColor[4] = { 0.95f, 0.302f, 0.294f, 1.0f };
static const float kBSAlertInfoColor[4] = { 0.3f, 0.48f, 0.95f, 1.0f };
static const float kBSAlertSuccessColor[4] = { 0.514f, 0.91f, 0.5, 1.0f };
static const float kBSAlertWarningColor[4] = { 1.0f, 0.91f, 0.35f, 1.0f };

#import <QuartzCore/QuartzCore.h>

@interface BSAlert ()
{
    UILabel *titleLabel;
    enum BSAlertStyle _style;
    id _target;
    SEL _action;
}

- (void)_onTap;
- (void)_dismissWithDelay:(NSTimeInterval)delay;

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
        _style = style;
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, kBSAlertWidth - 20, kBSAlertHeight)];
        if (style & BSAlertStyleInfo)
        {
            cs = kBSAlertInfoColor;
            titleLabel.textColor = [UIColor whiteColor];
        } else if (style & BSAlertStyleSuccess)
        {
            cs = kBSAlertSuccessColor;
            titleLabel.textColor = [UIColor darkTextColor];
        } else if (style & BSAlertStyleError)
        {
            cs = kBSAlertErrorColor;
            titleLabel.textColor = [UIColor whiteColor];
        }else
        {
            cs = kBSAlertWarningColor;
            titleLabel.textColor = [UIColor darkTextColor];
        }
        
        if (style & BSAlertStyleDismissOnTap) {
            UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_onTap)];
            [self addGestureRecognizer:tapRecognizer];
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

        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.text = title;
        titleLabel.backgroundColor = [UIColor clearColor];
        
        titleLabel.adjustsFontSizeToFitWidth = YES;
        [self addSubview:titleLabel];
    }
    
    return self;
}

- (id)initWithStyle:(enum BSAlertStyle)style andTitle:(NSString *)title target:(id)target action:(SEL)action
{
    
    style |= BSAlertStyleDismissOnTap;
    self = [self initWithStyle:style andTitle:title];
    
    if (self) {
        _target = target;
        _action = action;
        

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

                         if(!(_style & BSAlertStyleDismissOnTap) && finished)
                         {
                             [self _dismissWithDelay:1.5];
                         }
                     }];
}

- (void)dismiss
{
    [self _dismissWithDelay:0];
}

#pragma mark - BSAlert Private Methods

- (void)_onTap
{
    [self _dismissWithDelay:0];
}

- (void)_dismissWithDelay:(NSTimeInterval)delay
{
    [UIView animateWithDuration:0.2f
                          delay:delay
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         CGRect newFrame = self.frame;
                         newFrame.origin.y = -kBSAlertHeight;
                         self.frame = newFrame;
                     }
                     completion:^(BOOL finished){
                         if(finished){
                             if (_target && _action) {
                                 [_target performSelector:_action];
                             }
                             [self removeFromSuperview];
                         }
                     }];}

@end

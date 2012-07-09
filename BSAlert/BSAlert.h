//
//  BSAlert.h
//  BSAlert
//
//  Created by Kayle Gishen on 7/4/12.
//  Copyright (c) 2012 Baked Software. All rights reserved.
//

#import <UIKit/UIKit.h>

enum BSAlertStyle {
    BSAlertStyleInfo            = 1 << 0,
    BSAlertStyleWarning         = 1 << 1,
    BSAlertStyleSuccess         = 1 << 2,
    BSAlertStyleError           = 1 << 3,
    BSAlertStyleDismissOnTap    = 1 << 4
    };

@interface BSAlert : UIView 

- (id)initWithStyle:(enum BSAlertStyle)style andTitle:(NSString*)title;
- (id)initWithStyle:(enum BSAlertStyle)style andTitle:(NSString *)title target:(id)target action:(SEL)action;
- (void)show;
- (void)dismiss;

@end

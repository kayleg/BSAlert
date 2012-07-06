//
//  BSAlert.h
//  BSAlert
//
//  Created by Kayle Gishen on 7/4/12.
//  Copyright (c) 2012 Baked Software. All rights reserved.
//

#import <UIKit/UIKit.h>

enum BSAlertStyle {
    BSAlertStyleInfo = 1,
    BSAlertStyleWarning = 1 << 1,
    BSAlertStyleSuccess = 1 << 2,
    BSAlertStyleDismissOnTap = 1 << 3
    };

@interface BSAlert : UIView 

- (id)initWithStyle:(enum BSAlertStyle)style andTitle:(NSString*)title;
- (void)show;
- (void)dismiss;

@end

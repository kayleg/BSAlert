//
//  BSAlert.h
//  BSAlert
//
//  Created by Kayle Gishen on 7/4/12.
//  Copyright (c) 2012 Baked Software. All rights reserved.
//

#import <UIKit/UIKit.h>

enum BSAlertStyle {
    BSAlertStyleInfo,
    BSAlertStyleWarning,
    BSAlertStyleSuccess
    };

@interface BSAlert : UIView 

- (id)initWithStyle:(enum BSAlertStyle)style andTitle:(NSString*)title;
- (void)show;

@end

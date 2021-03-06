//
//  BSViewController.m
//  BSAlert
//
//  Created by Kayle Gishen on 7/4/12.
//  Copyright (c) 2012 Baked Software. All rights reserved.
//

#import "BSViewController.h"
#import "BSAlert.h"

@interface BSViewController ()

- (void)showInfo;
- (void)showWarning;
- (void)showSuccess;
- (void)showTappable;

@end

@implementation BSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showInfo)];
    [self.view addGestureRecognizer:tapRecognizer];
    tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showWarning)];
    tapRecognizer.numberOfTapsRequired = 2;
    [self.view addGestureRecognizer:tapRecognizer];
    tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showSuccess)];
    tapRecognizer.numberOfTouchesRequired = 2;
    [self.view addGestureRecognizer:tapRecognizer];
    tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showTappable)];
    tapRecognizer.numberOfTapsRequired = 2;
    tapRecognizer.numberOfTouchesRequired = 2;
    [self.view addGestureRecognizer:tapRecognizer];
}

- (void)showInfo
{
    BSAlert* alert = [[BSAlert alloc] initWithStyle:BSAlertStyleInfo andTitle:@"This is some info"];
    [alert show];

}

- (void)showWarning
{
    BSAlert* alert = [[BSAlert alloc] initWithStyle:BSAlertStyleWarning andTitle:@"Yikes!! Something is wrong"];
    [alert show];
}

- (void)showSuccess
{
    BSAlert* alert = [[BSAlert alloc] initWithStyle:BSAlertStyleSuccess | BSAlertStyleDismissOnTap andTitle:@"Everything is OOOKK"];
    [alert show];
}

- (void)showTappable
{
    BSAlert *alert = [[BSAlert alloc] initWithStyle:BSAlertStyleWarning andTitle:@"Something Happened, Tap for more info" target:self action:@selector(showInfo)];
    [alert show];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end

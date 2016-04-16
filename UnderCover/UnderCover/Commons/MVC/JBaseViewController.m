//
//  JBaseViewController.m
//  Journey
//
//  Created by Wayde Sun on 6/30/13.
//  Copyright (c) 2013 iHakula. All rights reserved.
//

#import "JBaseViewController.h"

@interface JBaseViewController ()
- (void)callBtnClicked;
@end

@implementation JBaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        appDelegate = [UCAppDelegate getSharedAppDelegate];
    }
    return self;
}

- (id)init {
    self = [super init];
    if (self) {
        appDelegate = [UCAppDelegate getSharedAppDelegate];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Public Methods
- (void)showAlertMessage:(NSString *)msg {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:LOCALIZED_DEFAULT_SYSTEM_TABLE(@"WarmServiceTitle") message:msg delegate:nil cancelButtonTitle:LOCALIZED_DEFAULT_SYSTEM_TABLE(@"ok") otherButtonTitles:nil, nil];
    [alert show];
}

- (void)showMessage:(NSString *)msg {
    [appDelegate.customerMessageStatusBar showMessage:msg];
}

- (void)hideMessage {
    [appDelegate.customerMessageStatusBar hide];
}

#pragma mark - Private Methods
- (void)setupRightCallItem {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:LOCALIZED_DEFAULT_SYSTEM_TABLE(@"CallMe") style:UIBarButtonItemStylePlain target:self action:@selector(callBtnClicked)];
}

- (void)callBtnClicked {
    // MKReverseGeocoder
    // CLGeocoder
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:LOCALIZED_DEFAULT_SYSTEM_TABLE(@"CallMeTitle")
                                                             delegate:self
                                                    cancelButtonTitle:LOCALIZED_DEFAULT_SYSTEM_TABLE(@"Cancel")
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:LOCALIZED_DEFAULT_SYSTEM_TABLE(@"ABiao"), LOCALIZED_DEFAULT_SYSTEM_TABLE(@"AHui"), nil];
    
    self.view.clipsToBounds = YES;
    [actionSheet showInView:appDelegate.window];
}
@end

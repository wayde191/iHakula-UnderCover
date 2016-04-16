//
//  JAboutUsViewController.m
//  Journey
//
//  Created by Wayde Sun on 7/1/13.
//  Copyright (c) 2013 iHakula. All rights reserved.
//

#import "JAboutUsViewController.h"
#import "CustomerBarButtonItem.h"

@interface JAboutUsViewController ()
- (void)leftBarBtnClicked;
- (void)adapterLogout;
@end

@implementation JAboutUsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = LOCALIZED_DEFAULT_SYSTEM_TABLE(@"iHakula");
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupRightFeedbackItem];
    [self adapterLogout];
}

- (void)setupRightFeedbackItem {
    UIBarButtonItem *leftDoneBtn = [CustomerBarButtonItem createGoBackItemWithTitle:LOCALIZED_DEFAULT_SYSTEM_TABLE(@"MoreNews")];
    leftDoneBtn.target = self;
    leftDoneBtn.action = @selector(leftBarBtnClicked);
    self.navigationItem.leftBarButtonItem = leftDoneBtn;
}

- (void)adapterLogout {
//    if (!IH_IS_IPHONE) {
//        _blogTitleLabel.left += 210;
//        _blogLabel.left += 210;
//        _mailTitleLabel.left += 210;
//        _mailLabel.left += 210;
//        _logoImageView.left += 225;
//    }
}

- (void)leftBarBtnClicked {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setBlogTitleLabel:nil];
    [self setBlogLabel:nil];
    [self setMailTitleLabel:nil];
    [self setMailLabel:nil];
    [self setLogoImageView:nil];
    [super viewDidUnload];
}
@end

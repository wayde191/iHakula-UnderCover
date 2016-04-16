//
//  JServiceViewController.m
//  Journey
//
//  Created by Wayde Sun on 7/1/13.
//  Copyright (c) 2013 iHakula. All rights reserved.
//

#import "JServiceViewController.h"
#import "UCWordsUpdatedModel.h"
#import "CustomerBarButtonItem.h"

@interface JServiceViewController ()
- (void)updateDBTotalNumber;
- (void)setupRightFeedbackItem;
- (void)leftBarBtnClicked;
- (void)showLabel;
- (void)showWrongLabel;
@end

@implementation JServiceViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = LOCALIZED_DEFAULT_SYSTEM_TABLE(@"WordsManagement");
        _dm = [[UCWordsUpdatedModel alloc] init];
        _dm.delegate = self;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self updateUseageNumber];
    [self updateDBTotalNumber];
    [self setupRightFeedbackItem];
}

- (void)setupRightFeedbackItem {
    UIBarButtonItem *leftDoneBtn = [CustomerBarButtonItem createGoBackItemWithTitle:LOCALIZED_DEFAULT_SYSTEM_TABLE(@"MoreNews")];
    leftDoneBtn.target = self;
    leftDoneBtn.action = @selector(leftBarBtnClicked);
    self.navigationItem.leftBarButtonItem = leftDoneBtn;
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
    [self setUsedLabel:nil];
    [self setSystemTotalWordsLabel:nil];
    [self setDbTotalWordsLabel:nil];
    [self setIndicator:nil];
    [self setUpdateWordsBtn:nil];
    [super viewDidUnload];
}

- (void)getDBtotalNumberSuccess {
    [_indicator stopAnimating];
    _indicator.hidden = YES;
    _dbTotalWordsLabel.hidden = NO;
    _dbTotalWordsLabel.text = [NSString stringWithFormat:@"%d", _dm.dbTotalNumber];
    
    if (_dm.dbTotalNumber > _dm.totalSystemNumber) {
        _updateWordsBtn.enabled = YES;
    }
 

}
- (void) handleTimer: (NSTimer *) timer // timer的回调函数
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.5];
    _tipLabel.alpha = 0;
    [UIView commitAnimations];
    
}
- (IBAction)onSwitchThesaurusBtnClicked:(id)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:LOCALIZED_DEFAULT_SYSTEM_TABLE(@"SwitchThesaurusTitle")
                                                             delegate:self
                                            cancelButtonTitle:LOCALIZED_DEFAULT_SYSTEM_TABLE(@"cancel")
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:LOCALIZED_DEFAULT_SYSTEM_TABLE(@"ChineseThesaurus"), LOCALIZED_DEFAULT_SYSTEM_TABLE(@"EnglishThesaurus"), nil];
    
    self.view.clipsToBounds = YES;
    [actionSheet showInView:appDelegate.window];
}

- (IBAction)onUpdateWordsBtnClicked:(id)sender {
    [_dm doCallUpdateWordsService];
}

- (IBAction)onFiveStarBtnClicked:(id)sender {
    NSString *appId = nil;
    if (IH_UNDERCOVER_FREE) {
        appId = @"680156991";
    } else {
        appId = @"679459643";
    }
    
    NSString *url = [NSString stringWithFormat:@"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%@", appId];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
    
    //pay: 679459643
    //free: 680156991
}

#pragma mark - Private Methods
- (void)updateUseageNumber {
    [_dm updateUseageNumber];
    _usedLabel.text = [NSString stringWithFormat:@"%d", _dm.usedWordsNumber];
    _systemTotalWordsLabel.text = [NSString stringWithFormat:@"%d", _dm.totalSystemNumber];
    
    NSInteger systemTotalWordsNum = [_systemTotalWordsLabel.text integerValue];
    NSInteger dbTotalWordsNum = [_dbTotalWordsLabel.text integerValue];
    if(dbTotalWordsNum > systemTotalWordsNum) {
        _updateWordsBtn.enabled = YES;
    } else {
        _updateWordsBtn.enabled = NO;
    }

}

- (void)updateDBTotalNumber {
    [_indicator startAnimating];
    _indicator.hidden = NO;
    _dbTotalWordsLabel.hidden = YES; 
    [_dm doCallGetDBTotalWordsNumber];
}
- (void)showLabel
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.5];
    _tipLabel.alpha = 1;
    [UIView commitAnimations];
    _tipLabel.text = LOCALIZED_DEFAULT_SYSTEM_TABLE(@"UpdateSuccess");
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval: 2// 当函数正在调用时，及时间隔时间到了 也会忽略此次调用
                                                      target: self
                                                    selector: @selector(handleTimer:)
                                                    userInfo: nil
                                                     repeats: NO];

}
- (void)showWrongLabel
{
    _tipLabel.alpha = 1;
    _tipLabel.text = LOCALIZED_DEFAULT_SYSTEM_TABLE(@"UpdateFailed");
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval: 2// 当函数正在调用时，及时间隔时间到了 也会忽略此次调用
                                                      target: self
                                                    selector: @selector(handleTimer:)
                                                    userInfo: nil
                                                     repeats: NO];

}
#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (2 != buttonIndex) {
        if (0 == buttonIndex) {
            appDelegate.user.language = @"";
        } else if (1 == buttonIndex) {
            appDelegate.user.language = @"en";
        }
        
        [self updateUseageNumber];
        [self updateDBTotalNumber];
    }
}


@end

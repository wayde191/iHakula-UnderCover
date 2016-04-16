//
//  JFeedbackViewController.m
//  Journey
//
//  Created by Wayde Sun on 7/2/13.
//  Copyright (c) 2013 iHakula. All rights reserved.
//

#import "JFeedbackViewController.h"
#import "iHArithmeticKit.h"
#import "CustomerBarButtonItem.h"

#define TEXT_VIEW_DEFAULT_COLOR     RGBACOLOR(187, 187, 187, 1)

@interface JFeedbackViewController ()
- (void)setupRightFeedbackItem;
- (void)sureBtnClicked;
- (void)leftBarBtnClicked;
- (void)restoreTextView;
- (void)adapterLogout;
- (void)showLabel;
- (void)showWrongLabel;
@end

@implementation JFeedbackViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = LOCALIZED_DEFAULT_SYSTEM_TABLE(@"feedback");
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupRightFeedbackItem];
    [self restoreTextView];
    [self adapterLogout];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setTheTextView:nil];
    [self setLengthLabel:nil];
    [self setContactUsTitleLabel:nil];
    [self setContactUsLabel:nil];
    [self setQqTitleLabel:nil];
    [self setQqLabel:nil];
    [super viewDidUnload];
}

#pragma mark UItextViewDelegate
- (void)textViewDidChange:(UITextView *)textView{
    NSUInteger strLength = [iHArithmeticKit lengthOfComplexStr:textView.text];
    NSUInteger numOfHanzi = (strLength - textView.text.length)/2;
    self.lengthLabel.text = [NSString stringWithFormat:@"%d/500",(textView.text.length + numOfHanzi)];
    if ((textView.text.length + numOfHanzi) > 500) {
//        textView.text = [textView.text substringToIndex:[textView.text length] - 1];
        self.lengthLabel.textColor = [UIColor redColor];
    }else{
        self.lengthLabel.textColor = RGBACOLOR(68, 30, 12, 1);
    }
}

- (void)textViewDidBeginEditing:(UITextView *)textView{
    textView.text = @"";
    textView.textColor = [UIColor blackColor];
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    if (0 == textView.text.length) {
        [self restoreTextView];
    }
}

- (void)onFeedbackSuccess {
    appDelegate.user.delegate = nil;
    _theTextView.text = nil;
    [self showLabel];
}
- (void)showLabel
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.5];
    _tipLabel.alpha = 1;
    [UIView commitAnimations];
    _tipLabel.text = LOCALIZED_DEFAULT_SYSTEM_TABLE(@"submitSuccess");
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval: 2// 当函数正在调用时，及时间隔时间到了 也会忽略此次调用
                                                      target: self
                                                    selector: @selector(handleTimer:)
                                                    userInfo: nil
                                                     repeats: NO];
    
}
- (void)showWrongLabel
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.5];
    _tipLabel.alpha = 1;
    [UIView commitAnimations];
    _tipLabel.text = LOCALIZED_DEFAULT_SYSTEM_TABLE(@"submitFailed");
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval: 2// 当函数正在调用时，及时间隔时间到了 也会忽略此次调用
                                                      target: self
                                                    selector: @selector(handleTimer:)
                                                    userInfo: nil
                                                     repeats: NO];
    
}
- (void) handleTimer: (NSTimer *) timer // timer的回调函数
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.5];
    _tipLabel.alpha = 0;
    [UIView commitAnimations];
    
}
#pragma mark - Private Methods
- (void)adapterLogout {
//    if (!IH_IS_IPHONE) {
//        _contactUsTitleLabel.left += 210;
//        _contactUsLabel.left += 210;
//        _qqTitleLabel.left += 210;
//        _qqLabel.left += 210;
//    }
}

- (void)setupRightFeedbackItem {
    UIBarButtonItem *leftDoneBtn = [CustomerBarButtonItem createGoBackItemWithTitle:LOCALIZED_DEFAULT_SYSTEM_TABLE(@"MoreNews")];
    leftDoneBtn.target = self;
    leftDoneBtn.action = @selector(leftBarBtnClicked);
    self.navigationItem.leftBarButtonItem = leftDoneBtn;
    
    UIBarButtonItem *rightAddBtn = [CustomerBarButtonItem createRectBarButtonItemWithTitle:LOCALIZED_DEFAULT_SYSTEM_TABLE(@"ok")];
    rightAddBtn.target = self;
    rightAddBtn.action = @selector(sureBtnClicked);
    self.navigationItem.rightBarButtonItem = rightAddBtn;
}

- (void)leftBarBtnClicked {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)sureFeedBtnClicked:(id)sender
{
    [self sureBtnClicked];


}
- (void)sureBtnClicked {
    if ([_lengthLabel.text isEqualToString:@"0/500"]) {
        [self showAlertMessage:LOCALIZED_DEFAULT_SYSTEM_TABLE(@"iHServiceErrorFeedbackEmpty")];
        return;
    }
    appDelegate.user.delegate = self;
    [appDelegate.user doCallFeedbackService:_theTextView.text];
}

- (IBAction)onBgClicked:(id)sender {
    [_theTextView resignFirstResponder];
}

- (void)restoreTextView {
    self.theTextView.text = LOCALIZED_DEFAULT_SYSTEM_TABLE(@"feedbackDefault");
    self.theTextView.textColor = TEXT_VIEW_DEFAULT_COLOR;
}
@end

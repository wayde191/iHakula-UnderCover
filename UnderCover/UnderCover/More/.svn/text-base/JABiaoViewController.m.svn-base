//
//  JABiaoViewController.m
//  Journey
//
//  Created by Wayde Sun on 7/2/13.
//  Copyright (c) 2013 iHakula. All rights reserved.
//

#import "JABiaoViewController.h"
#import "CustomerBarButtonItem.h"

@interface JABiaoViewController ()
- (void)setupRightFeedbackItem;
- (void)leftBarBtnClicked;
@end

@implementation JABiaoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = LOCALIZED_DEFAULT_SYSTEM_TABLE(@"Specification");
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupRightFeedbackItem];
    
    NSString *fileName = @"rules";
    if ([CURRENT_LANGUAGE isEqualToString:@"en"]) {
        fileName = @"rules-en";
    } else {
        fileName = @"rules";
    }
    
    NSError *err = nil;
    NSString *dataPath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"html"];
    NSString *content = [NSString stringWithContentsOfFile:dataPath encoding:NSUTF8StringEncoding error:&err];
    if (!err) {
        [_webView loadHTMLString:content baseURL:nil];
        NSLog(@"%f",_webView.frame.size.height);
    }
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
    [self setWebView:nil];
    [super viewDidUnload];
}

@end

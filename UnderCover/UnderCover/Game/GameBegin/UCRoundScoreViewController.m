//
//  UCRoundScoreViewController.m
//  UnderCover
//
//  Created by Wayde Sun on 7/21/13.
//  Copyright (c) 2013 iHakula. All rights reserved.
//

#import "UCRoundScoreViewController.h"
#import "JHomeCell.h"
#import "RoundPlayer.h"
#import "CustomerBarButtonItem.h"
#import "HomeCellHeader.h"
#import "MobClick.h"

@interface UCRoundScoreViewController ()
- (void)setupNavItems;
- (void)rightAddBtnClicked;
- (void)leftBtnClicked;
@end

@implementation UCRoundScoreViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = LOCALIZED_DEFAULT_SYSTEM_TABLE(@"Billboard");
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [_tableView reloadData];
    [self setupNavItems];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"RoundScoreViewPage"];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"RoundScoreViewPage"];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView delegate & datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 22;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    HomeCellHeader *cellHeader = [HomeCellHeader viewFromNib];
    return cellHeader;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _usersArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"EmployeeTasksCell";
    UITableViewCell *cell = nil;
    
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[JHomeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    RoundPlayer *p = [_usersArr objectAtIndex:indexPath.row];
    [(JHomeCell *)cell setValue:p];
    
    return cell;
}

#pragma mark - Private Methods
- (void)setupNavItems {
    UIBarButtonItem *rightAddBtn = [CustomerBarButtonItem createRectBarButtonItemWithTitle:LOCALIZED_DEFAULT_SYSTEM_TABLE(@"ScrollUp")];
    rightAddBtn.target = self;
    rightAddBtn.action = @selector(rightAddBtnClicked);
    self.navigationItem.rightBarButtonItem = rightAddBtn;
    
    if (IS_IOS_5) {
        return;
    }

    UIBarButtonItem *leftBtn = [CustomerBarButtonItem createRectBarButtonItemWithImageUrl:@"share.png" target:self action:@selector(leftBtnClicked)];
    leftBtn.target = self;
    leftBtn.action = @selector(leftBtnClicked);
    self.navigationItem.leftBarButtonItem = leftBtn;
}

- (void)rightAddBtnClicked {
     if (![[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        if (_delegate&&[_delegate respondsToSelector:@selector(removeRange)]) {
            [_delegate performSelector:@selector(removeRange)];
    
        } 
    }else
    
    [self.navigationController dismissModalViewControllerAnimated:YES];
    
    
}

- (void)leftBtnClicked {
    
    [MobClick event:@"RoundScore_event" label:@"shareBtnClicked"];
    
    UIImage *qrimg = nil;
    if (IH_UNDERCOVER_FREE) {
        qrimg = ImageNamed(@"007qrcode_ios_free.png");
    } else {
        qrimg = ImageNamed(@"007qrcode_ios_pay.png");
    }
    
    NSString *message = nil;
    if ([CURRENT_LANGUAGE isEqualToString:@"zh-Hans"]) {
        message = @"《谁是卧底007》风云榜：";
    } else {
        message = @"UnderCover Billboard:";
    }
    
    for (int i = 0; i < _usersArr.count; i++) {
        if (i > 9) {
            break;
        }
        RoundPlayer *p = [_usersArr objectAtIndex:i];
        message = [NSString stringWithFormat:@"%@@%@:%d/%d/%d/%d\n", message, p.name, (i+1), p.victor.integerValue, p.failure.integerValue, p.score.integerValue];
    }
    
    NSArray *activityItems = @[message, qrimg];
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];
    [self presentViewController:activityVC animated:YES completion:nil];
}

- (void)viewDidUnload {
    [self setTableView:nil];
    [super viewDidUnload];
}
@end

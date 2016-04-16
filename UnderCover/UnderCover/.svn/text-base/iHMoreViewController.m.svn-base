//
//  iHSecondViewController.m
//  Journey
//
//  Created by Wayde Sun on 6/27/13.
//  Copyright (c) 2013 iHakula. All rights reserved.
//

#import "iHMoreViewController.h"
#import "JMoreCell.h"
#import "JAboutUsViewController.h"
#import "JFeedbackViewController.h"
#import "JServiceViewController.h"
#import "JABiaoViewController.h"
#import "JProudViewController.h"
#import "JProudDetailViewController.h"
#import "MobClick.h"

@interface iHMoreViewController ()
- (void)gotoABiaoDescription;
- (void)gotoService;
- (void)gotoAboutUs;
- (void)gotoFeedback;
-(void)gotoOurProud;
-(void)showProud:(NSDictionary *)dic;
@end

@implementation iHMoreViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = LOCALIZED_DEFAULT_SYSTEM_TABLE(@"MoreNews");
        [self.tabBarItem setFinishedSelectedImage:ImageNamed(@"Tabbar_Icon_News_Pressed.png") withFinishedUnselectedImage:ImageNamed(@"Tabbar_Icon_News_Normal.png")];
        
        NSString *dataPath = [[NSBundle mainBundle] pathForResource:@"More" ofType:@"plist"];
        NSDictionary *dataDic = [NSDictionary dictionaryWithContentsOfFile:dataPath];
        _moreList = [dataDic objectForKey:@"data"];
    }
    return self;
}
							
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    if (!IH_IS_IPHONE) {
        JAboutVC=[[JAboutUsViewController alloc] initWithNibName:@"JAboutUsViewController_ipad" bundle:nil];
        JFeedVC = [[JFeedbackViewController alloc] initWithNibName:@"JFeedbackViewController_ipad" bundle:nil];
        JSerVC = [[JServiceViewController alloc] initWithNibName:@"JServiceViewController" bundle:nil];
        JABVC = [[JABiaoViewController alloc] initWithNibName:@"JABiaoViewController" bundle:nil];
        JPVC = [[JProudViewController alloc] initWithNibName:@"JProudViewController" bundle:nil];
        JAboutVC.view.frame = CGRectMake(320, 0, 448, 911);
        JFeedVC.view.frame = CGRectMake(320, 0, 448, 911);
        JSerVC.view.frame = CGRectMake(320, 0, 448, 911);
        JABVC.view.frame = CGRectMake(320, 0, 448, 911);
        JPVC.view.frame = CGRectMake(320, 0, 448, 911);
        tempView = JSerVC.view;
        [self.view addSubview:tempView];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"MoreViewPage"];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"MoreViewPage"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setTheTableView:nil];
    [super viewDidUnload];
}

#pragma mark - UITableView delegate & datasource
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.row) {
        case 0:
            [self gotoABiaoDescription];
            [MobClick event:@"More_event" label:@"GameRules"];
            break;
        case 1:
            [self gotoService];
            [MobClick event:@"More_event" label:@"WordsManagement"];
            break;
        case 2:
            [self gotoFeedback];
            [MobClick event:@"More_event" label:@"Feedback"];
            break;
        case 3:
            [self gotoAboutUs];
            [MobClick event:@"More_event" label:@"AboutUS"];
            break;
        case 4:
            [self gotoOurProud];
            [MobClick event:@"More_event" label:@"OurProud"];
        default:
            break;
    }    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_moreList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"SightSpotHomeCell";
    UITableViewCell *cell = nil;
    
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[JMoreCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    }
    
    NSDictionary *service = [_moreList objectAtIndex:indexPath.row];
    [(JMoreCell *)cell setValues:service];
    
    return cell;
}

#pragma mark - Private Methods
- (void)gotoABiaoDescription {
  
    if (!IH_IS_IPHONE) {
        [tempView removeFromSuperview];
        tempView = JABVC.view;
        [self.view addSubview:tempView];
        return;
    }
    JABiaoViewController *vc = [[JABiaoViewController alloc] initWithNibName:@"JABiaoViewController" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)gotoAboutUs {
    
    if (!IH_IS_IPHONE) {
        [tempView removeFromSuperview];
        tempView = JAboutVC.view;
        [self.view addSubview:tempView];
        return;
    }
    JAboutUsViewController *vc = [[JAboutUsViewController alloc] initWithNibName:@"JAboutUsViewController_iphone" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)gotoFeedback {
    
    if (!IH_IS_IPHONE) {
        [tempView removeFromSuperview];
        JFeedVC.delegate = self;
        tempView = JFeedVC.view;
        [self.view addSubview:tempView];
        return;
    }
    
    JFeedbackViewController *vc = [[JFeedbackViewController alloc] initWithNibName:@"JFeedbackViewController_iphone" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)gotoService {
    
    if (!IH_IS_IPHONE) {
         [tempView removeFromSuperview];
        tempView = JSerVC.view;
        [self.view addSubview:tempView];
        return;
    }
    JServiceViewController *vc = [[JServiceViewController alloc] initWithNibName:@"JServiceViewController" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)gotoOurProud
{
    if (!IH_IS_IPHONE) {
         [tempView removeFromSuperview];

        tempView = JPVC.view;
        
        JPVC.delegate=self;
        [self.view addSubview:tempView];
        return;
    }
    JProudViewController *vc = [[JProudViewController alloc] initWithNibName:@"JProudViewController" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];

}
-(void)showProud:(NSDictionary *)dic
{
    JProudDetailViewController *vc=[[JProudDetailViewController alloc]initWithNibName:@"JProudDetailViewController_ipad" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
    [vc setDic:dic];
    
}
@end

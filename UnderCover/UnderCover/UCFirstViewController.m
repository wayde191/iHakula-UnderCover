//
//  UCFirstViewController.m
//  UnderCover
//
//  Created by Wayde Sun on 7/16/13.
//  Copyright (c) 2013 iHakula. All rights reserved.
//

#import "UCFirstViewController.h"
#import "UCChoosePlayerViewController.h"
#import "CustomerNavigationController.h"
#import "Player.h"
#import "UCGameModel.h"
#import "UCUserView.h"
#import "UCGameBeginViewController.h"
#import "MobClick.h"

@interface UCFirstViewController ()
- (void)setupBtns;
- (void)drawPlayers;
- (void)setupSuggestedPlayerNumber;
- (void)setupSystemWordsUseage;
- (void)updateStatusOfStartGameBtn;

- (void)updateScrollViewContentSize;
-(void)drawPlayersIpad;
- (void)setupAds;
-(void)removeNav;
@end

@implementation UCFirstViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = LOCALIZED_DEFAULT_SYSTEM_TABLE(@"WhoIsSpy");
        [self.tabBarItem setFinishedSelectedImage:ImageNamed(@"Tabbar_Icon_Events_Pressed.png") withFinishedUnselectedImage:ImageNamed(@"Tabbar_Icon_Events_Normal.png")];
        [self.tabBarItem setTitle:LOCALIZED_DEFAULT_SYSTEM_TABLE(@"GameEvents")];
        _dm = [[UCGameModel alloc] init];
        _dm.delegate = self;
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
            isIphone = YES;
        } else {
            isIphone = NO;
        }
    }
    return self;
}
							
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupBtns];
    [self setupSystemWordsUseage];
    if (IH_UNDERCOVER_FREE) {
        [self setupAds];
    }
    
    [self updateScrollViewContentSize];
    untouchView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 768, 911)];
    untouchView.backgroundColor = [UIColor clearColor];
    untouchView.tag = 101;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    _dm.delegate = self;
    [self setupSystemWordsUseage];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"HomeViewPage"];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"HomeViewPage"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    [self setChooseGamePlayerBtn:nil];
    [self setUsersView:nil];
    [self setStepView:nil];
    [self setNumberSuggestedLabel:nil];
    [self setWhiteBoardPlayerNumberLabel:nil];
    [self setUnderCoverPlayerNumberLabel:nil];
    [self setReduceWhiteBoardNumberBtn:nil];
    [self setIncreaseWhiteBoardNumberBtn:nil];
    [self setReduceUnderCoverNumberBtn:nil];
    [self setIncreaseUnderCoverNumberBtn:nil];
    [self setUsedVocabularyLabel:nil];
    [self setTotalVocabularyLabel:nil];
    [self setRandomSystemBtn:nil];
    [self setHandInputVocabularyView:nil];
    [self setWord1TextField:nil];
    [self setWord2TextField:nil];
    [self setScrollView:nil];
    [self setStartGameBtn:nil];
    [self setGameStartView:nil];
    [self setEmptyPlayerLabel:nil];
    [super viewDidUnload];
}

- (void)onPlayerSelected:(NSArray *)playersArr {
    _dm.selectedPlayersArr = [NSMutableArray arrayWithArray:playersArr];
    [_dm setupRoundScore];
    
    if (_dm.selectedPlayersArr.count) {
        [_chooseGamePlayerBtn setTitle:LOCALIZED_DEFAULT_SYSTEM_TABLE(@"UpdatePlayers") forState:UIControlStateNormal];
        [_chooseGamePlayerBtn setTitle:LOCALIZED_DEFAULT_SYSTEM_TABLE(@"UpdatePlayers") forState:UIControlStateHighlighted];
        _emptyPlayerLabel.hidden = YES;
    } else {
        [_chooseGamePlayerBtn setTitle:LOCALIZED_DEFAULT_SYSTEM_TABLE(@"ChoosePlayers") forState:UIControlStateNormal];
        [_chooseGamePlayerBtn setTitle:LOCALIZED_DEFAULT_SYSTEM_TABLE(@"ChoosePlayers") forState:UIControlStateHighlighted];
        _emptyPlayerLabel.hidden = NO;
    }
    if (!isIphone) {
        [self drawPlayersIpad];
        [self updateStatusOfStartGameBtn];
        return;
    }
    
    [self drawPlayers];
    [self updateStatusOfStartGameBtn];
}

- (IBAction)onChooseGamePlayerBtnClicked:(id)sender {
    UCChoosePlayerViewController *vc = [[UCChoosePlayerViewController alloc] initWithNibName:@"UCChoosePlayerViewController" bundle:nil];
    vc.delegate = self;
    vc.chosePlayersArr = _dm.selectedPlayersArr;
    nav = [CustomerNavigationController createSystemNavigationController:vc];
    
    if (![[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
    nav.view.frame = CGRectMake(768, 0, 320, 911);
    nav.delegate=self;
    nav.navigationController.delegate=self;
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 1, 911)];
        lineView.backgroundColor = [UIColor grayColor];
        [nav.view addSubview:lineView];
    [self.view addSubview:untouchView];
    [self.view addSubview:nav.view];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.8f];
    [UIView setAnimationBeginsFromCurrentState:YES];
    nav.view.origin = CGPointMake(448, 0);
    [UIView commitAnimations];
    }else
        [self.navigationController presentModalViewController:nav animated:YES];
}

-(void)removeChoose
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.8f];
    [UIView setAnimationBeginsFromCurrentState:YES];
    nav.view.origin = CGPointMake(768, 0);
    [UIView setAnimationDidStopSelector:@selector(removeNav)];
    [UIView commitAnimations];
     [untouchView removeFromSuperview];

}
-(void)removeNav
{
    [nav.view removeFromSuperview];
    [untouchView removeFromSuperview];
    

}
- (IBAction)onReduceWhiteBoardNumberBtnClicked:(id)sender {
    NSInteger num = [_whiteBoardPlayerNumberLabel.text integerValue];
    NSInteger undercoverNum = [_underCoverPlayerNumberLabel.text integerValue];
    num--;
    
    _increaseWhiteBoardNumberBtn.enabled = YES;
    _reduceWhiteBoardNumberBtn.enabled = YES;
    
    if (0 == num) {
        _reduceWhiteBoardNumberBtn.enabled = NO;
    } else {
        _reduceWhiteBoardNumberBtn.enabled = YES;
    }
    
    if (1 == num + undercoverNum) {
        _reduceUnderCoverNumberBtn.enabled = NO;
        _reduceWhiteBoardNumberBtn.enabled = NO;
    }
    
    if (num + undercoverNum == _dm.selectedPlayersArr.count) {
        _increaseWhiteBoardNumberBtn.enabled = NO;
        _increaseUnderCoverNumberBtn.enabled = NO;
    } else {
        _increaseWhiteBoardNumberBtn.enabled = YES;
        _increaseUnderCoverNumberBtn.enabled = YES;
    }
    
    _whiteBoardPlayerNumberLabel.text = [NSString stringWithFormat:@"%d", num];
}

- (IBAction)onIncreaseWhiteBoardNumberBtnClicked:(id)sender {
    NSInteger num = [_whiteBoardPlayerNumberLabel.text integerValue];
    NSInteger undercoverNum = [_underCoverPlayerNumberLabel.text integerValue];
    num++;
    
    if (num + undercoverNum > 1) {
        if (undercoverNum > 0) {
            _reduceUnderCoverNumberBtn.enabled = YES;
        }
        if (num > 0) {
            _reduceWhiteBoardNumberBtn.enabled = YES;
        }
    }
    
    _increaseWhiteBoardNumberBtn.enabled = YES;
    _reduceWhiteBoardNumberBtn.enabled = YES;
    
    if (num + undercoverNum == _dm.selectedPlayersArr.count) {
        _increaseWhiteBoardNumberBtn.enabled = NO;
        _increaseUnderCoverNumberBtn.enabled = NO;
    } else {
        _increaseWhiteBoardNumberBtn.enabled = YES;
        _increaseUnderCoverNumberBtn.enabled = YES;
    }
    
    _whiteBoardPlayerNumberLabel.text = [NSString stringWithFormat:@"%d", num];
}

- (IBAction)onReduceUnderCoverNumberBtnClicked:(id)sender {
    NSInteger num = [_whiteBoardPlayerNumberLabel.text integerValue];
    NSInteger undercoverNum = [_underCoverPlayerNumberLabel.text integerValue];
    undercoverNum--;
    
    _increaseUnderCoverNumberBtn.enabled = YES;
    _reduceUnderCoverNumberBtn.enabled = YES;
    
    if (0 == undercoverNum) {
        _reduceUnderCoverNumberBtn.enabled = NO;
    } else {
        _reduceUnderCoverNumberBtn.enabled = YES;
    }
    
    if (1 == num + undercoverNum) {
        _reduceUnderCoverNumberBtn.enabled = NO;
        _reduceWhiteBoardNumberBtn.enabled = NO;
    }
    
    if (num + undercoverNum == _dm.selectedPlayersArr.count) {
        _increaseWhiteBoardNumberBtn.enabled = NO;
        _increaseUnderCoverNumberBtn.enabled = NO;
    } else {
        _increaseWhiteBoardNumberBtn.enabled = YES;
        _increaseUnderCoverNumberBtn.enabled = YES;
    }
    
    _underCoverPlayerNumberLabel.text = [NSString stringWithFormat:@"%d", undercoverNum];
}

- (IBAction)onIncreaseUnderCoverNumberBtnClicked:(id)sender {
    
    NSInteger num = [_whiteBoardPlayerNumberLabel.text integerValue];
    NSInteger undercoverNum = [_underCoverPlayerNumberLabel.text integerValue];
    undercoverNum++;
    
    if (num + undercoverNum > 1) {
        if (undercoverNum > 0) {
            _reduceUnderCoverNumberBtn.enabled = YES;
        }
        if (num > 0) {
            _reduceWhiteBoardNumberBtn.enabled = YES;
        }
    }
    
    _increaseUnderCoverNumberBtn.enabled = YES;
    _reduceUnderCoverNumberBtn.enabled = YES;
    
    if (num + undercoverNum == _dm.selectedPlayersArr.count) {
        _increaseWhiteBoardNumberBtn.enabled = NO;
        _increaseUnderCoverNumberBtn.enabled = NO;
    } else {
        _increaseWhiteBoardNumberBtn.enabled = YES;
        _increaseUnderCoverNumberBtn.enabled = YES;
    }
    
    _underCoverPlayerNumberLabel.text = [NSString stringWithFormat:@"%d", undercoverNum];
}

- (IBAction)onRandomSystemBtnClicked:(id)sender {
    _randomSystemBtn.selected = !_randomSystemBtn.selected;
    if (_randomSystemBtn.selected) {
        [UIView animateWithDuration:.3 animations:^(){
            _handInputVocabularyView.top = -105;
        }];
    } else {
        [UIView animateWithDuration:.3 animations:^(){
            _handInputVocabularyView.top = 0;
        }];
    }
    
    [self updateStatusOfStartGameBtn];
    [self updateScrollViewContentSize];
}

- (IBAction)onGameBeginBtnClicked:(id)sender {
    if (_dm.selectedPlayersArr.count < 4) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:LOCALIZED_DEFAULT_SYSTEM_TABLE(@"WarmServiceTitle") message:LOCALIZED_DEFAULT_SYSTEM_TABLE(@"LessThanFourPeople") selectedBlock:^(NSInteger index){
        } cancelButtonTitle:nil otherButtonTitles:LOCALIZED_DEFAULT_SYSTEM_TABLE(@"ok")];
        [alert show];
        
        [self showMessage:LOCALIZED_DEFAULT_SYSTEM_TABLE(@"LessThanFourPeople")];
        [self performSelector:@selector(hideMessage) withObject:nil afterDelay:1.3];
        return;
    }
    
    if (_wordOutOfUseage) {
        if (_randomSystemBtn.selected) {
            [self showAlertMessage:LOCALIZED_DEFAULT_SYSTEM_TABLE(@"WordsUseOut")];
            return;
        }
    }
    ///////
//    UCGameModel *_dm2 = [[UCGameModel alloc]init];
//    _dm2.selectedPlayersArr = _dm.selectedPlayersArr;
    _dm.personCheckedCount = 0;
    _dm.roundChanged = YES;
    /////////
    _dm.whiteBoardPlayerNumber = _whiteBoardPlayerNumberLabel.text.integerValue;
    _dm.underCoverPlayerNumber = _underCoverPlayerNumberLabel.text.integerValue;
    _dm.systemAutoSelectingWords = _randomSystemBtn.selected;
    _dm.words1 = _word1TextField.text;
    _dm.words2 = _word2TextField.text;
    UCGameBeginViewController *vc;
    [_dm setupRoundScore];
    if (!isIphone) {
        vc = [[UCGameBeginViewController alloc] initWithNibName:@"UCGameBeginViewController_ipad" bundle:nil];
    }else
    vc = [[UCGameBeginViewController alloc] initWithNibName:@"UCGameBeginViewController_iphone" bundle:nil];
    vc.dm = _dm;
    vc.dm.delegate = vc;
    [self.navigationController pushViewController:vc animated:YES];
    
    [MobClick event:@"Mac_Category" label:@"onGameBeginBtnClicked"];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if ([string isEqualToString:@"\n"]) {
        [textField resignFirstResponder];
    }
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    [_scrollView setContentOffset:CGPointMake(0, _stepView.top + _gameStartView.top) animated:YES];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [self updateStatusOfStartGameBtn];
}

#pragma mark - Private Methods
- (void)setupBtns {
    // Choose player buttons
    UIImage *choosePlayerBg = ImageNamed(@"BarButtonItem_Normal.png");
    choosePlayerBg = [choosePlayerBg stretchableImageWithLeftCapWidth:8 topCapHeight:0];
    [_chooseGamePlayerBtn setBackgroundImage:choosePlayerBg forState:UIControlStateNormal];

    UIImage *choosePlayerHighlightedBg = ImageNamed(@"BarButtonItem_Pressed.png");
    choosePlayerHighlightedBg = [choosePlayerHighlightedBg stretchableImageWithLeftCapWidth:8 topCapHeight:0];
    [_chooseGamePlayerBtn setBackgroundImage:choosePlayerHighlightedBg forState:UIControlStateHighlighted];
}

- (void)drawPlayers {
    CGFloat top = 0;
    CGFloat left = 0;
    
    _usersView.alpha = 0.0;
    [_usersView removeAllSubviews];
    for (int i = 0; i < _dm.selectedPlayersArr.count; i++) {
        Player *p = [_dm.selectedPlayersArr objectAtIndex:i];
        UCUserView *ucview = [UCUserView viewFromNib];
        [ucview setValues:p byIndex:(i+1)];
        
        if (left + ucview.width + 4 > _usersView.width) {
            left = 0;
            top = top + ucview.height + 2;
        }
        
        ucview.left = left;
        ucview.top = top;
        [_usersView addSubview:ucview];
        
        left = left + ucview.width + 4;
    }
    
    [UIView animateWithDuration:.3 animations:^(){
        if (_dm.selectedPlayersArr.count) {
            _usersView.height = top + 30 + 4;
        } else {
            _usersView.height = 0;
        }
        
        _stepView.top = _usersView.top + _usersView.height;
    } completion:^(BOOL animationDone){
        if (animationDone) {
            [UIView animateWithDuration:.3 animations:^(){
                _usersView.alpha = 1.0;
                [self setupSuggestedPlayerNumber];
                [self updateScrollViewContentSize];
            }];
        }
    }];
}
-(void)drawPlayersIpad
{
    CGFloat top = 0;
    CGFloat left = 0;
    
    _usersView.alpha = 0.0;
    [_usersView removeAllSubviews];
    for (int i = 0; i < _dm.selectedPlayersArr.count; i++) {
        Player *p = [_dm.selectedPlayersArr objectAtIndex:i];
        UCUserView *ucview = [UCUserView viewFromNib];
        [ucview setValues:p byIndex:(i+1)];
        
        if (left + ucview.width + 8 > _usersView.width) {
            left = 0;
            top = top + ucview.height + 5;
        }
        
        ucview.left = left;
        ucview.top = top;
        [_usersView addSubview:ucview];
        
        left = left + ucview.width + 8;
    }
    
    [UIView animateWithDuration:.3 animations:^(){
        if (_dm.selectedPlayersArr.count) {
            _usersView.height = top + 30 + 8;
        } else {
            _usersView.height = 0;
        }
        
        _stepView.top = _usersView.top + _usersView.height+40;
    } completion:^(BOOL animationDone){
        if (animationDone) {
            [UIView animateWithDuration:.3 animations:^(){
                _usersView.alpha = 1.0;
                [self setupSuggestedPlayerNumber];
                [self updateScrollViewContentSize];
            }];
        }
    }];

}
- (void)setupSuggestedPlayerNumber {
    NSInteger allPlayersNumber = _dm.selectedPlayersArr.count;
    NSInteger suggestedNumber = (allPlayersNumber / 5) + ((allPlayersNumber % 5) > 0 ? 1 : 0);
    
    if (suggestedNumber > 0) {
        _numberSuggestedLabel.text = [NSString stringWithFormat:@"%@%d", LOCALIZED_DEFAULT_SYSTEM_TABLE(@"FirstViewSuggestInfo"), suggestedNumber];
        if (suggestedNumber > 1) {
            _whiteBoardPlayerNumberLabel.text = @"1";
            _reduceWhiteBoardNumberBtn.enabled = YES;
            _increaseWhiteBoardNumberBtn.enabled = YES;
            
            _underCoverPlayerNumberLabel.text = [NSString stringWithFormat:@"%d", suggestedNumber - 1];
            _reduceUnderCoverNumberBtn.enabled = YES;
            _increaseUnderCoverNumberBtn.enabled = YES;
            
        } else {
            _whiteBoardPlayerNumberLabel.text = @"0";
            _reduceWhiteBoardNumberBtn.enabled = NO;
            _increaseWhiteBoardNumberBtn.enabled = YES;
            
            _underCoverPlayerNumberLabel.text = @"1";
            _reduceUnderCoverNumberBtn.enabled = NO;
            _increaseUnderCoverNumberBtn.enabled = YES;
        }
    }
}

- (void)updateScrollViewContentSize {
    _scrollView.contentSize = CGSizeMake(320, _stepView.top + _gameStartView.top + _handInputVocabularyView.top + _startGameBtn.top + _startGameBtn.height + 10 + 50);
}

- (void)setupSystemWordsUseage {
    NSInteger systemWordsCount = [appDelegate.cdataManager getTheNumberOfSystemWords];
    NSInteger usedWordsCount = [appDelegate.cdataManager getTheNumberOfUsuedSystemWords];
    
    _usedVocabularyLabel.text = [NSString stringWithFormat:@"%d", usedWordsCount];
    _totalVocabularyLabel.text = [NSString stringWithFormat:@"%d", systemWordsCount];
    
    if (usedWordsCount >= systemWordsCount) {
        _wordOutOfUseage = YES;
    }
    
}

- (void)updateStatusOfStartGameBtn {
    if (_dm.selectedPlayersArr.count &&
        (_randomSystemBtn.selected ||
         (![_word1TextField.text isEqualToString:@""] && ![_word2TextField.text isEqualToString:@""]))) {
        _startGameBtn.enabled = YES;
    } else {
        _startGameBtn.enabled = NO;
    }
}

- (void)setupAds {
    CGFloat y = 0;
    if (IH_IS_IPHONE) {
        y = IS_IPHONE_5 ? (IPHONE_SCREEN_5_HEIGHT - CGSizeFromGADAdSize(kGADAdSizeSmartBannerPortrait).height - 113) : (IPHONE_SCREEN_HEIGHT - CGSizeFromGADAdSize(kGADAdSizeSmartBannerPortrait).height - 113);
    } else {
        y = IPAD_SCREEN_HEIGHT - CGSizeFromGADAdSize(kGADAdSizeSmartBannerPortrait).height - 113;
    }
    
    CGPoint origin = CGPointMake(0.0, y);
    bannerView_ = [[GADBannerView alloc]
                   initWithAdSize:kGADAdSizeSmartBannerPortrait
                   origin:origin];
        
    bannerView_.adUnitID = @"a151f0c27b9b538";
    bannerView_.delegate = self;
    
    bannerView_.rootViewController = self;
    bannerView_.left = 1000;
    [self.view addSubview:bannerView_];
    
    GADRequest *request = [GADRequest request];
    request.additionalParameters =  [NSMutableDictionary
                                     dictionaryWithObjectsAndKeys:
                                     @"F0F0F0", @"color_bg",
                                     @"696969", @"color_bg_top",
                                     @"000000", @"color_border",
                                     @"FF0000", @"color_link",
                                     @"232323", @"color_text",
                                     @"00FF00", @"color_url",
                                     nil];
    [bannerView_ loadRequest:request];
}

#pragma mark - GADBannerViewDelegate

- (void)adViewDidReceiveAd:(GADBannerView *)bannerView {
    [UIView animateWithDuration:0.3 animations:^(){
        bannerView_.left = 0;
    }];
}
- (void)adView:(GADBannerView *)bannerView didFailToReceiveAdWithError:(GADRequestError *)error {
    bannerView_.left = 1000;
}

- (void)adViewWillPresentScreen:(GADBannerView *)bannerView {}
- (void)adViewDidDismissScreen:(GADBannerView *)bannerView {}
- (void)adViewWillLeaveApplication:(GADBannerView *)bannerView {}

@end

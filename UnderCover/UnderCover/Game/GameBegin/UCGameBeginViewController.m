//
//  UCGameBeginViewController.m
//  UnderCover
//
//  Created by Wayde Sun on 7/19/13.
//  Copyright (c) 2013 iHakula. All rights reserved.
//

#define GAME_LIFE_BAR_WIDTH                 90.0
#define PLAYER_COLUMN_NUMBER                3
#define PLAYER_COLUMN_NUMBER_PAD            5
#define GAME_LIFE_BAR_WIDTH_IPAD                 180.0
#import "UCGameBeginViewController.h"
#import "UCGameModel.h"
#import "UCUserCardView.h"
#import "CustomerBarButtonItem.h"
#import "Player.h"
#import "RoundPlayer.h"
#import "UCRoundScoreViewController.h"
#import "CustomerNavigationController.h"
#import "MobClick.h"

@interface UCGameBeginViewController ()
- (void)drawPlayers;
- (void)setupLeftBarItem;
- (void)setupLifeBar;
- (void)updateLifeBar;
- (void)updateGameInfo;
- (void)checkGameStatus;
- (void)leftBarBtnClicked;
- (void)rightBarBtnClicked;
- (void)gameStop;
- (void)gamePlaying;
- (void)gameEnd;
- (void)killPlayerAtIndex:(UCUserCardView *)playerCard;
- (void)updatePlayerScore;
- (void)restoreDataModel;
- (void)restoreAllPlayerCards;
- (void)player:(Player *)p winWithScore:(NSInteger)score;
- (void)player:(Player *)p loseWithScore:(NSInteger)score;
- (void)showAllCardRole;
- (void)setupBtns;
-(void)removeRange;
- (UIImage *)getRoleImagesByName:(NSString *)roleName;

- (void)setupAds;
@end

@implementation UCGameBeginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = LOCALIZED_DEFAULT_SYSTEM_TABLE(@"GameBegin");
        _gameStatus = e_GAME_STATUS_NOT_START;
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
        {
            IsIphone = YES;
        }else
            IsIphone = NO;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self updateGameInfo];
    [self setupLifeBar];
    [self drawPlayers];
    [self setupLeftBarItem];
    [self setupBtns];
    if (IH_UNDERCOVER_FREE) {
        [self setupAds];
    }
    untouchView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 768, 911)];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"GameBeginViewPage"];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"GameBeginViewPage"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Public Methods
- (IBAction)onScoreListBtnClicked:(id)sender {
      
     UCRoundScoreViewController *vc = [[UCRoundScoreViewController alloc] initWithNibName:@"UCRoundScoreViewController" bundle:nil];
    
    [MobClick event:@"GameBeginEvent" label:@"onScoreListBtnClicked"];
    
    if (!IsIphone)
    {

        vc.usersArr = [_dm getRoundScoreLsit];
        vc.delegate = self;
        nav = [CustomerNavigationController createSystemNavigationController:vc];
        nav.view.frame = CGRectMake(768, 0, 320, 911);
        nav.delegate=self;
        nav.navigationController.delegate=self;
        [self.view addSubview:untouchView];
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 2, 1004)];
        lineView.backgroundColor = [UIColor grayColor];
        [nav.view addSubview:lineView];
        [self.view addSubview:nav.view];
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:0.8f];
        [UIView setAnimationBeginsFromCurrentState:YES];
        nav.view.origin = CGPointMake(448, 0);
        [UIView commitAnimations];
    }else{
       
        vc.usersArr = [_dm getRoundScoreLsit];
        UINavigationController *nav = [CustomerNavigationController createSystemNavigationController:vc];
        [self.navigationController presentModalViewController:nav animated:YES];
    
    }
    
    

}
-(void)removeRange
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
- (void)switchToSystemAutoSelectingWords {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:LOCALIZED_DEFAULT_SYSTEM_TABLE(@"WarmServiceTitle") message:LOCALIZED_DEFAULT_SYSTEM_TABLE(@"WordsFilledByHandSwitchToRandom") selectedBlock:^(NSInteger index){
        [_dm setToSystemAutoSelectingWords];
    } cancelButtonTitle:LOCALIZED_DEFAULT_SYSTEM_TABLE(@"cancel") otherButtonTitles:LOCALIZED_DEFAULT_SYSTEM_TABLE(@"ChooseWordsByRandom")];
    [alert show];
}

- (void)onPlayerCardClicked:(UCUserCardView *)playerCard {
    if (_gameStatus == e_GAME_STATUS_DRAW_LOTS) {
        if (playerCard.backRoleView.hidden) {
            NSString *msg = [NSString stringWithFormat:LOCALIZED_DEFAULT_SYSTEM_TABLE(@"OnlyPersonSelfCanCheck"), playerCard.aplayer.name];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:LOCALIZED_DEFAULT_SYSTEM_TABLE(@"WarmServiceTitle") message:msg selectedBlock:^(NSInteger index){
                if (1 == index) {
                    [UIView animateWithDuration:.8 animations:^(){
                        playerCard.backRoleView.hidden = NO;
                        playerCard.roleLabel.text = [_dm.playersRolesArr objectAtIndex:playerCard.tag - 1];
                        if ([playerCard.roleLabel.text isEqualToString:_dm.words1]) {
                            playerCard.role = e_PLAYER_ROLE_NOMALPERSION;
                        } else if ([playerCard.roleLabel.text isEqualToString:_dm.words2]) {
                            playerCard.role = e_PLAYER_ROLE_UNDERCOVER;
                        } else {
                            playerCard.role = e_PLAYER_ROLE_WHITEBOARD;
                        }
                        [playerCard.drawLotsIndicator startAnimating];
                        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
                        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:playerCard cache:YES];
                    } completion:^(BOOL finished){
                        if (finished) {
                            [UIView animateWithDuration:.3 animations:^(){
                                [playerCard.drawLotsIndicator stopAnimating];
                                playerCard.drawLotsView.hidden = YES;
                            }];
                        }
                    }];
                }
            } cancelButtonTitle:LOCALIZED_DEFAULT_SYSTEM_TABLE(@"NotMyself") otherButtonTitles:LOCALIZED_DEFAULT_SYSTEM_TABLE(@"IsMyself")];
            [alert show];
            
        } else {
            [UIView animateWithDuration:.8 animations:^(){
                playerCard.backRoleView.hidden = YES;
                if (playerCard.checkedLabel.hidden) {
                    playerCard.checkedLabel.hidden = NO;
                    _dm.personCheckedCount++;
                }
                [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
                [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:playerCard cache:YES];
            } completion:^(BOOL finished){
                if (finished) {
                    if (_dm.personCheckedCount == _dm.selectedPlayersArr.count) {
                        [self gamePlaying];
                    }
                }
            }];
        }
    } else if (_gameStatus == e_GAME_STATUS_GOING
               || _gameStatus == e_GAME_STATUS_GOING_LAST_ROUND) {
        NSString *msg = [NSString stringWithFormat:LOCALIZED_DEFAULT_SYSTEM_TABLE(@"SureToKillSomePlayer"), playerCard.aplayer.name];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:LOCALIZED_DEFAULT_SYSTEM_TABLE(@"InfoMessage") message:msg selectedBlock:^(NSInteger index){
            if (1 == index) {
                [self killPlayerAtIndex:playerCard];
                
                if (_gameStatus == e_GAME_STATUS_GOING_LAST_ROUND) {
                    if (_dm.underCoverPlayerLivingNumber > 0) {
                        _gameResult = e_GAME_RESULTS_UNDERCOVER_WIN;
                    } else if (_dm.whiteBoardPlayerLivingNumber > 0) {
                        _gameResult = e_GAME_RESULTS_WHITEBOARD_WIN;
                    } else {
                        _gameResult = e_GAME_RESULTS_NORMALPERSON_WIN;
                    }
                    [self gameEnd];
                } else {
                    [self checkGameStatus];
                }
            }
        } cancelButtonTitle:LOCALIZED_DEFAULT_SYSTEM_TABLE(@"cancel") otherButtonTitles:LOCALIZED_DEFAULT_SYSTEM_TABLE(@"ok")];
        [alert show];
    }
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (2 != buttonIndex) {
        if (0 == buttonIndex) {
            _dm.roundChanged = NO;
            [MobClick event:@"GameBeginEvent" label:@"roundChanged"];
        } else if (1 == buttonIndex) {
            _dm.roundChanged = YES;
            [MobClick event:@"GameBeginEvent" label:@"roundNotChanged"];
        }
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - Private Methods
- (void)setupBtns {
    // Choose player buttons
    UIImage *choosePlayerBg = ImageNamed(@"BarButtonItem_Normal.png");
    choosePlayerBg = [choosePlayerBg stretchableImageWithLeftCapWidth:8 topCapHeight:0];
    [_scoreListBtn setBackgroundImage:choosePlayerBg forState:UIControlStateNormal];
    
    UIImage *choosePlayerHighlightedBg = ImageNamed(@"BarButtonItem_Pressed.png");
    choosePlayerHighlightedBg = [choosePlayerHighlightedBg stretchableImageWithLeftCapWidth:8 topCapHeight:0];
    [_scoreListBtn setBackgroundImage:choosePlayerHighlightedBg forState:UIControlStateHighlighted];
}

- (void)gameStop {
    _gameStatus = e_GAME_STATUS_NOT_START;
    [self.navigationItem.rightBarButtonItem setTitle:LOCALIZED_DEFAULT_SYSTEM_TABLE(@"GameStart")];
    [self updateGameInfo];
    [self setupLifeBar];
    [self restoreAllPlayerCards];
    [self restoreDataModel];
}

- (void)gamePlaying {
    _gameStatus = e_GAME_STATUS_GOING;
    [_dm setupGameBeginInfo];
    
    [self updateGameInfo];
    NSString *startUserName = [_dm getFirstRoundStartPlayerName];
    NSString *msg = [NSString stringWithFormat:LOCALIZED_DEFAULT_SYSTEM_TABLE(@"GameBeganAndSomeoneTalkFirst"), startUserName];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:LOCALIZED_DEFAULT_SYSTEM_TABLE(@"WarmServiceTitle") message:msg selectedBlock:^(NSInteger index){} cancelButtonTitle:nil otherButtonTitles:LOCALIZED_DEFAULT_SYSTEM_TABLE(@"ok")];
    [alert show];
    
}

- (void)gameEnd {
    _gameStatus = e_GAME_STATUS_END;
    [self.navigationItem.rightBarButtonItem setTitle:LOCALIZED_DEFAULT_SYSTEM_TABLE(@"GameStart")];
    
    [self updateGameInfo];
    [self updatePlayerScore];
    [self showAllCardRole];
    [self restoreDataModel];
}

- (void)drawPlayers {
    
    NSInteger columnNum = IH_IS_IPHONE ? PLAYER_COLUMN_NUMBER : PLAYER_COLUMN_NUMBER_PAD;
    
    [_usersView removeAllSubviews];
    for (int i = 0; i < _dm.selectedPlayersArr.count; i++) {
        Player *p = [_dm.selectedPlayersArr objectAtIndex:i];
        UCUserCardView *ucview = [UCUserCardView viewFromNib];
        ucview.delegate = self;
        ucview.tag = i + 1;
        [ucview setValues:p byIndex:(i+1)];
        
        NSInteger row = (i / columnNum) + 1;
        NSInteger column = (i + 1) % columnNum ==  0 ? columnNum : (i + 1) % columnNum;
        
        CGFloat top = 10 + (row - 1) * (ucview.height + 4);
        CGFloat left = 3 + (column - 1) * (ucview.width + 4);
        if (!IH_IS_IPHONE) {
             top = 10 + (row - 1) * (ucview.height + 10);
             left = 15 + (column - 1) * (ucview.width + 8);
            
        }
       
        ucview.left = left;
        ucview.top = top;
        [_usersView addSubview:ucview];        
    }
    
    UCUserCardView *ucview = [UCUserCardView viewFromNib];
    CGFloat usersViewHeight = 3 + (_dm.selectedPlayersArr.count / columnNum + 1) * (ucview.height + 4) + 10;
    _usersView.height = usersViewHeight;
    _scrollView.contentSize = CGSizeMake(320,  _usersView.top + usersViewHeight + 20 + 50);
    if (!IH_IS_IPHONE) {
        _scrollView.contentSize = CGSizeMake(768,  _usersView.top + usersViewHeight + 20 + 50);
    }
}

- (void)setupLeftBarItem {
    UIBarButtonItem *leftDoneBtn = [CustomerBarButtonItem createGoBackItemWithTitle:LOCALIZED_DEFAULT_SYSTEM_TABLE(@"ReConfigureGame")];
    leftDoneBtn.target = self;
    leftDoneBtn.action = @selector(leftBarBtnClicked);
    self.navigationItem.leftBarButtonItem = leftDoneBtn;
    
    UIBarButtonItem *rightAddBtn = [CustomerBarButtonItem createRectBarButtonItemWithTitle:LOCALIZED_DEFAULT_SYSTEM_TABLE(@"GameStart")];
    rightAddBtn.target = self;
    rightAddBtn.action = @selector(rightBarBtnClicked);
    self.navigationItem.rightBarButtonItem = rightAddBtn;
}

- (void)leftBarBtnClicked {
    UIActionSheet *actionSheet = nil;
    if (IH_IS_IPHONE) {
        actionSheet = [[UIActionSheet alloc] initWithTitle:LOCALIZED_DEFAULT_SYSTEM_TABLE(@"GoBackAndSetGames")
                                                             delegate:self
                                                    cancelButtonTitle:LOCALIZED_DEFAULT_SYSTEM_TABLE(@"cancel")
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:LOCALIZED_DEFAULT_SYSTEM_TABLE(@"CurrentRoundSetting"), LOCALIZED_DEFAULT_SYSTEM_TABLE(@"NewRoundSetting"), nil];
    } else {
        actionSheet = [[UIActionSheet alloc] initWithTitle:LOCALIZED_DEFAULT_SYSTEM_TABLE(@"GoBackAndSetGames")
                                                  delegate:self
                                         cancelButtonTitle:LOCALIZED_DEFAULT_SYSTEM_TABLE(@"cancel")
                                    destructiveButtonTitle:nil
                                         otherButtonTitles:LOCALIZED_DEFAULT_SYSTEM_TABLE(@"CurrentRoundSetting"), LOCALIZED_DEFAULT_SYSTEM_TABLE(@"NewRoundSetting"), LOCALIZED_DEFAULT_SYSTEM_TABLE(@"cancel"), nil];
    }
    
    self.view.clipsToBounds = YES;
    [actionSheet showInView:appDelegate.window];
}

- (void)rightBarBtnClicked {
    
    if (_gameStatus == e_GAME_STATUS_NOT_START
        || _gameStatus == e_GAME_STATUS_END) {
        if ([_dm setupGameWords]) {
            
            if (_gameStatus == e_GAME_STATUS_END) {
                [self setupLifeBar];
            }
            
            [self restoreAllPlayerCards];
            _gameStatus = e_GAME_STATUS_DRAW_LOTS;
            [_dm setupPlayerRoles];
            [self.navigationItem.rightBarButtonItem setTitle:LOCALIZED_DEFAULT_SYSTEM_TABLE(@"OverGame")];
            [self updateGameInfo];
        }
    } else {
        if (_gameStatus == e_GAME_STATUS_DRAW_LOTS
            || _gameStatus == e_GAME_STATUS_GOING
            || _gameStatus == e_GAME_STATUS_GOING_LAST_ROUND) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:LOCALIZED_DEFAULT_SYSTEM_TABLE(@"WarmServiceTitle") message:LOCALIZED_DEFAULT_SYSTEM_TABLE(@"GameingSureToEndGame") selectedBlock:^(NSInteger index){
                if (1 == index) {
                    [self gameStop];
                }
            } cancelButtonTitle:LOCALIZED_DEFAULT_SYSTEM_TABLE(@"cancel") otherButtonTitles:LOCALIZED_DEFAULT_SYSTEM_TABLE(@"ok")];
            [alert show];
        }
    }
}

- (void)setupLifeBar {
    NSInteger totalPlayerNumber = _dm.selectedPlayersArr.count;
    NSInteger whitePlayerNumber = _dm.whiteBoardPlayerNumber;
    NSInteger underPlayNumber = _dm.underCoverPlayerNumber;
    NSInteger normalPlayNumber = totalPlayerNumber - whitePlayerNumber - underPlayNumber;
    
    _normalPersonLifeInfoLabel.text = [NSString stringWithFormat:LOCALIZED_DEFAULT_SYSTEM_TABLE(@"NormalPersonStatus"), normalPlayNumber, normalPlayNumber];
    _whiteBoardLifeInfoLabel.text = [NSString stringWithFormat:LOCALIZED_DEFAULT_SYSTEM_TABLE(@"WhiteBoardPersonStatus"), whitePlayerNumber, whitePlayerNumber];
    _underCoverLifeInfoLabel.text = [NSString stringWithFormat:LOCALIZED_DEFAULT_SYSTEM_TABLE(@"UnderCoverPersonStatus"), underPlayNumber, underPlayNumber];
    
    _underCoverLifeLabel.width = GAME_LIFE_BAR_WIDTH;
    _whiteBoardLifeLabel.width = GAME_LIFE_BAR_WIDTH;
    _normalPersonLifeLabel.width = GAME_LIFE_BAR_WIDTH;
    if (!IsIphone) {
        _underCoverLifeLabel.width = GAME_LIFE_BAR_WIDTH_IPAD;
        _whiteBoardLifeLabel.width = GAME_LIFE_BAR_WIDTH_IPAD;
        _normalPersonLifeLabel.width = GAME_LIFE_BAR_WIDTH_IPAD;
    }
    
    
    if (0 == underPlayNumber) {
        _underCoverLifeLabel.width = 0;
    }
    if (0 == whitePlayerNumber) {
        _whiteBoardLifeLabel.width = 0;
    }
}

- (void)updateLifeBar {
    NSInteger totalNormalPerson = _dm.selectedPlayersArr.count - _dm.whiteBoardPlayerNumber - _dm.underCoverPlayerNumber;
    _normalPersonLifeInfoLabel.text = [NSString stringWithFormat:LOCALIZED_DEFAULT_SYSTEM_TABLE(@"NormalPersonStatus"), _dm.normalPlayerLivingNumber, totalNormalPerson];
    _whiteBoardLifeInfoLabel.text = [NSString stringWithFormat:LOCALIZED_DEFAULT_SYSTEM_TABLE(@"WhiteBoardPersonStatus"), _dm.whiteBoardPlayerLivingNumber, _dm.whiteBoardPlayerNumber];
    _underCoverLifeInfoLabel.text = [NSString stringWithFormat:LOCALIZED_DEFAULT_SYSTEM_TABLE(@"UnderCoverPersonStatus"), _dm.underCoverPlayerLivingNumber, _dm.underCoverPlayerNumber];
    //更改血条
    float tempWidth;
    if (IsIphone) {
        tempWidth = GAME_LIFE_BAR_WIDTH;
    }else
        tempWidth = GAME_LIFE_BAR_WIDTH_IPAD;
    if (0 != _dm.underCoverPlayerNumber) {
        _underCoverLifeLabel.width = (tempWidth * _dm.underCoverPlayerLivingNumber) / _dm.underCoverPlayerNumber;
    }
    if (0 != _dm.whiteBoardPlayerNumber) {
        _whiteBoardLifeLabel.width = (tempWidth * _dm.whiteBoardPlayerLivingNumber) / _dm.whiteBoardPlayerNumber;
    }
    if (0 != totalNormalPerson) {
        _normalPersonLifeLabel.width = (tempWidth * _dm.normalPlayerLivingNumber) / totalNormalPerson;
    }
}

- (UIImage *)getRoleImagesByName:(NSString *)roleName {
    NSString *picName = roleName;
    if ([CURRENT_LANGUAGE isEqualToString:@"en"]) {
        picName = [NSString stringWithFormat:@"%@_en", picName];
    }
    
    return ImageNamed(picName);
}

- (void)killPlayerAtIndex:(UCUserCardView *)playerCard {
    playerCard.status = e_PLAYER_STATUS_Die;
    
    switch (playerCard.role) {
        case e_PLAYER_ROLE_NOMALPERSION:
            playerCard.statusImageView.image = [self getRoleImagesByName: @"Unjustly_Die"];
            [_dm killPlayer:e_PLAYER_NORMAL];
            break;
        case e_PLAYER_ROLE_UNDERCOVER:
            playerCard.statusImageView.image = [self getRoleImagesByName: @"UnderCover"];
            [_dm killPlayer:e_PLAYER_UNDERCOVER];
            break;
        case e_PLAYER_ROLE_WHITEBOARD:
            playerCard.statusImageView.image = [self getRoleImagesByName: @"White_Board"];
            [_dm killPlayer:e_PLAYER_WHITEBOARD];
            break;
            
        default:
            break;
    }
    
    [self updateLifeBar];
    [self updateGameInfo];
}

- (void)updateGameInfo {
    NSString *msg = nil;
    switch (_gameStatus) {
        case e_GAME_STATUS_NOT_START:
            msg = LOCALIZED_DEFAULT_SYSTEM_TABLE(@"GameNotBegin");
            break;
        case e_GAME_STATUS_DRAW_LOTS:
            msg = LOCALIZED_DEFAULT_SYSTEM_TABLE(@"GameInDrawLots");
            break;
        case e_GAME_STATUS_GOING:
            msg = LOCALIZED_DEFAULT_SYSTEM_TABLE(@"GamePlaying");
            break;
        case e_GAME_STATUS_GOING_LAST_ROUND:
            msg = LOCALIZED_DEFAULT_SYSTEM_TABLE(@"GamePlayingLastRound");
            break;
        case e_GAME_STATUS_END:
            if (_gameResult == e_GAME_RESULTS_NORMALPERSON_WIN) {
                msg = [NSString stringWithFormat:LOCALIZED_DEFAULT_SYSTEM_TABLE(@"NormalPersonWin"), _dm.words1, _dm.words2];
            } else if (_gameResult == e_GAME_RESULTS_UNDERCOVER_WIN) {
                msg = [NSString stringWithFormat:LOCALIZED_DEFAULT_SYSTEM_TABLE(@"UnderCoverWin"), _dm.words1, _dm.words2];
            } else {
                msg = [NSString stringWithFormat:LOCALIZED_DEFAULT_SYSTEM_TABLE(@"WhiteBoardWin"), _dm.words1, _dm.words2];
            }
            
            break;
            
        default:
            break;
    }
    _gameInfoLabel.text = msg;
}

- (void)checkGameStatus {
    if ([_dm isGameOver]) {
        _gameResult = e_GAME_RESULTS_NORMALPERSON_WIN;
        [self gameEnd];
    } else {
        if ([_dm isLastRound]) {
            _gameStatus = e_GAME_STATUS_GOING_LAST_ROUND;
            [self updateGameInfo];
        }
    }
}

- (void)updatePlayerScore {
    NSArray *playerCards = [_usersView subviews];
    for (int i = 0; i < playerCards.count; i++) {
        UCUserCardView *card = [playerCards objectAtIndex:i];
        Player *p = [_dm.selectedPlayersArr objectAtIndex: (card.tag - 1)];
        
        NSInteger score = 0;
        if (card.status == e_PLAYER_STATUS_LIVING) {
            score = 1;
        } else {
            score = -1;
        }
        
        switch (_gameResult) {
            case e_GAME_RESULTS_NORMALPERSON_WIN:
                if (card.role == e_PLAYER_ROLE_NOMALPERSION) {
                    score += 2;
                    [self player:p winWithScore:score];
                } else {
                    score -= 2;
                    [self player:p loseWithScore:score];
                }
                break;
            case e_GAME_RESULTS_UNDERCOVER_WIN:
                if (card.role == e_PLAYER_ROLE_UNDERCOVER) {
                    score += 2;
                    [self player:p winWithScore:score];
                } else {
                    score -= 2;
                    [self player:p loseWithScore:score];
                }
                break;
            case e_GAME_RESULTS_WHITEBOARD_WIN:
                if (card.role == e_PLAYER_ROLE_WHITEBOARD) {
                    score += 2;
                    [self player:p winWithScore:score];
                } else {
                    score -= 2;
                    [self player:p loseWithScore:score];
                }
                break;
                
            default:
                break;
        }
    }
    
    // Save to db
    NSError *error = nil;
    [appDelegate.cdataManager.managedObjectContext save:&error];
    if (error) {
        ;
    }
}

- (void)player:(Player *)p winWithScore:(NSInteger)score {
    p.score = [NSNumber numberWithInteger: (p.score.integerValue + score)];
    p.victor = [NSNumber numberWithInteger:(p.victor.integerValue + 1)];
    
    RoundPlayer *rp = [_dm.roundScroesDic objectForKey:p.id.stringValue];
    rp.score = [NSNumber numberWithInteger:rp.score.integerValue + score];
    rp.victor = [NSNumber numberWithInteger:rp.victor.integerValue + 1];
}

- (void)player:(Player *)p loseWithScore:(NSInteger)score {
    p.score = [NSNumber numberWithInteger: (p.score.integerValue + score)];
    p.failure = [NSNumber numberWithInteger:(p.failure.integerValue + 1)];
    
    RoundPlayer *rp = [_dm.roundScroesDic objectForKey:p.id.stringValue];
    rp.score = [NSNumber numberWithInteger:rp.score.integerValue + score];
    rp.failure = [NSNumber numberWithInteger:rp.failure.integerValue + 1];
}

- (void)restoreAllPlayerCards {
    NSArray *playerCards = [_usersView subviews];
    for (int i = 0; i < playerCards.count; i++) {
        UCUserCardView *card = [playerCards objectAtIndex:i];
        [card restore];
    }
}

- (void)showAllCardRole {
    NSArray *playerCards = [_usersView subviews];
    for (int i = 0; i < playerCards.count; i++) {
        UCUserCardView *card = [playerCards objectAtIndex:i];
        switch (card.role) {
            case e_PLAYER_ROLE_NOMALPERSION:
                card.statusImageView.image = [self getRoleImagesByName: @"Normal_People"];
                [_dm killPlayer:e_PLAYER_NORMAL];
                break;
            case e_PLAYER_ROLE_UNDERCOVER:
                card.statusImageView.image = [self getRoleImagesByName: @"UnderCover"];
                [_dm killPlayer:e_PLAYER_UNDERCOVER];
                break;
            case e_PLAYER_ROLE_WHITEBOARD:
                card.statusImageView.image = [self getRoleImagesByName: @"White_Board"];
                [_dm killPlayer:e_PLAYER_WHITEBOARD];
                break;
                
            default:
                break;
        }
    }
}

- (void)restoreDataModel {
    [_dm restore];
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

- (void)viewDidUnload {
    [self setScrollView:nil];
    [self setUsersView:nil];
    [self setNormalPersonLifeLabel:nil];
    [self setUnderCoverLifeLabel:nil];
    [self setWhiteBoardLifeLabel:nil];
    [self setNormalPersonLifeInfoLabel:nil];
    [self setUnderCoverLifeInfoLabel:nil];
    [self setWhiteBoardLifeInfoLabel:nil];
    [self setGameInfoLabel:nil];
    [self setScoreListBtn:nil];
    [super viewDidUnload];
}
@end

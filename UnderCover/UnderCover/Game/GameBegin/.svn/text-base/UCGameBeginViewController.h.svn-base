//
//  UCGameBeginViewController.h
//  UnderCover
//
//  Created by Wayde Sun on 7/19/13.
//  Copyright (c) 2013 iHakula. All rights reserved.
//

typedef enum {
    e_GAME_STATUS_NOT_START = 1,
    e_GAME_STATUS_DRAW_LOTS,
    e_GAME_STATUS_GOING,
    e_GAME_STATUS_GOING_LAST_ROUND,
    e_GAME_STATUS_END,
} eGameStatus;

typedef enum {
    e_GAME_RESULTS_NORMALPERSON_WIN = 1,
    e_GAME_RESULTS_UNDERCOVER_WIN,
    e_GAME_RESULTS_WHITEBOARD_WIN,
} eGameResults;

#import "JBaseViewController.h"
#import "GADBannerView.h"
#import "GADBannerViewDelegate.h"

@class UCGameModel, UCUserCardView;
@interface UCGameBeginViewController : JBaseViewController <UIActionSheetDelegate, GADBannerViewDelegate> {
    eGameStatus _gameStatus;
    eGameResults _gameResult;
    BOOL IsIphone;
    GADBannerView *bannerView_;
    UIView *untouchView;
    UINavigationController *nav;
}

@property (strong, nonatomic) UCGameModel *dm;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *usersView;
@property (weak, nonatomic) IBOutlet UILabel *normalPersonLifeLabel;
@property (weak, nonatomic) IBOutlet UILabel *underCoverLifeLabel;
@property (weak, nonatomic) IBOutlet UILabel *whiteBoardLifeLabel;
@property (weak, nonatomic) IBOutlet UILabel *normalPersonLifeInfoLabel;
@property (weak, nonatomic) IBOutlet UILabel *underCoverLifeInfoLabel;
@property (weak, nonatomic) IBOutlet UILabel *whiteBoardLifeInfoLabel;
@property (weak, nonatomic) IBOutlet UILabel *gameInfoLabel;
@property (weak, nonatomic) IBOutlet UIButton *scoreListBtn;

- (IBAction)onScoreListBtnClicked:(id)sender;
- (void)switchToSystemAutoSelectingWords;
- (void)onPlayerCardClicked:(UCUserCardView *)playerCard;

@end

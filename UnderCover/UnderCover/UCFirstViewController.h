//
//  UCFirstViewController.h
//  UnderCover
//
//  Created by Wayde Sun on 7/16/13.
//  Copyright (c) 2013 iHakula. All rights reserved.
//

#import "JBaseViewController.h"
#import "GADBannerView.h"
#import "GADBannerViewDelegate.h"
#import "UCChoosePlayerViewController.h"

@class UCGameModel;
@interface UCFirstViewController : JBaseViewController <UITextFieldDelegate, GADBannerViewDelegate> {
    UCGameModel *_dm;
    BOOL _wordOutOfUseage;
    
    GADBannerView *bannerView_;
    BOOL isIphone;
    UIView *choosePlayerView;
    UINavigationController *nav;
    UIView *untouchView;
}

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *chooseGamePlayerBtn;
@property (weak, nonatomic) IBOutlet UIView *usersView;
@property (weak, nonatomic) IBOutlet UIView *stepView;
@property (weak, nonatomic) IBOutlet UILabel *numberSuggestedLabel;
@property (weak, nonatomic) IBOutlet UILabel *whiteBoardPlayerNumberLabel;
@property (weak, nonatomic) IBOutlet UIButton *reduceWhiteBoardNumberBtn;
@property (weak, nonatomic) IBOutlet UIButton *increaseWhiteBoardNumberBtn;
@property (weak, nonatomic) IBOutlet UILabel *underCoverPlayerNumberLabel;
@property (weak, nonatomic) IBOutlet UIButton *reduceUnderCoverNumberBtn;
@property (weak, nonatomic) IBOutlet UIButton *increaseUnderCoverNumberBtn;
@property (weak, nonatomic) IBOutlet UILabel *usedVocabularyLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalVocabularyLabel;
@property (weak, nonatomic) IBOutlet UIButton *randomSystemBtn;
@property (weak, nonatomic) IBOutlet UIView *handInputVocabularyView;
@property (weak, nonatomic) IBOutlet UITextField *word1TextField;
@property (weak, nonatomic) IBOutlet UITextField *word2TextField;
@property (weak, nonatomic) IBOutlet UIButton *startGameBtn;
@property (weak, nonatomic) IBOutlet UIView *gameStartView;
@property (weak, nonatomic) IBOutlet UILabel *emptyPlayerLabel;

- (IBAction)onChooseGamePlayerBtnClicked:(id)sender;
- (IBAction)onReduceWhiteBoardNumberBtnClicked:(id)sender;
- (IBAction)onIncreaseWhiteBoardNumberBtnClicked:(id)sender;
- (IBAction)onReduceUnderCoverNumberBtnClicked:(id)sender;
- (IBAction)onIncreaseUnderCoverNumberBtnClicked:(id)sender;
- (IBAction)onRandomSystemBtnClicked:(id)sender;
- (IBAction)onGameBeginBtnClicked:(id)sender;


- (void)onPlayerSelected:(NSArray *)playersArr;

@end

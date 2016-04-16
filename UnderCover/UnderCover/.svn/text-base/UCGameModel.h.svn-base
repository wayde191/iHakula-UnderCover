//
//  UCGameModel.h
//  UnderCover
//
//  Created by Wayde Sun on 7/17/13.
//  Copyright (c) 2013 iHakula. All rights reserved.
//

typedef enum {
    e_PLAYER_NORMAL = 1,
    e_PLAYER_UNDERCOVER,
    e_PLAYER_WHITEBOARD,
} ePlayerTypes;

#import "JBaseModel.h"

@class Words;
@interface UCGameModel : JBaseModel {
    Words *_selectedWord;
}

@property (strong, nonatomic) NSMutableArray *playersRolesArr;
@property (strong, nonatomic) NSMutableArray *selectedPlayersArr;
@property (assign, nonatomic) NSInteger whiteBoardPlayerNumber;
@property (assign, nonatomic) NSInteger underCoverPlayerNumber;
@property (assign, nonatomic) NSInteger whiteBoardPlayerLivingNumber;
@property (assign, nonatomic) NSInteger underCoverPlayerLivingNumber;
@property (assign, nonatomic) NSInteger normalPlayerLivingNumber;
@property (assign, nonatomic) BOOL systemAutoSelectingWords;
@property (strong, nonatomic) NSString *words1;
@property (strong, nonatomic) NSString *words2;
@property (assign, nonatomic) NSInteger personCheckedCount;
@property (assign, nonatomic) BOOL roundChanged;
@property (strong, nonatomic) NSMutableDictionary *roundScroesDic;

- (void)setupRoundScore;

- (void)setupPlayerRoles;
- (BOOL)setupGameWords;
- (BOOL)setToSystemAutoSelectingWords;

- (void)updateUsedWordsStatus;

- (NSString *)getFirstRoundStartPlayerName;

- (void)setupGameBeginInfo;
- (void)killPlayer:(ePlayerTypes)playerType;

- (BOOL)isGameOver;
- (BOOL)isLastRound;

- (void)restore;

- (NSArray *)getRoundScoreLsit;

@end

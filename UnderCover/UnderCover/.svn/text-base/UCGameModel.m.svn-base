//
//  UCGameModel.m
//  UnderCover
//
//  Created by Wayde Sun on 7/17/13.
//  Copyright (c) 2013 iHakula. All rights reserved.
//

#import "UCGameModel.h"
#import "iHValidationKit.h"
#import "UCAppDelegate.h"
#import "Words.h"
#import "Player.h"
#import "RoundPlayer.h"

@implementation UCGameModel

- (id)init {
    self = [super init];
    if (self) {
        self.personCheckedCount = 0;
        self.roundChanged = YES;
        self.roundScroesDic = [NSMutableDictionary dictionary];
    }
    return self;
}

#pragma mark - Public Methods
- (void)setupRoundScore {
    if (_roundChanged) {
        [self.roundScroesDic removeAllObjects];
        
        for (int i = 0; i < _selectedPlayersArr.count; i++) {
            Player *aplayer = [_selectedPlayersArr objectAtIndex:i];
            RoundPlayer *roundPlayer = [[RoundPlayer alloc] initWithPlayer:aplayer];
            [_roundScroesDic setValue:roundPlayer forKey:roundPlayer.id.stringValue];
        }
    } else {
        
        for (int i = 0; i < _selectedPlayersArr.count; i++) {
            Player *aplayer = [_selectedPlayersArr objectAtIndex:i];
            if (![_roundScroesDic objectForKey:aplayer.id.stringValue]) {
                RoundPlayer *roundPlayer = [[RoundPlayer alloc] initWithPlayer:aplayer];
                [_roundScroesDic setValue:roundPlayer forKey:roundPlayer.id.stringValue];
            }
        }
    }
}

- (NSString *)getFirstRoundStartPlayerName {
    NSInteger randomNumber = arc4random();
    randomNumber = randomNumber > 0 ? randomNumber : (-1 * randomNumber);
    
    NSInteger randomIndex = randomNumber % _playersRolesArr.count;
    if ([[_playersRolesArr objectAtIndex:randomIndex] isEqualToString:@"白板玩家"]) {
        NSMutableArray *otherPlayersIndexArr = [NSMutableArray array];
        for (int i = 0; i < _playersRolesArr.count; i++) {
            if (i != randomIndex) {
                [otherPlayersIndexArr addObject:[NSString stringWithFormat:@"%d", i]];
            }
        }
        
        NSInteger randomNumber1 = arc4random();
        randomNumber1 = randomNumber1 > 0 ? randomNumber1 : (-1 * randomNumber1);
        
        NSInteger rIndex = randomNumber1 % otherPlayersIndexArr.count;
        randomIndex = [[otherPlayersIndexArr objectAtIndex:rIndex] integerValue];
    }
    
    Player *aplayer = [_selectedPlayersArr objectAtIndex:randomIndex];
    return aplayer.name;
}

- (void)setupPlayerRoles {
    self.playersRolesArr = [NSMutableArray array];
    NSInteger normalPlayerNumber = _selectedPlayersArr.count - _whiteBoardPlayerNumber - _underCoverPlayerNumber;
    
    NSMutableArray *wordPools = [NSMutableArray array];
    for (int i = 0; i < normalPlayerNumber; i++) {
        [wordPools addObject:_words1];
    }
    for (int i = 0; i < _underCoverPlayerNumber; i++) {
        [wordPools addObject:_words2];
    }
    for (int i = 0; i < _whiteBoardPlayerNumber; i++) {
        if ([CURRENT_LANGUAGE isEqualToString:@"en"]) {
            [wordPools addObject:@"Whiteboard"];
        } else {
            [wordPools addObject:@"白板玩家"];
        }
    }
    
    for (int i = 0; i < _selectedPlayersArr.count; i++) {
        NSInteger randomNumber = arc4random();
        randomNumber = randomNumber > 0 ? randomNumber : (-1 * randomNumber);
        NSInteger randomIndex = randomNumber % wordPools.count;
        [_playersRolesArr addObject:[wordPools objectAtIndex:randomIndex]];
        [wordPools removeObjectAtIndex:randomIndex];
    }
}

- (BOOL)setupGameWords {
    if (!_systemAutoSelectingWords) {
        if (![iHValidationKit isValueEmpty:_words1] && ![iHValidationKit isValueEmpty:_words2]) {
            return YES;
        } else {
            if (delegate && [delegate respondsToSelector:@selector(switchToSystemAutoSelectingWords)]) {
                [delegate performSelector:@selector(switchToSystemAutoSelectingWords)];
            }
            return NO;
        }
    } else {
        UCAppDelegate *appDelegate = [UCAppDelegate getSharedAppDelegate];
        NSArray *unusedWords = [appDelegate.cdataManager getAllUnUsedWords];
        
        if (0 == unusedWords.count) {
            [self showMessage:@"词库需要更新！"];
            [self performSelector:@selector(hideMessage) withObject:nil afterDelay:1.3];
            self.words1 = nil;
            self.words2 = nil;
            return NO;
        }
        
        NSInteger randomNumber = arc4random();
        randomNumber = randomNumber > 0 ? randomNumber : (-1 * randomNumber);
        NSInteger randomIndex = randomNumber % unusedWords.count;
        _selectedWord = [unusedWords objectAtIndex:randomIndex];
        self.words1 = _selectedWord.word1;
        self.words2 = _selectedWord.word2;
        return YES;
    }
}

- (BOOL)setToSystemAutoSelectingWords {
    self.systemAutoSelectingWords = YES;
    return [self setupGameWords];
}

- (void)updateUsedWordsStatus {
    if (_systemAutoSelectingWords && _selectedWord) {
        _selectedWord.type = @"used";
        NSError *error = nil;
        UCAppDelegate *appDelegate = [UCAppDelegate getSharedAppDelegate];
        [appDelegate.cdataManager.managedObjectContext save:&error];
        if (error) {
            ;
        }
    }
}

- (void)setupGameBeginInfo {
    self.whiteBoardPlayerLivingNumber = self.whiteBoardPlayerNumber;
    self.underCoverPlayerLivingNumber = self.underCoverPlayerNumber;
    self.normalPlayerLivingNumber = _selectedPlayersArr.count - self.whiteBoardPlayerNumber - self.underCoverPlayerNumber;
}

- (void)killPlayer:(ePlayerTypes)playerType {
    switch (playerType) {
        case e_PLAYER_NORMAL:
            self.normalPlayerLivingNumber--;
            break;
        case e_PLAYER_UNDERCOVER:
            self.underCoverPlayerLivingNumber--;
            break;
        case e_PLAYER_WHITEBOARD:
            self.whiteBoardPlayerLivingNumber--;
            break;
            
        default:
            break;
    }
}

- (BOOL)isGameOver {
    if (0 == _whiteBoardPlayerLivingNumber && 0 == _underCoverPlayerLivingNumber) {
        return YES;
    }
    
    return NO;
}

- (BOOL)isLastRound {
    NSInteger livingPeopleCount = _underCoverPlayerLivingNumber + _whiteBoardPlayerLivingNumber + _normalPlayerLivingNumber;
    if (livingPeopleCount == ((_selectedPlayersArr.count / 2) + 1)) {
        return YES;
    }
    
    return NO;
}

- (void)restore {
    self.words1 = nil;
    self.words2 = nil;
    self.personCheckedCount = 0;
    [self updateUsedWordsStatus];
}

- (NSArray *)getRoundScoreLsit {
    NSArray *list = [_roundScroesDic allValues];
    list = [list sortedArrayUsingComparator:
               ^NSComparisonResult(id obj1, id obj2){
                   NSComparisonResult result = NSOrderedSame;
                   RoundPlayer *player1 = obj1;
                   RoundPlayer *player2 = obj2;
                   
                   if (1 == [player1.score compare:player2.score]) {
                       result = NSOrderedAscending;
                   } else {
                       result = NSOrderedDescending;
                   }
                   return result;
               }];
    return list;
}

@end

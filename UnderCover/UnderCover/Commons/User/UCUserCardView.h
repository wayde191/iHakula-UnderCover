//
//  UCUserCardView.h
//  UnderCover
//
//  Created by Wayde Sun on 7/19/13.
//  Copyright (c) 2013 iHakula. All rights reserved.
//

typedef enum {
    e_PLAYER_STATUS_LIVING = 1,
    e_PLAYER_STATUS_Die,
} ePlayerStatus;

typedef enum {
    e_PLAYER_ROLE_NOMALPERSION = 1,
    e_PLAYER_ROLE_UNDERCOVER,
    e_PLAYER_ROLE_WHITEBOARD,
} ePlayerRole;

#import "JBaseView.h"

@class Player;
@interface UCUserCardView : JBaseView

@property (weak, nonatomic) id delegate;
@property (strong, nonatomic) Player *aplayer;
@property (assign, nonatomic) ePlayerStatus status;
@property (assign, nonatomic) ePlayerRole role;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *cornerImageView;
@property (weak, nonatomic) IBOutlet UILabel *indexLabel;
@property (weak, nonatomic) IBOutlet UIImageView *statusImageView;
@property (weak, nonatomic) IBOutlet UILabel *roleLabel;
@property (weak, nonatomic) IBOutlet UIView *backRoleView;
@property (weak, nonatomic) IBOutlet UILabel *checkedLabel;
@property (weak, nonatomic) IBOutlet UIView *drawLotsView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *drawLotsIndicator;
@property (weak, nonatomic) IBOutlet UILabel *roleWordLabel;
@property (weak, nonatomic) IBOutlet UILabel *remindLabel;
- (IBAction)onBtnClicked:(id)sender;
- (void)setValues:(Player *)aplayer byIndex:(NSInteger)index;

- (void)restore;

@end

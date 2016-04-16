//
//  JServiceViewController.h
//  Journey
//
//  Created by Wayde Sun on 7/1/13.
//  Copyright (c) 2013 iHakula. All rights reserved.
//

#import "JBaseViewController.h"

@class UCWordsUpdatedModel;
@interface JServiceViewController : JBaseViewController <UIActionSheetDelegate> {
    UCWordsUpdatedModel *_dm;
}

@property (weak, nonatomic) IBOutlet UILabel *usedLabel;
@property (weak, nonatomic) IBOutlet UILabel *systemTotalWordsLabel;
@property (weak, nonatomic) IBOutlet UILabel *dbTotalWordsLabel;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicator;
@property (weak, nonatomic) IBOutlet UIButton *updateWordsBtn;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
- (IBAction)onSwitchThesaurusBtnClicked:(id)sender;

- (IBAction)onUpdateWordsBtnClicked:(id)sender;
- (IBAction)onFiveStarBtnClicked:(id)sender;
- (void)getDBtotalNumberSuccess;
- (void)updateUseageNumber;
@end

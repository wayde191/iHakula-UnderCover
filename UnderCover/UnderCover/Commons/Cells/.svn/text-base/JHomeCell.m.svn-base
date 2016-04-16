//
//  JHomeCell.m
//  Journey
//
//  Created by Wayde Sun on 6/30/13.
//  Copyright (c) 2013 iHakula. All rights reserved.
//

#import "JHomeCell.h"
#import "JHomeCellView.h"
#import "Player.h"
#import "RoundPlayer.h"

@implementation JHomeCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _cellView = [JHomeCellView viewFromNib];
        
        [self.contentView addSubview:_cellView];
        
    }
    return self;
}

- (void)setValues:(Player *)aplayer {
    _cellView.titleLabel.text = aplayer.name;
    _cellView.victorLabel.text = [aplayer.victor stringValue];
    _cellView.failureLabel.text = [aplayer.failure stringValue];
    _cellView.scoreLabel.text = [aplayer.score stringValue];
}

- (void)setValue:(RoundPlayer *)aRoundPlayer {
    _cellView.titleLabel.text = aRoundPlayer.name;
    _cellView.victorLabel.text = [aRoundPlayer.victor stringValue];
    _cellView.failureLabel.text = [aRoundPlayer.failure stringValue];
    _cellView.scoreLabel.text = [aRoundPlayer.score stringValue];
    _cellView.checkBtn.hidden = YES;
}

- (void)toggleCheck {
    _cellView.checkBtn.hidden = !_cellView.checkBtn.hidden;
}

- (void)restoreCheck {
    _cellView.checkBtn.hidden = YES;
}

- (BOOL)isChecked {
    return !_cellView.checkBtn.hidden;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

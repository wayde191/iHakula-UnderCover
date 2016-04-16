//
//  UCUserCardView.m
//  UnderCover
//
//  Created by Wayde Sun on 7/19/13.
//  Copyright (c) 2013 iHakula. All rights reserved.
//

#import "UCUserCardView.h"
#import "Player.h"

@implementation UCUserCardView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.status = e_PLAYER_STATUS_LIVING;
       
    }
    return self;
}

- (void)awakeFromNib {
    self.status = e_PLAYER_STATUS_LIVING;
    if (!IH_IS_IPHONE) {
        self.checkedLabel.font = [UIFont systemFontOfSize:15];
    }
}

- (IBAction)onBtnClicked:(id)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(onPlayerCardClicked:)]) {
        [_delegate performSelector:@selector(onPlayerCardClicked:) withObject:self];
    }
}

- (void)setValues:(Player *)aplayer byIndex:(NSInteger)index {
    self.aplayer = aplayer;
    self.nameLabel.text = aplayer.name;
    self.indexLabel.text = [NSString stringWithFormat:@"%d", index];
    NSString *imageName = [NSString stringWithFormat:@"TrackColor_%d.png", (index % 7 == 0 ? 7 : (index % 7)) + 7];
    self.cornerImageView.image = ImageNamed(imageName);
    if (!IH_IS_IPHONE) {
        self.size = CGSizeMake(140, 140);
        self.nameLabel.font = [UIFont systemFontOfSize:22];
        self.roleLabel.font = [UIFont systemFontOfSize:20];
        self.roleWordLabel.font = [UIFont systemFontOfSize:14];
        self.remindLabel.font = [UIFont systemFontOfSize:14];
        self.nameLabel.origin = CGPointMake(1, 59);
        self.remindLabel.frame = CGRectMake(0,self.remindLabel.frame.origin.y+20, 140, 50);
    
    }
}

- (void)restore {
    self.status = e_PLAYER_STATUS_LIVING;
    self.role = e_PLAYER_ROLE_NOMALPERSION;
    self.checkedLabel.hidden = YES;
    self.drawLotsView.hidden = NO;
    self.statusImageView.image = nil;
}
@end

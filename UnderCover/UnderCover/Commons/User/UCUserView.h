//
//  UCUserView.h
//  UnderCover
//
//  Created by Wayde Sun on 7/17/13.
//  Copyright (c) 2013 iHakula. All rights reserved.
//

#import "JBaseView.h"

@class Player;
@interface UCUserView : JBaseView

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *indexLabel;
@property (weak, nonatomic) IBOutlet UIImageView *colorImgView;

- (void)setValues:(Player *)aplayer byIndex:(NSInteger)index;

@end

//
//  JHomeCellView.h
//  Journey
//
//  Created by Wayde Sun on 6/30/13.
//  Copyright (c) 2013 iHakula. All rights reserved.
//

#import "JBaseView.h"

@interface JHomeCellView : JBaseView

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *victorLabel;
@property (weak, nonatomic) IBOutlet UILabel *failureLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UIButton *checkBtn;
@end

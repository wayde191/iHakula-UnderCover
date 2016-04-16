//
//  jStarChoiceCell.m
//  Journey
//
//  Created by Wayde Sun on 7/1/13.
//  Copyright (c) 2013 iHakula. All rights reserved.
//

#import "JStarChoiceCell.h"
#import "JStarChoiceCellView.h"

@implementation JStarChoiceCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _cellView = [JStarChoiceCellView viewFromNib];
        
        [self.contentView addSubview:_cellView];
    }
    return self;
}

- (void)setValues:(NSDictionary *)keyedValues {
    _cellView.titleLabel.text = [keyedValues objectForKey:@"title"];
    _cellView.priceLabel.text = [NSString stringWithFormat:@"¥ %@", [keyedValues objectForKey:@"price"]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

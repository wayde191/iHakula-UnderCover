//
//  JMoreCell.m
//  Journey
//
//  Created by Wayde Sun on 7/1/13.
//  Copyright (c) 2013 iHakula. All rights reserved.
//

#import "JMoreCell.h"
#import "JMoreCellView.h"

@implementation JMoreCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _cellView = [JMoreCellView viewFromNib];
        
        [self.contentView addSubview:_cellView];
    }
    return self;
}

- (void)setValues:(NSDictionary *)keyedValues {
    NSString *title = nil;
    NSString *image = [keyedValues objectForKey:@"image"];
    
    if ([CURRENT_LANGUAGE isEqualToString:@"en"]) {
        title = [keyedValues objectForKey:@"title-en"];
    } else if ([CURRENT_LANGUAGE isEqualToString:@"zh-Hans"]) {
        title = [keyedValues objectForKey:@"title"];
    }
    
    _cellView.titleLabel.text = title;
    _cellView.iconImageView.image = ImageNamed(image);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

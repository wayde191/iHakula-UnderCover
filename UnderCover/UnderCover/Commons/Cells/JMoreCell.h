//
//  JMoreCell.h
//  Journey
//
//  Created by Wayde Sun on 7/1/13.
//  Copyright (c) 2013 iHakula. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JMoreCellView;
@interface JMoreCell : UITableViewCell{
    JMoreCellView *_cellView;
}

- (void)setValues:(NSDictionary *)keyedValues;

@end

//
//  UCWordsUpdatedModel.h
//  UnderCover
//
//  Created by Wayde Sun on 7/22/13.
//  Copyright (c) 2013 iHakula. All rights reserved.
//

#import "JBaseModel.h"

@interface UCWordsUpdatedModel : JBaseModel

@property (nonatomic, assign) NSInteger usedWordsNumber;
@property (nonatomic, assign) NSInteger totalSystemNumber;
@property (nonatomic, assign) NSInteger dbTotalNumber;

- (void)doCallUpdateWordsService;
- (void)doCallGetDBTotalWordsNumber;
- (void)updateUseageNumber;
@end

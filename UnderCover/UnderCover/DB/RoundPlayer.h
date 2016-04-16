//
//  RoundPlayer.h
//  UnderCover
//
//  Created by Wayde Sun on 7/21/13.
//  Copyright (c) 2013 iHakula. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Player;
@interface RoundPlayer : NSObject

@property (nonatomic, strong) NSNumber * id;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSNumber * score;
@property (nonatomic, strong) NSNumber * victor;
@property (nonatomic, strong) NSNumber * failure;

- (id)initWithPlayer:(Player *)aplayer;

@end

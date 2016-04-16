//
//  RoundPlayer.m
//  UnderCover
//
//  Created by Wayde Sun on 7/21/13.
//  Copyright (c) 2013 iHakula. All rights reserved.
//

#import "RoundPlayer.h"
#import "Player.h"

@implementation RoundPlayer

- (id)initWithPlayer:(Player *)aplayer {
    self = [self init];
    if (self) {
        self.id = aplayer.id;
        self.name = aplayer.name;
        self.victor = [NSNumber numberWithInt:0];
        self.failure = [NSNumber numberWithInt:0];
        self.score = [NSNumber numberWithInt:0];
    }
    return self;
}

@end

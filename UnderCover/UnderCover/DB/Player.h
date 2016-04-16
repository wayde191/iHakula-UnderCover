//
//  Player.h
//  UnderCover
//
//  Created by Wayde Sun on 7/17/13.
//  Copyright (c) 2013 iHakula. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Player : NSManagedObject

@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * score;
@property (nonatomic, retain) NSNumber * victor;
@property (nonatomic, retain) NSNumber * failure;

@end

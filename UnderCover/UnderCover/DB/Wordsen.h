//
//  Wordsen.h
//  UnderCover
//
//  Created by Wayde Sun on 8/14/13.
//  Copyright (c) 2013 iHakula. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Wordsen : NSManagedObject

@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSString * word2;
@property (nonatomic, retain) NSString * word1;

@end

//
//  iHCDataManager.h
//  UnderCover
//
//  Created by Wayde Sun on 7/17/13.
//  Copyright (c) 2013 iHakula. All rights reserved.
//

#define COREDATA_SQLITE_FILENAME            @"UnderCover.sqlite"
#define MANAGED_OBJECT_MODEL_NAME           @"UnderCover"

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface iHCDataManager : NSObject

@property (strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

- (BOOL)insert:(NSArray *)managedObjects;
- (NSInteger)getLastPlayerId;
- (id)searchObjectByName:(NSString *)strName withEntityName:(NSString *)entityName;
- (NSArray *)selectAllObjectsByEntityName:(NSString *)entityName;

- (NSInteger)getTheNumberOfSystemWords;
- (NSInteger)getTheNumberOfUsuedSystemWords;
- (NSArray *)getAllUnUsedWords;
- (void)remove:(NSArray *)managedObjects;

@end

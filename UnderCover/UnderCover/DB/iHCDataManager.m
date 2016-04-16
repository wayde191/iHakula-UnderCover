//
//  iHCDataManager.m
//  UnderCover
//
//  Created by Wayde Sun on 7/17/13.
//  Copyright (c) 2013 iHakula. All rights reserved.
//

#import "iHCDataManager.h"
#import "iHFileManager.h"
#import "Player.h"
#import "UCAppDelegate.h"
#import "JUser.h"

@interface iHCDataManager ()
- (void)createStore;
- (NSString *)getWordEntityNameByUserLanguage;
@end

@implementation iHCDataManager

- (id)init {
    self = [super init];
    if (self) {
        [self createStore];
    }
    return self;
}

#pragma mark - Public Methods
- (BOOL)insert:(NSArray *)managedObjects {
    for (NSManagedObject *object in managedObjects) {
        NSError *error = nil;
        
        if (![_managedObjectContext save:&error]) {
            return FALSE;
        }
    }
    return TRUE;
    
    //objectId=[[[myCoredataObject objectID] URIRepresentation] absoluteString]
    //NSManagedObject *managedObject= [managedObjectContext objectWithID:[persistentStoreCoordinator managedObjectIDForURIRepresentation:[NSURL URLWithString:objectId]]];

}

- (id)searchObjectByName:(NSString *)strName withEntityName:(NSString *)entityName {
    NSManagedObjectContext *context = self.managedObjectContext;
    NSEntityDescription *description = [NSEntityDescription entityForName:entityName inManagedObjectContext:context];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name == %@",strName];
    
    if (!predicate) {
        return nil;
    }
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:description];
    [request setPredicate:predicate];
    [request setFetchLimit:1];
    
    NSError *error = nil;
    NSArray *results = [context executeFetchRequest:request error:&error];
    if(!results || [results count] < 1){
        return nil;
    }
    
    return [results objectAtIndex:0];
}

- (NSArray *)selectAllObjectsByEntityName:(NSString *)entityName {
    NSManagedObjectContext *context = self.managedObjectContext;
    NSEntityDescription *description = [NSEntityDescription entityForName:entityName inManagedObjectContext:context];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"score" ascending:NO];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:description];
    [request setSortDescriptors:sortDescriptors];
    
    NSError *error = nil;
    NSArray *results = [context executeFetchRequest:request error:&error];
    return results;
}

- (NSInteger)getLastPlayerId {
    NSManagedObjectContext *context = self.managedObjectContext;
    NSEntityDescription *description = [NSEntityDescription entityForName:@"Player" inManagedObjectContext:context];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"id" ascending:NO];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:description];
    [request setSortDescriptors:sortDescriptors];
    
    NSError *error = nil;
    NSArray *results = [context executeFetchRequest:request error:&error];
    
    if (results.count) {
        Player *lastPlayer = [results objectAtIndex:0];
        return lastPlayer.id.integerValue;
    }
    
    return 0;
}

- (NSInteger)getTheNumberOfSystemWords {
    NSManagedObjectContext *context = self.managedObjectContext;
    NSEntityDescription *description = [NSEntityDescription entityForName:[self getWordEntityNameByUserLanguage] inManagedObjectContext:context];

    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:description];
    
    NSError *error = nil;
    NSArray *results = [context executeFetchRequest:request error:&error];
    
    return results.count;
}

- (NSInteger)getTheNumberOfUsuedSystemWords {
    NSManagedObjectContext *context = self.managedObjectContext;
    NSEntityDescription *description = [NSEntityDescription entityForName:[self getWordEntityNameByUserLanguage] inManagedObjectContext:context];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"type == %@", @"used"];
    
    if (!predicate) {
        return 0;
    }
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:description];
    [request setPredicate:predicate];
    
    NSError *error = nil;
    NSArray *results = [context executeFetchRequest:request error:&error];
    if(!results || [results count] < 1){
        return 0;
    }
    
    return results.count;
}

- (NSArray *)getAllUnUsedWords {
    NSManagedObjectContext *context = self.managedObjectContext;
    NSEntityDescription *description = [NSEntityDescription entityForName:[self getWordEntityNameByUserLanguage] inManagedObjectContext:context];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"type == %@", @"unused"];
    
    if (!predicate) {
        return nil;
    }
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:description];
    [request setPredicate:predicate];
    
    NSError *error = nil;
    NSArray *results = [context executeFetchRequest:request error:&error];
    if(!results || [results count] < 1){
        return nil;
    }
    
    return results;
}

- (void)remove:(NSArray *)managedObjects {
    for (id object in managedObjects) {
        [self.managedObjectContext deleteObject:object];
    }
    
    NSError *error = nil;
    if (![self.managedObjectContext save:&error]) {
        // Handle the error.
    }
}

#pragma mark - Getter Mehthods
- (NSManagedObjectModel *)managedObjectModel {
    if (_managedObjectModel) {
        return _managedObjectModel;
    }
    
    self.managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    if (_persistentStoreCoordinator) {
        return _persistentStoreCoordinator;
    }

    self.persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.managedObjectModel];
    return _persistentStoreCoordinator;
}

- (NSManagedObjectContext *)managedObjectContext {
    if (_managedObjectContext) {
        return _managedObjectContext;
    }
    
    self.managedObjectContext = [[NSManagedObjectContext alloc] init];
    return _managedObjectContext;
}

#pragma mark - Private Methods
- (void)createStore {
    NSPersistentStoreCoordinator *psc = self.persistentStoreCoordinator;
    
    NSMutableDictionary *pragmaOptions = [NSMutableDictionary dictionary];
    [pragmaOptions setObject:@"NORMAL" forKey:@"synchronous"];
    [pragmaOptions setObject:@"1" forKey:@"fullfsync"];
    NSDictionary *storeOptions = [NSDictionary dictionaryWithObjectsAndKeys:
                                  [NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption,
                                  [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
    
    NSString *sqlitFilePath = [[iHFileManager getDocumentPath] stringByAppendingPathComponent:COREDATA_SQLITE_FILENAME];
    
    NSError *error = nil;
    NSURL *sqliteFileUrl = [NSURL fileURLWithPath:sqlitFilePath];
    NSPersistentStore *store;
    store = [psc addPersistentStoreWithType:NSSQLiteStoreType
                              configuration:nil
                                        URL:sqliteFileUrl
                                    options:storeOptions
                                      error:&error];
    if (!error) {
        NSManagedObjectContext *ct = self.managedObjectContext;
        [ct setPersistentStoreCoordinator:psc];
    }
}

- (NSString *)getWordEntityNameByUserLanguage {
    NSString *lan = [UCAppDelegate getSharedAppDelegate].user.language;
    return [NSString stringWithFormat:@"Words%@", lan];
}

@end

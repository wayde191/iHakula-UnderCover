//
//  UCWordsUpdatedModel.m
//  UnderCover
//
//  Created by Wayde Sun on 7/22/13.
//  Copyright (c) 2013 iHakula. All rights reserved.
//

#import "UCWordsUpdatedModel.h"
#import "iHPubSub.h"
#import "Words.h"
#import "UCAppDelegate.h"

#define GET_WORDS_SERVICE                   @"GetWordsService"
#define GET_TOTAL_DB_WORDS_SERVICE          @"GetTotalDBWordsService"

@interface JUser ()
@end

@implementation UCWordsUpdatedModel

- (id)init {
    self = [super init];
    if (self) {
        self.usedWordsNumber = 0;
        self.totalSystemNumber = 0;
        self.dbTotalNumber = 0;
    }
    return self;
}


#pragma mark - Public Methods
- (void)doCallUpdateWordsService {
    theRequest.requestMethod = iHRequestMethodPost;
    NSDictionary *paras = [NSDictionary dictionaryWithObjectsAndKeys:
                           [NSString stringWithFormat:@"%d", _totalSystemNumber], @"startId",
                           [UCAppDelegate getSharedAppDelegate].user.language, @"lan",
                           @"f37d8eee76c0c03a69050ab7ca7bace3", @"undercoverKey",
                           nil];
    
    [self doCallService:GET_WORDS_SERVICE withParameters:paras andServiceUrl:SERVICE_GET_WORDS forDelegate:self];
}

- (void)doCallGetDBTotalWordsNumber {
    theRequest.requestMethod = iHRequestMethodPost;
    NSDictionary *paras = [NSDictionary dictionaryWithObjectsAndKeys:
                           [UCAppDelegate getSharedAppDelegate].user.language, @"lan",
                           nil];
    [self doCallService:GET_TOTAL_DB_WORDS_SERVICE withParameters:paras andServiceUrl:SERVICE_WORDS_TOTAL_NUMBER forDelegate:self];
}

- (void)updateUseageNumber {
    UCAppDelegate *appDelegate = [UCAppDelegate getSharedAppDelegate];
    self.totalSystemNumber = [appDelegate.cdataManager getTheNumberOfSystemWords];
    self.usedWordsNumber = [appDelegate.cdataManager getTheNumberOfUsuedSystemWords];
}


#pragma mark - Private Methods
- (void)cancelRequest {
    [iHPubSub publishMsgWithSubject:[NSString stringWithFormat:@"%@Canceld", GET_WORDS_SERVICE] andDataDic:[NSDictionary dictionaryWithObject:GET_WORDS_SERVICE forKey:@"serviceName"]];
}

#pragma mark - iHRequestDelegate
- (void)requestDidCanceld {
    [super requestDidCanceld];
}
-(void)serviceCallFailed:(iHResponseSuccess *)response
{
    [super serviceCallFailed:response];
    if ([response.serviceName isEqualToString:GET_WORDS_SERVICE]) {
        if (delegate && [delegate respondsToSelector:@selector(showLabel)]) {
            [delegate performSelector:@selector(showWrongLabel)];
            
        }
    }
}
- (void)serviceCallSuccess:(iHResponseSuccess *)response {
    [super serviceCallSuccess:response];
    if ([response.serviceName isEqualToString:GET_TOTAL_DB_WORDS_SERVICE]) {
        self.dbTotalNumber = [[response.userInfoDic objectForKey:@"totalNumber"] integerValue];
        if (delegate && [delegate respondsToSelector:@selector(getDBtotalNumberSuccess)]) {
            [delegate performSelector:@selector(getDBtotalNumberSuccess)];
        }
    } else if ([response.serviceName isEqualToString:GET_WORDS_SERVICE]) {
        NSArray *dbwords = [response.userInfoDic objectForKey:@"words"];
        
        UCAppDelegate *appDelegate = [UCAppDelegate getSharedAppDelegate];
        NSString *entityName = @"Words";
        if ([appDelegate.user.language isEqualToString:@"en"]) {
            entityName = @"Wordsen";
        }
        
        NSMutableArray *words = [NSMutableArray array];
        for (int i = 0; i < dbwords.count; i++) {
            NSDictionary *item = [dbwords objectAtIndex:i];
            Words *w = (Words *)[NSEntityDescription insertNewObjectForEntityForName:entityName inManagedObjectContext:appDelegate.cdataManager.managedObjectContext];
            w.id = [NSNumber numberWithInteger:[[item objectForKey:@"id"] integerValue]];
            w.type = [item objectForKey:@"type"];
            w.word1 = [item objectForKey:@"word1"];
            w.word2 = [item objectForKey:@"word2"];
            [words addObject:w];
        }
        
        if ([appDelegate.cdataManager insert:words]) {
            if (delegate && [delegate respondsToSelector:@selector(updateUseageNumber)]) {
                [delegate performSelector:@selector(updateUseageNumber)];
                [delegate performSelector:@selector(showLabel)];
                
            }
        }
    }
}


@end

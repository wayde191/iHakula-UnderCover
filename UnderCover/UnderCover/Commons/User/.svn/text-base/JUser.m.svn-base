//
//  JUser.m
//  Journey
//
//  Created by Wayde Sun on 7/1/13.
//  Copyright (c) 2013 iHakula. All rights reserved.
//

#import "JUser.h"
#import "iHPubSub.h"
#import "Words.h"
#import "Wordsen.h"
#import "UCAppDelegate.h"
#import "CJSONSerializer.h"

#define FEEDBACK_SERVICE            @"FeedbackService"
#define UPLOAD_TOKEN_SERVICE        @"UploadTokenService"
#define GET_APPID_SERVICE           @"GetAppIdService"

//f37d8eee76c0c03a69050ab7ca7bace3

@interface JUser ()
- (void)writeLocalWordsToDB;
@end

@implementation JUser

- (id)init {
    self = [super init];
    if (self) {
        _platform = [UIDevice currentDevice].systemName;
        _os = [UIDevice currentDevice].systemVersion;
        _device = [UIDevice currentDevice].localizedModel;
        
        if ([CURRENT_LANGUAGE isEqualToString:@"en"]) {
            self.language = @"en";
        } else{
            self.language = @"";
        }
        
        if (![USER_DEFAULT valueForKey:IH_FIRST_TIME_INSTALLED]) {
            [self writeLocalWordsToDB];
            [USER_DEFAULT setValue:@"installed" forKey:IH_FIRST_TIME_INSTALLED];
            [USER_DEFAULT synchronize];
        }
        
//        if ([USER_DEFAULT valueForKey:IH_UNDERCOVER_APP_ID]) {
//            self.appId = [USER_DEFAULT objectForKey:IH_UNDERCOVER_APP_ID];
//        }
        self.appId = @"679459643";
//        [self doUploadToken];
        [self loadNewWords];
    }
    return self;
}


#pragma mark - Public Methods
- (void)doCallFeedbackService:(NSString *)feedback {
    theRequest.requestMethod = iHRequestMethodPost;
    NSDictionary *paras = [NSDictionary dictionaryWithObjectsAndKeys:
                           _platform, @"platform",
                           _os, @"os",
                           _device, @"device",
                           feedback, @"description",
                           @"f37d8eee76c0c03a69050ab7ca7bace3", @"undercoverKey",
                           nil];
    
    [self doCallService:FEEDBACK_SERVICE withParameters:paras andServiceUrl:SERVICE_FEEDBACK forDelegate:self];
}

- (void)doUploadToken {
    theRequest.requestMethod = iHRequestMethodPost;
    NSString *token = [USER_DEFAULT objectForKey:IH_DEVICE_TOKEN];
    if (token) {
        NSDictionary *paras = [NSDictionary dictionaryWithObjectsAndKeys:
                               @"undercover007", @"app",
                               @"iOS", @"platform",
                               @"2.0.0", @"version",
                               CURRENT_LANGUAGE, @"language",
                               _os, @"os",
                               _device, @"device",
                               token, @"token",
                               @"f37d8eee76c0c03a69050ab7ca7bace3", @"undercoverKey",
                               nil];
        
        [self doCallService:UPLOAD_TOKEN_SERVICE withParameters:paras andServiceUrl:SERVICE_UPLOAD_TOKEN forDelegate:nil];
    }
}

#pragma mark - Private Methods
- (void)writeLocalWordsToDB {
    NSString *dataPath = [[NSBundle mainBundle] pathForResource:@"SystemWords" ofType:@"plist"];
    NSDictionary *dataDic = [NSDictionary dictionaryWithContentsOfFile:dataPath];
    NSArray *systemWords = [dataDic objectForKey:@"words"];
    UCAppDelegate *appDelegate = [UCAppDelegate getSharedAppDelegate];
    
    NSMutableArray *words = [NSMutableArray array];
    for (int i = 0; i < systemWords.count; i++) {
        NSArray *items = [[systemWords objectAtIndex:i] componentsSeparatedByString:@","];
        Words *w = (Words *)[NSEntityDescription insertNewObjectForEntityForName:@"Words" inManagedObjectContext:appDelegate.cdataManager.managedObjectContext];
        w.id = [NSNumber numberWithInt:(i + 1)];
        w.type = @"unused";
        w.word1 = [items objectAtIndex:0];
        w.word2 = [items objectAtIndex:1];
        [words addObject:w];
    }
    
    systemWords = [dataDic objectForKey:@"wordsen"];
    for (int i = 0; i < systemWords.count; i++) {
        NSArray *items = [[systemWords objectAtIndex:i] componentsSeparatedByString:@","];
        Wordsen *w = (Wordsen *)[NSEntityDescription insertNewObjectForEntityForName:@"Wordsen" inManagedObjectContext:appDelegate.cdataManager.managedObjectContext];
        w.id = [NSNumber numberWithInt:(i + 1)];
        w.type = @"unused";
        w.word1 = [items objectAtIndex:0];
        w.word2 = [items objectAtIndex:1];
        [words addObject:w];
    }
    
    if ([appDelegate.cdataManager insert:words]) {
        // init sqlite file successful
    }
}

- (void)cancelRequest {
    [iHPubSub publishMsgWithSubject:[NSString stringWithFormat:@"%@Canceld", FEEDBACK_SERVICE] andDataDic:[NSDictionary dictionaryWithObject:FEEDBACK_SERVICE forKey:@"serviceName"]];
}

#pragma mark - iHRequestDelegate
- (void)requestDidCanceld {
    [super requestDidCanceld];
}

- (void)serviceCallSuccess:(iHResponseSuccess *)response {
    [super serviceCallSuccess:response];
    if ([response.serviceName isEqualToString:GET_APPID_SERVICE]) {
        self.appId = [response.userInfoDic objectForKey:@"appId"];
        [USER_DEFAULT setValue:self.appId forKey:IH_UNDERCOVER_APP_ID];
        
    } else if ([response.serviceName isEqualToString:FEEDBACK_SERVICE]) {
        if (delegate && [delegate respondsToSelector:@selector(onFeedbackSuccess)]) {
            [delegate performSelector:@selector(onFeedbackSuccess)];
           // [delegate performSelector:@selector(showLabel)];
        }
    }
}
-(void)serviceCallFailed:(iHResponseSuccess *)response
{
    [super serviceCallFailed:response];
    if ([response.serviceName isEqualToString:FEEDBACK_SERVICE]) {
        if (delegate && [delegate respondsToSelector:@selector(showWrongLabel)]) {
            [delegate performSelector:@selector(showWrongLabel)];
            
        }
    }
    
}
- (void)doCallGetAppIdService {
    theRequest.requestMethod = iHRequestMethodPost;

    [self doCallService:GET_APPID_SERVICE withParameters:nil andServiceUrl:SERVICE_GET_APPID forDelegate:self];
}

- (void)loadNewWords {
    NSString *dataPath = [[NSBundle mainBundle] pathForResource:@"NewWords" ofType:@"plist"];
    NSDictionary *dataDic = [NSDictionary dictionaryWithContentsOfFile:dataPath];
    self.language = @"";
    NSString *wordsKey = [NSString stringWithFormat:@"words%@", self.language];
    NSArray *systemWords = [dataDic objectForKey:wordsKey];
    
    NSMutableArray *newWords = [NSMutableArray array];
    for (int i = 0; i < systemWords.count; i++) {
        NSString *s = [systemWords objectAtIndex:i];
        NSArray *sa = [s componentsSeparatedByString:@","];
        [newWords addObject:sa];
    }
    
    NSString *theString = [[CJSONSerializer serializer] serializeArray:newWords];
    
    theRequest.requestMethod = iHRequestMethodPost;
    NSDictionary *paras = [NSDictionary dictionaryWithObjectsAndKeys:
                           theString, @"newWords",
                           self.language, @"lan",
                           @"f37d8eee76c0c03a69050ab7ca7bace3", @"undercoverKey",
                           nil];
    
//    NSLog(@"-- %@", paras);
    
    [self doCallService:@"insertService" withParameters:paras andServiceUrl:SERVICE_INSERT_NEW_WORDS forDelegate:self];
}


@end

//
//  iHResponseSuccess.m
//  iHakula
//
//  Created by Wayde Sun on 2/21/13.
//  Copyright (c) 2013 iHakula. All rights reserved.
//

#import "iHResponseSuccess.h"
#import "iHValidationKit.h"

@implementation iHResponseSuccess

@synthesize serviceName, status, errorInfo, userInfoDic, reserve;

- (void)dealloc
{
    [serviceName release];
    [status release];
    [errorInfo release];
    [userInfoDic release];
    [super dealloc];
}

- (id)initWithDic: (NSDictionary *)dic
{
    NSAssert(dic != nil, @"iHResponseSuccess' init data Dictionary is not empty");
    self = [super init];
    if (self) {
        self.serviceName = [dic objectForKey:@"serviceName"];
        self.status = [dic objectForKey:@"status"];
        self.errorInfo = [dic objectForKey:@"errmsg"];
        self.userInfoDic = [NSDictionary dictionaryWithDictionary:dic];
    }
    return self;
}

@end

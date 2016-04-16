//
//  iHResponseSuccess.h
//  iHakula
//
//  Created by Wayde Sun on 2/21/13.
//  Copyright (c) 2013 iHakula. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "iHResponseProtocol.h"

@interface iHResponseSuccess : NSObject <iHResponseProtocol>{
    
    NSString *serviceName;
    NSString *status;
    NSString *errorInfo;
    NSDictionary *userInfoDic;
    id reserve;
}

@property(nonatomic, retain) NSString *serviceName;
@property(nonatomic, retain) NSString *status;
@property(nonatomic, retain) NSString *errorInfo;
@property(nonatomic, retain) NSDictionary *userInfoDic;
@property(nonatomic, assign) id reserve;


- (id)initWithDic: (NSDictionary *)dic;

@end

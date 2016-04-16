//
//  iHResponseFailure.h
//  iHakula
//
//  Created by Wayde Sun on 2/21/13.
//  Copyright (c) 2013 iHakula. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "iHResponseProtocol.h"

@interface iHResponseFailure : NSObject <iHResponseProtocol> {
    NSString *serviceName;
    NSString *status;
    NSString *errorCode;
    NSString *errorInfo;
    id reserve;
}

@property(nonatomic, retain) NSString *serviceName;
@property(nonatomic, retain) NSString *status;
@property(nonatomic, retain) NSString *errorCode;
@property(nonatomic, retain) NSString *errorInfo;
@property(nonatomic, assign) id reserve;

- (id)initWithDic: (NSDictionary *)dic;

@end

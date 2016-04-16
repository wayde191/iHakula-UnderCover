//
//  iHNetworkMonitor.h
//  iHakula
//
//  Created by Wayde Sun on 2/21/13.
//  Copyright (c) 2013 iHakula. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Reachability;
@interface iHNetworkMonitor : NSObject {
    BOOL isReachable;
    BOOL isUsing3G;
    
    //Host url
    NSString *hostUrl;
    NSString *networkTrafficInfo;
    
@private
    Reachability *theReachability;
    int networkStatus;
}

@property(nonatomic, retain) Reachability *theReachability;
@property(nonatomic, assign) BOOL isReachable;
@property(nonatomic, assign) BOOL isUsing3G;
@property(nonatomic, retain) NSString *hostUrl;
@property(nonatomic, retain) NSString *networkTrafficInfo;

- (void)startNotifer;
- (void)restore;
- (void)buildNetworkTrafficInfo: (Reachability *)currReach;

@end

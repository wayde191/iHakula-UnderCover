//
//  JBaseModel.m
//  Journey
//
//  Created by Wayde Sun on 6/30/13.
//  Copyright (c) 2013 iHakula. All rights reserved.
//

#import "JBaseModel.h"
#import "UCAppDelegate.h"

@implementation JBaseModel

#pragma mark - Rewrite super methods
- (BOOL)doCallService:(NSString *)serviceName withParameters:(NSDictionary *)paraDic andServiceUrl:(NSString *)serviceUrl forDelegate:(id)theDelegate {
    if ([super doCallService:serviceName withParameters:paraDic andServiceUrl:serviceUrl forDelegate:theDelegate]) {
       // [self showMessage:LOCALIZED_DEFAULT_SYSTEM_TABLE(@"RequestSending")];
    } else {
      //  [self showMessage:LOCALIZED_DEFAULT_SYSTEM_TABLE(@"CheckNetWork")];
       // [self performSelector:@selector(hideMessage) withObject:nil afterDelay:1.3];
    }
    return YES;
}

- (BOOL)doCallHttpService:(NSString *)serviceName withParameters:(NSDictionary *)paraDic andServiceUrl:(NSString *)serviceUrl forDelegate:(id)theDelegate {
    if ([super doCallHttpService:serviceName withParameters:paraDic andServiceUrl:serviceUrl forDelegate:theDelegate]) {
        [self showMessage:LOCALIZED_DEFAULT_SYSTEM_TABLE(@"RequestSending")];
    } else {
        [self showMessage:LOCALIZED_DEFAULT_SYSTEM_TABLE(@"CheckNetWork")];
        [self performSelector:@selector(hideMessage) withObject:nil afterDelay:1.3];
    }
    
    return YES;
}

- (void)showMessage:(NSString *)msg {
//    UCAppDelegate *appDelegate = [UCAppDelegate getSharedAppDelegate];
//    [appDelegate.customerMessageStatusBar showMessage:msg];
}

- (void)hideMessage {
//    UCAppDelegate *appDelegate = [UCAppDelegate getSharedAppDelegate];
//    [appDelegate.customerMessageStatusBar hide];
}

#pragma mark - iHRequestDelegate
- (void)requestDidStarted {
    // Should be rewritten by subclass
}

- (void)requestDidCanceld {
    [super requestDidCanceld];
    [self showMessage:LOCALIZED_DEFAULT_SYSTEM_TABLE(@"RequestCanceled")];
    [self performSelector:@selector(hideMessage) withObject:nil afterDelay:1.3];
}

- (void)requestDidFinished:(iHResponseSuccess *)response {
    switch ([response.status intValue]) {
        case SERVICE_OPERATION_SUCC:
            [self serviceCallSuccess:response];
            break;
        default:
            [self serviceCallFailed:response];
            break;
    }
}

- (void)requestDidFailed:(iHResponseFailure *)response {
    [self showMessage:response.errorInfo];
    [self performSelector:@selector(hideMessage) withObject:nil afterDelay:1.3];
}

#pragma mark - Service call finished result handler
- (void)serviceCallFailed:(iHResponseSuccess *)response {
    
    NSString *msg = @"";
    switch ([response.status intValue]) {
        case iHServiceErrorSystemBusy:
            msg = LOCALIZED_DEFAULT_SYSTEM_TABLE(@"iHServiceErrorSystemBusy");
            break;
        case iHServiceErrorFeedbackEmpty:
            msg = LOCALIZED_DEFAULT_SYSTEM_TABLE(@"iHServiceErrorFeedbackEmpty");
            break;
        case iHServiceErrorCallTimesEmpty:
            msg = @"";
            break;
        default:
            msg = response.errorInfo;
            break;
    }
    if (![msg isEqualToString:@""]) {
        [self showMessage:msg];
    }
    [self performSelector:@selector(hideMessage) withObject:nil afterDelay:1.3];
}

- (void)serviceCallSuccess:(iHResponseSuccess *)response {
    return;
    [self showMessage:LOCALIZED_DEFAULT_SYSTEM_TABLE(@"submitSuccess")];
    [self performSelector:@selector(hideMessage) withObject:nil afterDelay:1.3];
}



@end

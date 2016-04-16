//
//  JUser.h
//  Journey
//
//  Created by Wayde Sun on 7/1/13.
//  Copyright (c) 2013 iHakula. All rights reserved.
//

#import "JBaseModel.h"

@interface JUser : JBaseModel {
    NSString *_platform;
    NSString *_os;
    NSString *_device;
}

@property (nonatomic, strong) NSString *appId;
@property (nonatomic, strong) NSString *language;

- (void)doCallFeedbackService:(NSString *)feedback;
- (void)doUploadToken;
- (void)doCallGetAppIdService;

@end

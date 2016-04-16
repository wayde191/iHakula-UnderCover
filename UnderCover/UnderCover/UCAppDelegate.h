//
//  UCAppDelegate.h
//  UnderCover
//
//  Created by Wayde Sun on 7/16/13.
//  Copyright (c) 2013 iHakula. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iHCDataManager.h"
#import "iHStatusBarWindow.h"
#import "JUser.h"

@class JUser;
@interface UCAppDelegate : UIResponder <UIApplicationDelegate, UITabBarControllerDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UITabBarController *tabBarController;

@property (strong, nonatomic) JUser *user;
@property (strong, nonatomic) iHStatusBarWindow *customerMessageStatusBar;
@property (strong, nonatomic) iHCDataManager *cdataManager;

+ (UCAppDelegate *)getSharedAppDelegate;

@end

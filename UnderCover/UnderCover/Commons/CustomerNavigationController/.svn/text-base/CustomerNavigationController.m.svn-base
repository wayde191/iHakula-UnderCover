//
//  CustomerNavigationController.m
//  UnderCover
//
//  Created by Wayde Sun on 7/17/13.
//  Copyright (c) 2013 iHakula. All rights reserved.
//

#import "CustomerNavigationController.h"

@implementation CustomerNavigationController

+ (UINavigationController *)createSystemNavigationController:(id)rootViewController {
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:rootViewController];
    [nav.navigationBar setBackgroundImage:[UIImage imageNamed:@"Navbar_BG.png"] forBarMetrics:UIBarMetricsDefault];
    [nav.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                RGBCOLOR(89, 89, 89), UITextAttributeTextColor,
                                                [UIColor whiteColor], UITextAttributeTextShadowColor,
                                                [NSValue valueWithUIOffset:UIOffsetMake(1.0f, 0.5f)], UITextAttributeTextShadowOffset,
                                                nil]];
    return nav;
}

@end

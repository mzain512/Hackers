//
//  WZAppDelegate.m
//  Hackers
//
//  Created by Weiran Zhang on 02/11/2012.
//  Copyright (c) 2012 Weiran Zhang. All rights reserved.
//

#import "WZAppDelegate.h"
#import <GCOLaunchImageTransition/GCOLaunchImageTransition.h>

#if NDEBUG
#import <Crashlytics/Crashlytics.h>
#endif

@implementation WZAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
#if NDEBUG
    [Crashlytics startWithAPIKey:@"6b3b4eba8698666ed08b19d6091a9728deaabab9"];
#endif
    
    [[UINavigationBar appearance] setTintColor:[UIColor colorWithWhite:0.87 alpha:1]];
    [[UIToolbar appearance] setTintColor:[UIColor colorWithWhite:0.87 alpha:1]];
    [[UINavigationBar appearance] setTitleTextAttributes:@{
                                    UITextAttributeFont : [UIFont fontWithName:kNavigationFontName size:kNavigationFontSize],
                               UITextAttributeTextColor : [UIColor blackColor],
                        UITextAttributeTextShadowColor  : [UIColor clearColor]
                                    }];
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"navbar-bg.png"] forBarMetrics:UIBarMetricsDefault];
    [[UIToolbar appearance] setBackgroundImage:[UIImage imageNamed:@"navbar-bg.png"] forToolbarPosition:UIToolbarPositionAny barMetrics:UIBarMetricsDefault];
    [[UIBarButtonItem appearance] setTitleTextAttributes:@{
                               UITextAttributeTextColor : [UIColor blackColor],
                        UITextAttributeTextShadowColor  : [UIColor clearColor]
     }
                                                forState:UIControlStateNormal];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [GCOLaunchImageTransition transitionWithDuration:0.3 style:GCOLaunchImageTransitionAnimationStyleFade];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Saves changes in the application's managed object context before the application terminates.
}

@end

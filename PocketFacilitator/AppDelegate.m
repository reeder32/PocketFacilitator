//
//  AppDelegate.m
//  PocketFacilitator
//
//  Created by Nick Reeder on 10/30/15.
//  Copyright © 2015 Nick Reeder. All rights reserved.
//

#import "AppDelegate.h"
#import "UIColor+UIColor_SynergoColors.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //app background view color
    [[UIWindow appearance] setBackgroundColor:[UIColor synergoGrayColor]];
   
    //unselected icon tint color
    [[UIView appearanceWhenContainedInInstancesOfClasses:@[[UITabBar class]]] setTintColor:[UIColor synergoGrayColor]];
    
    //selected tint color
    [[UITabBar appearance] setTintColor:[UIColor synergoBlueColor]];
    
    //text tint color
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor synergoGrayColor], NSForegroundColorAttributeName, nil]
                                             forState:UIControlStateNormal];
    //background tint color
    [[UITabBar appearance] setBarTintColor:[UIColor synergoBrownColor]];
    
    //setup navigation appearance
    UINavigationBar.appearance.barTintColor = [UIColor synergoBrownColor];
    UINavigationBar.appearance.tintColor = [UIColor synergoBlueColor];
   
    NSDictionary *textAttributes = @{ NSForegroundColorAttributeName       : [UIColor synergoBlueColor],
                                      NSFontAttributeName            : [UIFont fontWithName:@"Helvetica" size:15.0]
                                      };
    UINavigationBar.appearance.titleTextAttributes = textAttributes;
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
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end

//
//  AppDelegate.m
//  momentsapp
//
//  Created by M.A.D on 3/3/12.
//  Copyright (c) 2012 AppDesignVault. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

@synthesize window = _window;

- (void)customizeGlobalTheme{
    [[UITabBar appearance] setBackgroundImage:[UIImage imageNamed:@"tabbar"]];
    
    [[UITabBar appearance] setSelectionIndicatorImage:[UIImage imageNamed:@"highlightes"]];
    
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"menubar"] forBarMetrics:UIBarMetricsDefault];
   
    [[UISearchBar appearance] setTintColor:[UIColor colorWithRed:0.157 green:0.608 blue:0.773 alpha:1.000]];
    
    [[UINavigationBar appearance] setTintColor:[UIColor colorWithRed:0.149 green:0.651 blue:0.808 alpha:1.000]];
    
    [[UITableView appearance] setBackgroundColor:[UIColor colorWithRed:0.906 green:0.922 blue:0.949 alpha:1.000]];
    
    [[UIToolbar appearance]setBackgroundImage:[UIImage imageNamed:@"menubar"] forToolbarPosition:UIToolbarPositionAny barMetrics:UIBarMetricsDefault];
    
    [[UISegmentedControl appearance] setBackgroundImage:[UIImage imageNamed:@"bar_pink"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    [[UISegmentedControl appearance] setDividerImage:[UIImage imageNamed:@"seperator"] forLeftSegmentState:UIControlStateNormal rightSegmentState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    [[UISwitch appearance] setOnTintColor:[UIColor colorWithRed:233/255.0 green:107/255.0 blue:149/255.0 alpha:1.0]];
    
    UIImage *minImage = [[UIImage imageNamed:@"slider-fill.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 10, 0, 10)];
    UIImage *maxImage = [UIImage imageNamed:@"slider-track.png"];
    UIImage *thumbImage = [UIImage imageNamed:@"slider-knob.png"];
    
    [[UISlider appearance] setMaximumTrackImage:maxImage forState:UIControlStateNormal];
    [[UISlider appearance] setMinimumTrackImage:minImage forState:UIControlStateNormal];
    [[UISlider appearance] setThumbImage:thumbImage forState:UIControlStateNormal];
    
    UIImage* tabBarBackground = [UIImage imageNamed:@"tabbar-frame.png"];
    [[UITabBar appearance] setBackgroundImage:tabBarBackground];
    
    
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    // Override point for customization after application launch.
    [self customizeGlobalTheme];
    
    
    [Parse setApplicationId:@""
                  clientKey:@""];
    
    [application registerForRemoteNotificationTypes:
     UIRemoteNotificationTypeBadge |
     UIRemoteNotificationTypeAlert |
     UIRemoteNotificationTypeSound];
    
    return YES;
}


- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)newDeviceToken
{
    // Store the deviceToken in the current installation and save it to Parse.
    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    [currentInstallation setDeviceTokenFromData:newDeviceToken];
    [currentInstallation saveInBackground];
}

- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [PFPush handlePush:userInfo];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end

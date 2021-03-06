//
//  AppDelegate.m
//  Jukebox
//
//  Created by Brian Shim on 2015-12-04.
//  Copyright © 2015 Pivotal. All rights reserved.
//

#import "AppDelegate.h"
#import <Blindside.h>
#import "MQDataModule.h"
#import "MQModule.h"
#import "UIColor+MQ.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (id<BSModule>)module {
    if (!_module) {
        _module = [[MQModule alloc] init];
    }
    return _module;
}

- (id<BSInjector>)injector {
    if (!_injector) {
        _injector = [Blindside injectorWithModule:self.module];
    }
    return _injector;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    // style back button
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)
                                                         forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setTranslucent:YES];
    [[UINavigationBar appearance] setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setTintColor:[UIColor mqWhiteColor]];
    [[UINavigationBar appearance] setTitleTextAttributes:@{  NSForegroundColorAttributeName: [UIColor mqWhiteColor], NSFontAttributeName:[UIFont boldSystemFontOfSize:20]}];
    UITextField *textField = [UITextField appearanceWhenContainedInInstancesOfClasses:@[[UISearchBar class]]];
    [textField setTextColor:[UIColor mqWhiteColor]];
    
    [MQDataModule sharedInstance];
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

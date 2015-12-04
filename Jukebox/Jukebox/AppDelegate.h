//
//  AppDelegate.h
//  Jukebox
//
//  Created by Brian Shim on 2015-12-04.
//  Copyright © 2015 Pivotal. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BSInjector;
@protocol BSModule;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) id<BSInjector> injector;
@property (strong, nonatomic) id<BSModule> module;

@end


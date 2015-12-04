//
//  MQModule.m
//  Jukebox
//
//  Created by Brian Shim on 2015-12-04.
//  Copyright © 2015 Pivotal. All rights reserved.
//

#import "MQModule.h"
#import <Blindside.h>
#import "MQConstants.h"
#import "MQDataModule.h"
#import "MQNetworkManager.h"

@implementation MQModule

- (void)configure:(id)binder {
    
    //Networking
    [binder bind:kBaseUrlKey toInstance:[NSURL URLWithString:@"http://jukebox-api.cfapps.io"]];
    [binder bind:[MQDataModule class] withScope:[BSSingleton scope]];
    [binder bind:[MQNetworkManager class] withScope:[BSSingleton scope]];
}


@end

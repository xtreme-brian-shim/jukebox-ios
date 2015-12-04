//
//  MQDataModule.m
//  Jukebox
//
//  Created by Brian Shim on 2015-12-04.
//  Copyright © 2015 Pivotal. All rights reserved.
//

#import "MQDataModule.h"
#import <Blindside.h>
#import "MQNetworkManager.h"
#import "AppDelegate.h"

@interface MQDataModule ()

@property (nonatomic, strong) MQNetworkManager *networkManager;

@end

@implementation MQDataModule

+ (BSInitializer *)bsInitializer {
    return [BSInitializer initializerWithClass:[self class]
                                      selector:@selector(initWithNetworkManager:)
                                  argumentKeys:[MQNetworkManager class], nil];
}

+ (instancetype)sharedInstance {
    AppDelegate *appDelegate = ((AppDelegate *)[UIApplication sharedApplication].delegate);
    return [appDelegate.injector getInstance:[self class]];
}

-(instancetype)initWithNetworkManager:(MQNetworkManager *)networkManager {
    if (self = [super init]) {
        _networkManager = networkManager;
    }
    return self;
}

-(void)fetchSongsWithQuery:(NSString *)query success:(SuccssBlock)success failure:(FailureBlock)failure {
    [self.networkManager fetchSongsWithQuery:query success:success failure:failure];
}

@end

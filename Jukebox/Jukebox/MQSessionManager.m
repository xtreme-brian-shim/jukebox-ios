//
//  MQSessionManager.m
//  Jukebox
//
//  Created by Brian Shim on 2015-12-04.
//  Copyright © 2015 Pivotal. All rights reserved.
//

#import "MQSessionManager.h"
#import <Blindside.h>
#import "MQConstants.h"

@implementation MQSessionManager

+ (BSInitializer *)bsInitializer {
    return [BSInitializer initializerWithClass:[self class]
                                      selector:@selector(initWithBaseURL:)
                                  argumentKeys:
            kBaseUrlKey,
            nil];
}

- (instancetype)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (self) {
        self.requestSerializer = [AFHTTPRequestSerializer serializer];
        self.responseSerializer = [AFJSONResponseSerializer serializer];
        [self.securityPolicy setAllowInvalidCertificates:YES];
        [self.securityPolicy setValidatesDomainName:NO];
    }
    return self;
}

@end

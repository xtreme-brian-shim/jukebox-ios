//
//  MQSessionManager.h
//  Jukebox
//
//  Created by Brian Shim on 2015-12-04.
//  Copyright © 2015 Pivotal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MQConstants.h"

@interface MQNetworkManager : NSObject

- (void)fetchSongsWithQuery:(NSString *)query
                    success:(SuccssBlock)success
                    failure:(FailureBlock)failure;

@end

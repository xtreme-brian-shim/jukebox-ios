//
//  MQDataModule.h
//  Jukebox
//
//  Created by Brian Shim on 2015-12-04.
//  Copyright © 2015 Pivotal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MQConstants.h"

@interface MQDataModule : NSObject

+ (instancetype)sharedInstance;
-(void)fetchSongsWithQuery:(NSString *)query success:(SuccssBlock)success failure:(FailureBlock)failure;
-(void)fetchQueueWithSuccess:(SuccssBlock)success failure:(FailureBlock)failure;
-(void)fetchCurrentlyPlayingSuccess:(SuccssBlock)success failure:(FailureBlock)failure;
-(void)upvoteSongID:(NSString *)songID WithSuccess:(SuccssBlock)success failure:(FailureBlock)failure;

@end

//
//  MQSessionManager.m
//  Jukebox
//
//  Created by Brian Shim on 2015-12-04.
//  Copyright © 2015 Pivotal. All rights reserved.
//

#import "MQNetworkManager.h"
#import "MQDataModule.h"
#import <Blindside.h>
#import "MQSessionManager.h"
#import "MTLJSONAdapter.h"
#import "Song.h"
#import "SearchResult.h"
#import "NSArray+PivotalCore.h"


@interface MQNetworkManager ()

@property (nonatomic, strong) MQSessionManager *sessionManager;

@end

@implementation MQNetworkManager

+ (BSInitializer *)bsInitializer {
    return [BSInitializer initializerWithClass:[self class]
                                      selector:@selector(initWithSessionManager:)
                                  argumentKeys:
            [MQSessionManager class],
            nil];;
}

- (instancetype)initWithSessionManager:(MQSessionManager *)sessionManager {
    self = [super init];
    if (self) {
        _sessionManager = sessionManager;
    }
    return self;
}

#pragma mark - Song list
- (void)fetchSongsWithQuery:(NSString *)query
                  success:(SuccssBlock)success
                  failure:(FailureBlock)failure {
    
    NSDictionary *params = @{@"q": query};
    
    [self.sessionManager GET:[NSString stringWithFormat:@"search"]
                  parameters:params
                     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                         NSLog(@"Fetching song list success");
                         NSArray *resultArray = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:NULL];
                         NSArray *songs = [resultArray map:^id(NSDictionary *songJson) {
                             NSError *error;
                             Song *song = [MTLJSONAdapter modelOfClass:SearchResult.class fromJSONDictionary:songJson error:&error];
                             if (error) {
                                 NSLog(@"failed to parse Song from list");
                                 return NULL;
                             } else {
                                 return song;
                             }
                         }];
                         if (success) {
                             success(songs);
                         }
                     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                         NSLog(@"Fetching song list failed with error: %@", error);
                         if (failure) {
                             failure(error);
                         }
                     }];
}

-(void)fetchQueueWithSuccess:(SuccssBlock)success failure:(FailureBlock)failure {
    [self.sessionManager GET:[NSString stringWithFormat:@"queue"]
                  parameters:nil
                     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                         NSLog(@"Fetching queue success");
                         NSArray *resultArray = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:NULL];
                         NSArray *songs = [resultArray map:^id(NSDictionary *songJson) {
                             NSError *error;
                             Song *song = [MTLJSONAdapter modelOfClass:Song.class fromJSONDictionary:songJson error:&error];
                             if (error) {
                                 NSLog(@"failed to parse Song from list");
                                 return NULL;
                             } else {
                                 return song;
                             }
                         }];
                         if (success) {
                             success(songs);
                         }
                     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                         NSLog(@"Fetching song list failed with error: %@", error);
                         if (failure) {
                             failure(error);
                         }
                     }];
}

-(void)fetchCurrentlyPlayingWithSuccess:(SuccssBlock)success failure:(FailureBlock)failure {
    [self.sessionManager GET:[NSString stringWithFormat:@"song"]
                  parameters:nil
                     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                         NSLog(@"Fetching queue success");
                         NSDictionary *resultJson = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:NULL];
                         NSError *error;
                         Song *song = [MTLJSONAdapter modelOfClass:Song.class fromJSONDictionary:resultJson error:&error];
                         
                         if (success) {
                             success(song);
                         }
                     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                         NSLog(@"Fetching song list failed with error: %@", error);
                         if (failure) {
                             failure(error);
                         }
                     }];
}

#pragma mark - Helpers

- (void)parseModelClass:(Class)modelClass
       fromJsonResponse:(NSDictionary *)jsonResponse
                success:(SuccssBlock)success
                failure:(FailureBlock)failure {
    NSError *error = nil;
    id model = [MTLJSONAdapter modelOfClass:modelClass fromJSONDictionary:jsonResponse error:&error];
    if (!error) {
        if (success) {
            success(model);
        }
    } else {
        NSLog(@"Failed to parse class: %@", NSStringFromClass(modelClass));
        failure(error);
    }
}

@end

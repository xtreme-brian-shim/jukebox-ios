//
//  SearchResult.h
//  Jukebox
//
//  Created by Brian Shim on 2015-12-04.
//  Copyright © 2015 Pivotal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MQBaseModel.h"

@interface SearchResult <NSCopying, NSMutableCopying> : MQBaseModel

@property (nonatomic, strong, readonly) NSString *songID;
@property (nonatomic, strong, readonly) NSString *title;
@property (nonatomic, strong, readonly) NSString *artist;
@property (nonatomic, strong, readonly) NSString *album;
@property (nonatomic, strong, readonly) NSString *image;
@property (nonatomic, assign, readonly) time_t length;

@end

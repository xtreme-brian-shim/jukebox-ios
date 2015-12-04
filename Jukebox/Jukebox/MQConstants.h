//
//  MQConstants.h
//  Jukebox
//
//  Created by Brian Shim on 2015-12-04.
//  Copyright © 2015 Pivotal. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^SuccssBlock)(id result);
typedef void (^FailureBlock)(NSError *error);

extern NSString * const kBaseUrlKey;
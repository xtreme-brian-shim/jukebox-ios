//
//  MQBaseModel.h
//  Jukebox
//
//  Created by Brian Shim on 2015-12-04.
//  Copyright © 2015 Pivotal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle/Mantle.h>

@interface MQBaseModel : MTLModel <MTLJSONSerializing>

+ (NSDictionary *)JSONKeyPathsByPropertyKey;

@end

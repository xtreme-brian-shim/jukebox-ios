//
//  Song.h
//  Jukebox
//
//  Created by Brian Shim on 2015-12-04.
//  Copyright © 2015 Pivotal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Song : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *artist;
@property (nonatomic, strong) NSString *album;
@property (nonatomic, strong) NSString *image;
@property (nonatomic, strong) NSString *streamUrl;
@property (nonatomic, assign) time_t length;

-(instancetype) initWithTitle:(NSString *)title artist:(NSString *)artist album:(NSString *)album image:(NSString *)image streamUrl:(NSString *)streamUrl length:(time_t)length;


@end

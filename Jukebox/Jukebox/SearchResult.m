//
//  SearchResult.m
//  Jukebox
//
//  Created by Brian Shim on 2015-12-04.
//  Copyright © 2015 Pivotal. All rights reserved.
//

#import "SearchResult.h"

@interface SearchResult ()

@property (nonatomic, strong) NSString *songID;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *artist;
@property (nonatomic, strong) NSString *album;
@property (nonatomic, strong) NSString *image;
@property (nonatomic, assign) time_t length;

@end

@implementation SearchResult
//
//-(instancetype) initWithTitle:(NSString *)title artist:(NSString *)artist album:(NSString *)album image:(NSString *)image streamUrl:(NSString *)streamUrl length:(time_t)length {
//    if (self = [super init]) {
//        self.title = title;
//        self.artist = artist;
//        self.album = album;
//        self.image = image;
//        self.length = length;
//    }
//    return self;
//}

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"songID" : @"id",
             @"title" : @"title",
             @"artist" : @"artist",
             @"album" : @"album",
             @"image" : @"thumbnail",
             @"length" : @"length",
             };
}

@end

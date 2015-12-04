//
//  QueueCell.h
//  Jukebox
//
//  Created by Brian Shim on 2015-12-04.
//  Copyright © 2015 Pivotal. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Song;

@interface QueueCell : UITableViewCell

- (void)configureWithSong:(Song *)song;

@end

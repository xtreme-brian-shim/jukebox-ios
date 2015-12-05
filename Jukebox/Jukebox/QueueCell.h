//
//  QueueCell.h
//  Jukebox
//
//  Created by Brian Shim on 2015-12-04.
//  Copyright © 2015 Pivotal. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Song;

@protocol QueueCellDelegate

-(void)didTouchAddSong:(Song *)song;

@end

@interface QueueCell : UITableViewCell

@property (nonatomic, weak) id<QueueCellDelegate> queueCellDelegate;

- (void)configureWithSong:(Song *)song;

@end

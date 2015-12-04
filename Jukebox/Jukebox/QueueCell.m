//
//  QueueCell.m
//  Jukebox
//
//  Created by Brian Shim on 2015-12-04.
//  Copyright © 2015 Pivotal. All rights reserved.
//

#import "QueueCell.h"
#import "Song.h"

@interface QueueCell ()

@property (weak, nonatomic) IBOutlet UIImageView *thumbnail;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *artistLabel;

@property (nonatomic, strong) Song *song;
@end

@implementation QueueCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)configureWithSong:(Song *)song {
    self.song = song;
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.song.image]];
    self.thumbnail.image = [UIImage imageWithData:data];
    self.titleLabel.text = self.song.title;
    self.artistLabel.text = self.song.artist;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

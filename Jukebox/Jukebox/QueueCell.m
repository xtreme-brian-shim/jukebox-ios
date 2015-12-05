//
//  QueueCell.m
//  Jukebox
//
//  Created by Brian Shim on 2015-12-04.
//  Copyright © 2015 Pivotal. All rights reserved.
//

#import "QueueCell.h"
#import "Song.h"
#import "SearchResult.h"


@interface QueueCell ()

@property (weak, nonatomic) IBOutlet UIImageView *thumbnail;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *artistLabel;
@property (weak, nonatomic) IBOutlet UIButton *addButton;

@property (nonatomic, strong) Song *song;
@end

@implementation QueueCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)configureWithSong:(Song *)song {
    self.song = song;
    if (song.image && song.image.length > 0) {
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.song.image]];
        self.thumbnail.image = [UIImage imageWithData:data];
    } else {
        self.thumbnail.image = [UIImage imageNamed:@"placeholder-album.png"];
    }
    self.titleLabel.text = self.song.title;
    self.artistLabel.text = self.song.artist;
}

- (void) setSelected:(BOOL)selected {
    [super setSelected:selected];
    [self.addButton setSelected:selected];
}

- (IBAction)didTapAddButton:(id)sender {
    [self.queueCellDelegate didTouchAddSong:self.song];
}

@end

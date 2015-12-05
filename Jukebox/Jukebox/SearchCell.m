//
//  SearchCell.m
//  Jukebox
//
//  Created by Brian Shim on 2015-12-04.
//  Copyright © 2015 Pivotal. All rights reserved.
//

#import "SearchCell.h"
#import "SearchResult.h"


@interface SearchCell ()

@property (weak, nonatomic) IBOutlet UIImageView *thumbnail;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *artistLabel;
@property (weak, nonatomic) IBOutlet UIButton *addButton;

@property (nonatomic, strong) SearchResult *searchResult;
@end

@implementation SearchCell

- (void)awakeFromNib {
    // Initialization code
    self.addButton.userInteractionEnabled = NO;
}

- (void)configureWithSong:(SearchResult *)searchResult {
    self.searchResult = searchResult;
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.searchResult.image]];
    self.thumbnail.image = [UIImage imageWithData:data];
    self.titleLabel.text = self.searchResult.title;
    self.artistLabel.text = self.searchResult.artist;
}


- (IBAction)didTapAddButton:(id)sender {
    [self.searchCellDelegate didTouchAddSearchResult:self.searchResult];
}

@end

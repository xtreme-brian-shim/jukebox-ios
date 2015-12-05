//
//  SearchCell.h
//  Jukebox
//
//  Created by Brian Shim on 2015-12-04.
//  Copyright © 2015 Pivotal. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SearchResult;

@protocol SearchCellDelegate

-(void)didTouchAddSearchResult:(SearchResult *)searchResult;

@end

@interface SearchCell : UITableViewCell

@property (nonatomic, weak) id<SearchCellDelegate> searchCellDelegate;

- (void)configureWithSong:(SearchResult *)searchResult;

@end

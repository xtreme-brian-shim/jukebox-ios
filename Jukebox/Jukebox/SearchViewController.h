//
//  SearchViewController.h
//  Jukebox
//
//  Created by Brian Shim on 2015-12-04.
//  Copyright © 2015 Pivotal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchCell.h"

@interface SearchViewController<UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, SearchCellDelegate> : UIViewController

@end

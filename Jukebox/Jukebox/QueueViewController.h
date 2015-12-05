//
//  QueueViewController.h
//  Jukebox
//
//  Created by Brian Shim on 2015-12-04.
//  Copyright © 2015 Pivotal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "QueueCell.h"

@interface QueueViewController<UITableViewDataSource, UITableViewDelegate, QueueCellDelegate> : UIViewController

@end

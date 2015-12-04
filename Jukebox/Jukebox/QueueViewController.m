//
//  QueueViewController.m
//  Jukebox
//
//  Created by Brian Shim on 2015-12-04.
//  Copyright © 2015 Pivotal. All rights reserved.
//

#import "QueueViewController.h"
#import "Song.h"
#import "MQDataModule.h"
#import "QueueCell.h"

@interface QueueViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *albumImageView;
@property (weak, nonatomic) IBOutlet UILabel *songLabel;
@property (weak, nonatomic) IBOutlet UILabel *artistLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *queue;
@property (weak, nonatomic) IBOutlet UIView *noCurrentSongView;

@end

@implementation QueueViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINib *nib = [UINib nibWithNibName:NSStringFromClass([QueueCell class]) bundle:[NSBundle bundleForClass:[self class]]];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"QueueCell"];
    
    [[MQDataModule sharedInstance] fetchQueueWithSuccess:^(id result) {
        if (result) {
            self.queue = result;
            [self.tableView reloadData];
        }
    } failure:^(NSError *error) {
        NSLog(@"failed fetch queue");
    }];
    
    [[MQDataModule sharedInstance] fetchCurrentlyPlayingSuccess:^(id result) {
        if (result) {
            self.queue = result;
            self.noCurrentSongView.hidden = YES;
            [self.tableView reloadData];
        } else {
            [self configureForNoCurrentSong];
        }
    } failure:^(NSError *error) {
        NSLog(@"failed fetch queue");
        [self configureForNoCurrentSong];
    }];
    
}

-(void)configureForNoCurrentSong {
    self.noCurrentSongView.hidden = NO;
}

#pragma mark - UITableViewDelegate/Datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.queue.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Song *song = self.queue[indexPath.row];
    QueueCell *cell = [tableView dequeueReusableCellWithIdentifier:@"QueueCell"];
    [cell configureWithSong:song];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.0f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


@end

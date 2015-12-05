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
@property (nonatomic, strong) Song *currentSong;
@property (weak, nonatomic) IBOutlet UIView *noCurrentSongView;

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation QueueViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINib *nib = [UINib nibWithNibName:NSStringFromClass([QueueCell class]) bundle:[NSBundle bundleForClass:[self class]]];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"QueueCell"];
    
    self.noCurrentSongView.hidden = NO;
    
    [self.timer invalidate];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(fetchQueue) userInfo:nil repeats:YES];
    [self.timer fire];}

- (void) fetchQueue {
    
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
            self.currentSong = result;
            [self configureWithCurrentSong];
            self.noCurrentSongView.hidden = YES;
        } else {
            [self configureForNoCurrentSong];
        }
    } failure:^(NSError *error) {
        NSLog(@"failed fetch queue");
        [self configureForNoCurrentSong];
    }];
}

-(void)configureWithCurrentSong {
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.currentSong.image]];
    self.albumImageView.image = [UIImage imageWithData:data];
    self.songLabel.text = self.currentSong.title;
    self.artistLabel.text = self.currentSong.artist;
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

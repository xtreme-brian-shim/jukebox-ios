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
#import "UIColor+MQ.h"

@interface QueueViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *albumImageView;
@property (weak, nonatomic) IBOutlet UILabel *songLabel;
@property (weak, nonatomic) IBOutlet UILabel *artistLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *queue;
@property (nonatomic, strong) Song *currentSong;
@property (weak, nonatomic) IBOutlet UIView *noCurrentSongView;
@property (weak, nonatomic) IBOutlet UIView *updateView;
@property (weak, nonatomic) IBOutlet UILabel *updateViewLabel;

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation QueueViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = @"MusiQ";
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.view.bounds;
    gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor mqBackgroundColor] CGColor], (id)[[UIColor colorWithRed:96/255.0f green:168/255.0f blue:184/255.0f alpha:1] CGColor], nil];
    [self.view.layer insertSublayer:gradient atIndex:0];
    
    UINib *nib = [UINib nibWithNibName:NSStringFromClass([QueueCell class]) bundle:[NSBundle bundleForClass:[self class]]];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"QueueCell"];
    
    self.noCurrentSongView.hidden = NO;
    
    [self.timer invalidate];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(fetchQueue) userInfo:nil repeats:YES];
    [self.timer fire];
    
    self.updateView.alpha = 0;
    self.updateView.backgroundColor = [UIColor blackColor];

    self.tableView.tableFooterView = [UIView new];
}

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
    cell.queueCellDelegate = self;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.0f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell=(UITableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
    [cell setSelected:YES];
    [self didTouchAddSong:self.queue[indexPath.row]];
}

#pragma mark - QueueCellDelegate

-(void)didTouchAddSong:(Song *)song {
    [[MQDataModule sharedInstance] upvoteSongID:song.songID WithSuccess:^(id result) {
        NSLog(@"upvoted!");
        [UIView animateWithDuration:1 animations:^{
            [self.view bringSubviewToFront:self.updateView];
            self.updateView.alpha = 0.6;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:1 animations:^{
                self.updateView.alpha = 0;
            }];
        }];

    } failure:^(NSError *error) {
        NSLog(@"failed upvote!");
    }];
}

@end

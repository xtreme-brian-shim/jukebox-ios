//
//  QueueViewController.m
//  Jukebox
//
//  Created by Brian Shim on 2015-12-04.
//  Copyright © 2015 Pivotal. All rights reserved.
//

#import "QueueViewController.h"
#import "QueueCell.h"
#import "Song.h"

@interface QueueViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation QueueViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Musi-Q";
    UINib *nib = [UINib nibWithNibName:NSStringFromClass([QueueCell class]) bundle:[NSBundle bundleForClass:[self class]]];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"QueueCell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate/Datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Song *song = [[Song alloc] initWithTitle:@"Smooth Criminal" artist:@"Michael Jackson" album:@"" image:@"https://upload.wikimedia.org/wikipedia/en/3/32/Smooth_criminal_video.jpg" streamUrl:@"" length:200];
    
    QueueCell *cell = [tableView dequeueReusableCellWithIdentifier:@"QueueCell"];
    [cell configureWithSong:song];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

//- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//    
//}
//
//- (nullable NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
//    
//}
//

@end

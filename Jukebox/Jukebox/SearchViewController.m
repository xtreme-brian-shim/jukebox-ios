//
//  SearchViewController.m
//  Jukebox
//
//  Created by Brian Shim on 2015-12-04.
//  Copyright © 2015 Pivotal. All rights reserved.
//

#import "SearchViewController.h"
#import "SearchCell.h"
#import "MQDataModule.h"
#import "SearchResult.h"
#import "MQConstants.h"

@interface SearchViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (nonatomic, strong) NSArray *searchResults;
@property (nonatomic, assign) BOOL isSearching;
@property (nonatomic, assign) BOOL readyToSearch;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingSpinner;
@property (weak, nonatomic) IBOutlet UIView *noSearchResultsView;

@property (nonatomic, strong) NSTimer *timer;
@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Musi-Q";
    _readyToSearch = YES;
    self.noSearchResultsView.hidden = NO;
    
    UINib *nib = [UINib nibWithNibName:NSStringFromClass([SearchCell class]) bundle:[NSBundle bundleForClass:[self class]]];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"SearchCell"];
    
    [self updateSearchQuery];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc;
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

-(void)updateSearchQuery {
    self.isSearching = YES;
    [[MQDataModule sharedInstance] fetchSongsWithQuery:self.searchBar.text success:^(id result) {
        self.searchResults = result;
        [self reloadSearchViews];
//        [self.tableView reloadData];
        self.isSearching = NO;
    } failure: ^(NSError *error){
        NSLog(@"failed to fetch songs for query");
        self.isSearching = NO;
    }];}

#pragma mark - Keyboard Notifications

- (void)keyboardWillShow:(NSNotification *)notification;
{
    NSDictionary *userInfo = [notification userInfo];
    NSValue *keyboardBoundsValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGFloat keyboardHeight = [keyboardBoundsValue CGRectValue].size.height;
    
    CGFloat duration = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    NSInteger animationCurve = [[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue];
    UIEdgeInsets insets = [[self tableView] contentInset];
    [UIView animateWithDuration:duration delay:0. options:animationCurve animations:^{
        [[self tableView] setContentInset:UIEdgeInsetsMake(insets.top, insets.left, keyboardHeight, insets.right)];
        [[self view] layoutIfNeeded];
    } completion:nil];
}

- (void)keyboardWillHide:(NSNotification *)notification;
{
    NSDictionary *userInfo = [notification userInfo];
    CGFloat duration = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    NSInteger animationCurve = [[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue];
    UIEdgeInsets insets = [[self tableView] contentInset];
    [UIView animateWithDuration:duration delay:0. options:animationCurve animations:^{
        [[self tableView] setContentInset:UIEdgeInsetsMake(insets.top, insets.left, 0., insets.right)];
        [[self view] layoutIfNeeded];
    } completion:nil];
}

#pragma mark - UITableViewDelegate/Datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.searchResults.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SearchResult *searchResult = self.searchResults[indexPath.row];
    SearchCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SearchCell"];
    [cell configureWithSong:searchResult];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.0f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (void) reloadSearchViews {
    if (!self.searchResults || self.searchResults.count == 0) {
        self.noSearchResultsView.hidden = NO;
    } else {
        self.noSearchResultsView.hidden = YES;
    }
    [self.tableView reloadData];
}

#pragma mark - UISearchBarDelegate
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {

    if ([searchText length] == 0) {
        self.searchResults = nil;
        [self reloadSearchViews];
        [self performSelector:@selector(hideKeyboardWithSearchBar:) withObject:searchBar afterDelay:0];
    } else {
        [self.timer invalidate];
        self.timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(updateSearchQuery) userInfo:nil repeats:NO];
    }
}

- (void)hideKeyboardWithSearchBar:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
}

- (BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    return !self.isSearching;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self updateSearchQuery];
}

- (void) setIsSearching:(BOOL)isSearching {
    _isSearching = isSearching;
    if (_isSearching) {
        [self.loadingSpinner startAnimating];
    } else {
        [self.loadingSpinner stopAnimating];
    }
}
#pragma  mark - helper

@end
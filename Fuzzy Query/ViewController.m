//
//  ViewController.m
//  Fuzzy Query
//
//  Created by Mille.Yin on 2016/6/18.
//  Copyright © 2016年 Mille.Yin. All rights reserved.
//

#import "ViewController.h"
#import "CGContact.h"

#import "CGContactTool.h"

@interface ViewController () <UISearchBarDelegate>

@property (nonatomic, strong) NSMutableArray *contacts;



- (IBAction)addContactBtn:(id)sender;
@end

@implementation ViewController

-(NSMutableArray *)contacts
{
    if (_contacts == nil) {
        _contacts = (NSMutableArray *)[CGContactTool contact];
        
        if (_contacts == nil) {
            _contacts = [NSMutableArray array];
        }
        
    }
    return _contacts;
}

- (IBAction)addContactBtn:(id)sender {
    NSArray *names = @[@"abcd", @"fjow", @"djioe"];
    
    NSString *name = [NSString stringWithFormat:@"%@%d", names[arc4random_uniform(3)],arc4random_uniform(100)];
    
    NSString *tel = [NSString stringWithFormat:@"1359874%d", arc4random_uniform(10000) + 10000];
    
    CGContact *contact = [CGContact contactWithName:name tel:tel];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.contacts.count inSection:0];
    
    [self.contacts addObject:contact];
    
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];

    [CGContactTool saveDataWithContact:contact];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UISearchBar *searchBar = [[UISearchBar alloc] init];
    searchBar.delegate = self;
    self.navigationItem.titleView = searchBar;
}

#pragma mark - UISearchBarDelegate
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{

    NSString *sql = [NSString stringWithFormat:@"select * from t_contact where name like '%%%@%%' or tel like '%%%@%%';", searchText, searchText];
    _contacts = (NSMutableArray *)[CGContactTool contactWithSql:sql];
    
    [self.tableView reloadData];
}

#pragma mark - UITableViewDateSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.contacts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    CGContact *c = self.contacts[indexPath.row];
    cell.textLabel.text = c.name;
    cell.detailTextLabel.text = c.tel;
    
    return cell;
}
@end
//
//  CHTwitterCoverDemoTableViewController.m
//  TwitterCover
//
//  Created by hangchen on 1/29/14.
//  Copyright (c) 2014 Hang Chen (https://github.com/cyndibaby905)


#import "CHTwitterCoverDemoTableViewController.h"
#import "UIScrollView+TwitterCover.h"


@interface CHTwitterCoverDemoTableViewController ()

@end

@implementation CHTwitterCoverDemoTableViewController
{
    UIView *topView;
}

//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
- (id)initWithStyle:(UITableViewStyle)style
{
    
    self = [super initWithStyle:style];
    if (self) {
        // Custom the table
        
        // The className to query on
        self.parseClassName = @"Post";
        self.textKey = @"text";
        self.title = @"Todos";
        self.pullToRefreshEnabled = YES;
        self.paginationEnabled = YES;
        self.objectsPerPage = 5;
    }

//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        // Custom initialization
//        if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
//            [self setEdgesForExtendedLayout:UIRectEdgeNone];
//        }
//        if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
//            [self setAutomaticallyAdjustsScrollViewInsets:NO];
//        }
//        self.parseClassName = @"Todo";
//        self.textKey = @"text";
//        self.title = @"Todos";
//        self.pullToRefreshEnabled = YES;
//        self.paginationEnabled = YES;
//        self.objectsPerPage = 5;
//    }
    return self;
}

- (id)initWithTopView:(UIView*)view
{
    self = [super init];
    if (self) {
        topView = view;
    }
    return self;
}


- (void)dealloc
{
    [self.tableView removeTwitterCoverView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.tableView addTwitterCoverWithImage:[UIImage imageNamed:@"cover.png"] withTopView:topView];
    
    //This tableHeaderView plays the placeholder role here.
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, CHTwitterCoverViewHeight + topView.bounds.size.height)];
}


#pragma mark - Parse

- (void)objectsDidLoad:(NSError *)error {
    [super objectsDidLoad:error];
    
    // This method is called every time objects are loaded from Parse via the PFQuery
}

- (void)objectsWillLoad {
    [super objectsWillLoad];
    
    // This method is called before a PFQuery is fired to get more objects
}


// Override to customize what kind of query to perform on the class. The default is to query for
// all objects ordered by createdAt descending.
- (PFQuery *)queryForTable {
    PFQuery *query = [PFQuery queryWithClassName:self.parseClassName];
    
    // If no objects are loaded in memory, we look to the cache first to fill the table
    // and then subsequently do a query against the network.
    if ([self.objects count] == 0) {
        query.cachePolicy = kPFCachePolicyCacheThenNetwork;
    }
    
    [query orderByAscending:@"priority"];
    
    return query;
}




//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    return 20;
//}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell
    cell.textLabel.text = [object objectForKey:@"text"];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Priority: %@", [object objectForKey:@"priority"]];
    
    return cell;
}

//- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//    NSString *identifier = @"Cell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
//    if (!cell) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
//    }
//    
//    
//    cell.textLabel.text = [NSString stringWithFormat:@"Cell %d",indexPath.row + 1];
//    
//    return cell;
//}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

//
//  WeightTableViewController.m
//  GroupWeightShare
//
//  Created by Weerasak Witthawaskul on 3/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "WeightTableViewController.h"
#import "MainTabBarViewController.h"
#import "User.h"
#import "Entry.h"

@interface WeightTableViewController ()

@end

@implementation WeightTableViewController
@synthesize tableView=_tableView;
@synthesize user=_user;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.user = ((MainTabBarViewController *)self.parentViewController).user;

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.user = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.user numberOfEntries];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *SimpleTableIdentifier = @"Cell";
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:SimpleTableIdentifier];
    
    NSUInteger row = [indexPath row];
    Entry *weightEntry = (Entry *)[self.user.entries objectAtIndex:row];
    
    UILabel *dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, 200, 20)];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"EEE, MMM d, YYYY"];
    
    dateLabel.text = [dateFormat stringFromDate:weightEntry.date];
    
    UILabel *weightLabel = [[UILabel alloc]initWithFrame:CGRectMake(210, 5, 80, 20)];
    weightLabel.text = weightEntry.weight.description;
    [cell.contentView addSubview:dateLabel];
    [cell.contentView addSubview:weightLabel];
    return cell;
}
@end

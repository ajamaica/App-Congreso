//
//  SecondViewController.m
//  momentsapp
//
//  Created by M.A.D on 3/3/12.
//  Copyright (c) 2012 AppDesignVault. All rights reserved.
//

#import "MomentsViewController.h"
#import "MomentCell.h"
#import "DataLoader.h"

@interface MomentsViewController ()

@end

@implementation MomentsViewController

@synthesize moments;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITabBarItem *tabBarItem = (self.tabBarController.tabBar.items)[1];
    [tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"moments_icon"] 
             withFinishedUnselectedImage:[UIImage imageNamed:@"moments_icon"]];
    
    UIColor *color = [UIColor colorWithPatternImage:[UIImage tallImageNamed:@"background"]];
    [self.view setBackgroundColor:color];
    
    self.title = @"Moments";
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableHeaderView = headerView;
    
    self.moments = [DataLoader loadMoments];
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [moments count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 200;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 52;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc] init];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"MomentCell";
    MomentCell *cell = (MomentCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if ( cell == nil ){
        NSArray *topObjects = [[NSBundle mainBundle] loadNibNamed:CellIdentifier owner:self options:nil];
        for (id obj in topObjects) {
            if ([obj isKindOfClass:[MomentCell class]]){
                cell = (MomentCell*)obj;
                break;
            }
        }
    }
    
    NSDictionary *moment = moments[indexPath.row];
    
    cell.titleLabel.text = moment[@"title"];
    cell.imageIcon.image = [UIImage imageNamed:moment[@"icon"]];
    cell.dateLabel.text = moment[@"date"];
    if ([moment[@"body"] isEqualToString:@"view1"]) {
        UIView *view1 = nil;
        NSArray *topObjects = [[NSBundle mainBundle] loadNibNamed:@"MomentCarousel" owner:self options:nil];
        view1 = topObjects[0];
        UIScrollView *scroll = (UIScrollView*)[view1 viewWithTag:1];
        scroll.contentSize = CGSizeMake(86 * 6, scroll.frame.size.height);
        [cell.bodyView addSubview:view1];
    }else {
        [cell.bodyView addSubview:view2];
    }
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"Your implementation! :)");
}

@end

//
//  FirstViewController.m
//  momentsapp
//
//  Created by M.A.D on 3/3/12.
//  Copyright (c) 2012 AppDesignVault. All rights reserved.
//

#import "FriendsViewController.h"
#import "GridViewCell.h"
#import "DataLoader.h"

@interface FriendsViewController ()

@end

@implementation FriendsViewController

@synthesize photos;

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITabBarItem *tabBarItem = (self.tabBarController.tabBar.items)[0];
    [tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"friends_icon"] 
             withFinishedUnselectedImage:[UIImage imageNamed:@"friends_icon"]];
    
    UIColor *color = [UIColor colorWithPatternImage:[UIImage tallImageNamed:@"background"]];
    [self.view setBackgroundColor:color];
    
    self.title = @"Friends";
    
    
    
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                                         target:self
                                                                                         action:NULL];
    self.photos = [DataLoader loadPhotos];
    
    gridView.backgroundColor = [UIColor clearColor];
    gridView.gridFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 2, 320, 52)];
    
	gridView.delegate = self;
	gridView.dataSource = self;
    
    [gridView reloadData];
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

#pragma mark -
#pragma mark - GridView Datasource

- (NSUInteger)numberOfItemsInGridView:(AQGridView *)aGridView {
    return [self.photos count];
}

- (CGSize)portraitGridCellSizeForGridView:(AQGridView *)aGridView {
    return (CGSizeMake(69, 69));
}

- (AQGridViewCell *)gridView:(AQGridView *)aGridView cellForItemAtIndex:(NSUInteger)index {    
    static NSString * CellIdentifier = @"GridViewCell";
    
    GridViewCell * cell = (GridViewCell *)[aGridView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if ( cell == nil ){
        cell = [[GridViewCell alloc] initWithFrame: CGRectMake(0.0, 0.0, 69, 69) reuseIdentifier: CellIdentifier];
        cell.selectionGlowColor = [UIColor whiteColor];
    }
    
    id photo = (self.photos)[index];
    [cell setImage:[UIImage imageNamed:photo]];
    
    return cell;
}

#pragma mark - GridView Delegate

- (void)gridView: (AQGridView *)gridView didSelectItemAtIndex:(NSUInteger)index {
    NSLog(@"didSelectItemAtIndex");
    //[self performSegueWithIdentifier:@"detail" sender:self];
}
@end

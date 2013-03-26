//
//  PhotosViewController.m
//  momentsapp
//
//  Created by M.A.D on 3/6/12.
//  Copyright (c) 2012 AppDesignVault. All rights reserved.
//

#import "PhotosViewController.h"

#import "GridViewCell.h"

#import "DataLoader.h"

@interface PhotosViewController ()

@end

@implementation PhotosViewController

@synthesize photos;

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITabBarItem *tabBarItem = (self.tabBarController.tabBar.items)[2];
    [tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"photos_icon"] 
             withFinishedUnselectedImage:[UIImage imageNamed:@"photos_icon"]];
    
    UIColor *color = [UIColor colorWithPatternImage:[UIImage tallImageNamed:@"background"]];
    [self.view setBackgroundColor:color];
    
    self.title = @"Photos";
    
    
    
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                                         target:self
                                                                                         action:NULL];
   
    [photoButton setBackgroundImage:[UIImage imageNamed:@"pink_high_new.png"] forState:UIControlStateNormal];
    
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
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Actions

- (IBAction)btnPressed:(id)sender {
    [profileButton setBackgroundImage:nil forState:UIControlStateNormal];
    [activityButton setBackgroundImage:nil forState:UIControlStateNormal];
    [photoButton setBackgroundImage:nil forState:UIControlStateNormal];
    [friendsButton setBackgroundImage:nil forState:UIControlStateNormal];
    
        [sender setBackgroundImage:[UIImage imageNamed:@"pink_high_new.png"] 
                                 forState:UIControlStateNormal];
    
}

#pragma mark -
#pragma mark - GridView Datasource

- (NSUInteger)numberOfItemsInGridView:(AQGridView *)aGridView {
    return [self.photos count] ;
}

- (CGSize)portraitGridCellSizeForGridView:(AQGridView *)aGridView {
    return (CGSizeMake(70, 70));
}

- (AQGridViewCell *)gridView:(AQGridView *)aGridView cellForItemAtIndex:(NSUInteger)index{
    static NSString * CellIdentifier = @"GridViewCell";
    
    GridViewCell * cell = (GridViewCell *)[aGridView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil) {
        cell = [[GridViewCell alloc] initWithFrame: CGRectMake(0.0, 0.0, 69, 69) reuseIdentifier: CellIdentifier];
        cell.selectionGlowColor = [UIColor whiteColor];
    }
    
    id photo = (self.photos)[index];
    [cell setImage:[UIImage imageNamed:photo]];
    
    return cell;
}


#pragma mark - GridView delegate

- (void)gridView:(AQGridView *)gridView didSelectItemAtIndex:(NSUInteger)index {
    NSLog(@"didSelectItemAtIndex");
    //[self performSegueWithIdentifier:@"detail" sender:self];
}

@end

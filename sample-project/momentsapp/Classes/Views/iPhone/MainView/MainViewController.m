//
//  MainViewController.m
//  momentsapp
//
//  Created by Valentin Filip on 6/14/12.
//  Copyright (c) 2012 Universitatea Babeș-Bolyai. All rights reserved.
//

#import "MainViewController.h"
#import "FriendsViewController.h"
#import "MomentsViewController.h"
#import "PhotosViewController.h"
#import "VideosViewController.h"

@interface MainViewController ()

@property (strong, nonatomic) UITabBarItem  *tabSelected;
@property (strong, nonatomic) id             viewSelected;

@end

@implementation MainViewController

@synthesize tabBar, tabSelected, viewSelected;
@synthesize tabFriends, tabMoments, tabPhotos, tabVideos;

@synthesize friendsNav, momentsNav, photosNav, videosView;

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
   
    
    self.tabBar.alpha = 0.88;
    UIImage *friendsIcon = [UIImage imageNamed:@"bookmark.png"];
    [self.tabFriends setFinishedSelectedImage:friendsIcon withFinishedUnselectedImage:friendsIcon];
    
    UIImage *momentsIcon = [UIImage imageNamed:@"flag.png"];
    [self.tabMoments setFinishedSelectedImage:momentsIcon withFinishedUnselectedImage:momentsIcon];
    
    UIImage *photosIcon = [UIImage imageNamed:@"users.png"];
    [self.tabPhotos setFinishedSelectedImage:photosIcon withFinishedUnselectedImage:photosIcon];
    
    UIImage *videosIcon = [UIImage imageNamed:@"timer.png"];
    [self.tabVideos setFinishedSelectedImage:videosIcon withFinishedUnselectedImage:videosIcon];
    
    [self.tabBar setSelectedItem:self.tabPhotos];
    [self tabBar:self.tabBar didSelectItem:self.tabPhotos];
    
    //STEP 1 Construct Panels
    MYIntroductionPanel *panel = [[MYIntroductionPanel alloc] initWithimage:[UIImage imageNamed:@"SampleImage1"] description:@"Consulta la lista de diputados federales y encuentra al correspondiente de tu zona. Conoce las propuestas por las que han votado y las asistencias que tienen registradas."];
    
    MYIntroductionPanel *panel2 = [[MYIntroductionPanel alloc] initWithimage:[UIImage imageNamed:@"SampleImage2"] description:@"Filtra a todos los diputados por partidos políticos."];
    
    MYIntroductionPanel *panel3 = [[MYIntroductionPanel alloc] initWithimage:[UIImage imageNamed:@"SampleImage3"] description:@"Conoce las comisiones existentes y descubre qué diputados pertenecen a cada una."];

    MYIntroductionPanel *panel4 = [[MYIntroductionPanel alloc] initWithimage:[UIImage imageNamed:@"SampleImage4"] description:@"Sigue de cerca la última sesión donde participaron los diputados y conoce la información sintetizada de cada una de ellas."];

    
    //STEP 2 Create IntroductionView
    
    /*A standard version*/
    /*
     MYIntroductionView *introductionView = [[MYIntroductionView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) headerImage:[UIImage imageNamed:@"SampleHeaderImage.png"] panels:@[panel, panel2] languageDirection:MYLanguageDirectionLeftToRight];
     */
    
    /*A more customized version*/
    
    MYIntroductionView *introductionView = [[MYIntroductionView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) headerText:@"Diputados" panels:@[panel, panel2,panel3,panel4] languageDirection:MYLanguageDirectionLeftToRight];
    [introductionView setBackgroundImage:[UIImage imageNamed:@"SampleBackground"]];
    
    
    //Set delegate to self for callbacks (optional)
    introductionView.delegate = self;
    
    if([[NSUserDefaults standardUserDefaults] boolForKey:@"first"]){
        // SIEMPRE
        //[introductionView showInView:self.view];
    }else{
        [introductionView showInView:self.view];
    }
}

- (void)viewDidUnload {
    [self setTabBar:nil];
    [self setTabSelected:nil];
    [self setTabFriends:nil];
    [self setTabMoments:nil];
    [self setTabPhotos:nil];
    [self setTabVideos:nil];
    [self setViewSelected:nil];
    [self setFriendsNav:nil];
    [self setMomentsNav:nil];
    [self setPhotosNav:nil];
    [self setVideosView:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - UITabBar Delegate

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    if ([item isEqual:self.tabSelected] && [self.viewSelected isKindOfClass:[UINavigationController class]]) {
        [self.viewSelected popToRootViewControllerAnimated:YES];
    }
    
    self.tabSelected = item;
    if ([item isEqual:self.tabFriends]) {
        if (!self.friendsNav) {
            self.friendsNav = [self.storyboard instantiateViewControllerWithIdentifier:@"friendsNav"];
        }
        self.viewSelected = self.friendsNav;
        for (id view in self.view.subviews) {
            if (![view isKindOfClass:[UITabBar class]]) {
                [view removeFromSuperview];
            }
        }
        self.friendsNav.view.frame = self.view.bounds;
        [self.view insertSubview:self.friendsNav.view atIndex:0];
    }
    
    if ([item isEqual:self.tabMoments]) {
        if (!self.momentsNav) {
            self.momentsNav = [self.storyboard instantiateViewControllerWithIdentifier:@"momentsNav"];
        }
        self.viewSelected = self.momentsNav;
        for (id view in self.view.subviews) {
            if (![view isKindOfClass:[UITabBar class]]) {
                [view removeFromSuperview];
            }
        }
        self.momentsNav.view.frame = self.view.bounds;
        [self.view insertSubview:self.momentsNav.view atIndex:0];
    }
    
    if ([item isEqual:self.tabPhotos]) {
        if (!self.photosNav) {
            self.photosNav = [self.storyboard instantiateViewControllerWithIdentifier:@"photosNav"];
        }
        self.viewSelected = self.photosNav;
        for (id view in self.view.subviews) {
            if (![view isKindOfClass:[UITabBar class]]) {
                [view removeFromSuperview];
            }
        }
        self.photosNav.view.frame = self.view.bounds;
        [self.view insertSubview:self.photosNav.view atIndex:0];
    }
    
    if ([item isEqual:self.tabVideos]) {
        if (!self.videosView) {
            self.videosView = [self.storyboard instantiateViewControllerWithIdentifier:@"videosView"];
        }
        self.viewSelected = self.videosView;
        for (id view in self.view.subviews) {
            if (![view isKindOfClass:[UITabBar class]]) {
                [view removeFromSuperview];
            }
        }
        self.videosView.view.frame = self.view.bounds;
        [self.view insertSubview:self.videosView.view atIndex:0];
    }
}

#pragma mark - Sample Delegate Methods

-(void)introductionDidFinishWithType:(MYFinishType)finishType{
    
    if (finishType == MYFinishTypeSkipButton) {
        NSLog(@"Did Finish Introduction By Skipping It");
    }
    else if (finishType == MYFinishTypeSwipeOut){
        NSLog(@"Did Finish Introduction By Swiping Out");
    }
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    [userDefaults setBool:YES forKey:@"first"];
 
    [userDefaults synchronize];
    //One might consider making the introductionview a class variable and releasing it here.
    // I didn't do this to keep things simple for the sake of example.
}

-(void)introductionDidChangeToPanel:(MYIntroductionPanel *)panel withIndex:(NSInteger)panelIndex{
    NSLog(@"%@ \nPanelIndex: %d", panel.Description, panelIndex);
}

@end

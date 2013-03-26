//
//  MainViewController.h
//  momentsapp
//
//  Created by Valentin Filip on 6/14/12.
//  Copyright (c) 2012 Universitatea Babeș-Bolyai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MYIntroductionPanel.h"
#import "MYIntroductionView.h"

@class VideosViewController;

@interface MainViewController : UIViewController<MYIntroductionDelegate>

@property (weak, nonatomic) IBOutlet UITabBar *tabBar;
@property (weak, nonatomic) IBOutlet UITabBarItem *tabFriends;
@property (weak, nonatomic) IBOutlet UITabBarItem *tabMoments;
@property (weak, nonatomic) IBOutlet UITabBarItem *tabPhotos;
@property (weak, nonatomic) IBOutlet UITabBarItem *tabVideos;

@property (strong, nonatomic) UINavigationController    *friendsNav;
@property (strong, nonatomic) UINavigationController    *momentsNav;
@property (strong, nonatomic) UINavigationController    *photosNav;
@property (strong, nonatomic) VideosViewController      *videosView;

@end

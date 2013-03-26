//
//  PhotosViewController.h
//  momentsapp
//
//  Created by M.A.D on 3/6/12.
//  Copyright (c) 2012 AppDesignVault. All rights reserved.
//

#import <UIKit/UIKit.h>


#import "AQGridView.h"

@interface PhotosViewController : UIViewController<AQGridViewDelegate, AQGridViewDataSource>{
    IBOutlet UIButton *profileButton;
    IBOutlet UIButton *activityButton;
    IBOutlet UIButton *photoButton;
    IBOutlet UIButton *friendsButton;
    
    IBOutlet AQGridView * gridView;
}

@property (nonatomic, retain) NSArray *photos;

- (IBAction)btnPressed:(id)sender;

@end

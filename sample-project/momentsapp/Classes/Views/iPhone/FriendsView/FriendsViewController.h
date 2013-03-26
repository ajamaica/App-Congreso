//
//  FirstViewController.h
//  momentsapp
//
//  Created by M.A.D on 3/3/12.
//  Copyright (c) 2012 AppDesignVault. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AQGridView.h"

@interface FriendsViewController : UIViewController<AQGridViewDelegate, AQGridViewDataSource>{
    
    IBOutlet AQGridView * gridView;
}

@property (nonatomic, retain) NSArray *photos;

@end

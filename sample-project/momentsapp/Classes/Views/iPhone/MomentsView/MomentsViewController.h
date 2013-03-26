//
//  SecondViewController.h
//  momentsapp
//
//  Created by M.A.D on 3/3/12.
//  Copyright (c) 2012 AppDesignVault. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MomentsViewController : UITableViewController{
    IBOutlet UIView *headerView;
    
    IBOutlet UIView *view2;
}

@property (nonatomic, retain) NSArray *moments;

@end

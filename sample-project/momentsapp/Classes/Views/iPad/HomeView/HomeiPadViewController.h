//
//  HomeiPadViewController.h
//  momentsapp
//
//  Created by M.A.D on 3/8/12.
//  Copyright (c) 2012 AppDesignVault. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeiPadViewController : UIViewController{
    IBOutlet UIView *commentsView;
    IBOutlet UITableView *table;
    
    IBOutlet UIView *bigPhotoFrame;
    IBOutlet UIImageView *bigPhoto;
    
    IBOutlet UIScrollView *scrollView;
    
}

@property (nonatomic, retain) NSArray *comments;
@property (nonatomic, retain) NSArray *thumbs;

@end

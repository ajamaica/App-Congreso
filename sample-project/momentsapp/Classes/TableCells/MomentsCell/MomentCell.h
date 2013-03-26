//
//  MomentCell.h
//  momentsapp
//
//  Created by M.A.D on 3/8/12.
//  Copyright (c) 2012 AppDesignVault. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MomentCell : UITableViewCell

@property (nonatomic, retain) IBOutlet UILabel       *titleLabel;
@property (nonatomic, retain) IBOutlet UIImageView   *imageIcon;
@property (nonatomic, retain) IBOutlet UIView        *bodyView;
@property (nonatomic, retain) IBOutlet UILabel       *dateLabel;


@end

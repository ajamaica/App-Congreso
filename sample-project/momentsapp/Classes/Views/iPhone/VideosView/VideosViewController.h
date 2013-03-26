//
//  VideosViewController.h
//  momentsapp
//
//  Created by M.A.D on 3/6/12.
//  Copyright (c) 2012 AppDesignVault. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VideosViewController : UIViewController<UITextFieldDelegate>{
    IBOutlet UITextField * textField;
    BOOL toggle;
}

- (IBAction)toggleSwitch:(id)sender;

@end

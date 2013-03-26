//
//  VideosViewController.m
//  momentsapp
//
//  Created by M.A.D on 3/6/12.
//  Copyright (c) 2012 AppDesignVault. All rights reserved.
//

#import "VideosViewController.h"

@interface VideosViewController ()

- (void)customizeTextField;

@end

@implementation VideosViewController

#pragma mark - View lifecycle

- (void)viewDidLoad{
    [super viewDidLoad];
    
    UITabBarItem *tabBarItem = (self.tabBarController.tabBar.items)[3];
    [tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"videos_icon"] 
             withFinishedUnselectedImage:[UIImage imageNamed:@"videos_icon"]];
    
    UIColor *color = [UIColor colorWithPatternImage:[UIImage tallImageNamed:@"background"]];
    [self.view setBackgroundColor:color];
    
    self.title = @"Videos";
    
    [self customizeTextField];
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Visual stuff

- (void)customizeTextField {
    
    [textField setBorderStyle:UITextBorderStyleNone];
    [textField setBackground:[UIImage imageNamed:@"input"]];
    
    [textField setTextColor:[UIColor whiteColor]];
    [textField setFont:[UIFont boldSystemFontOfSize:17]];
    
    textField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 43)];
    textField.leftViewMode = UITextFieldViewModeAlways;
    
    [textField setDelegate:self];
    
    [self.view addSubview:textField];
}

#pragma mark - UITextField delegate

- (BOOL)textFieldShouldReturn:(UITextField *)txtField {
    [txtField resignFirstResponder];
    
    return YES;
}

#pragma mark - Actions

- (IBAction)toggleSwitch:(id)sender {
    UIButton *btn  = sender;
    toggle = !toggle;
    if (toggle) {
        [btn setImage:[UIImage imageNamed:@"switch-on"] forState:UIControlStateNormal];
    } else {
        [btn setImage:[UIImage imageNamed:@"switch-off"] forState:UIControlStateNormal];
    }
}

@end

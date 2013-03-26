//
//  DiputadosViewController.h
//  momentsapp
//
//  Created by Arturo Jamaica Garcia on 17/03/13.
//
//

#import <Parse/Parse.h>
#import "DiputadoCell.h"
#import "UIImageView+WebCache.h"
#import "DiputadosSingleViewController.h"
#import "MYIntroductionPanel.h"
#import "MYIntroductionView.h"
#import "MDAboutController.h"

@interface DiputadosViewController : PFQueryTableViewController<UISearchDisplayDelegate,MYIntroductionDelegate>
@property (weak, nonatomic) IBOutlet UISearchBar *searchbar;
@property (weak, nonatomic) IBOutlet PFQuery *query;
@property (weak, nonatomic) IBOutlet UIButton *a1;
@property (retain, nonatomic) IBOutlet MDAboutController *aboutController;
@property (retain, nonatomic) IBOutlet UIBarButtonItem *left;


@property BOOL *showing;
-(void)addloca;


@end

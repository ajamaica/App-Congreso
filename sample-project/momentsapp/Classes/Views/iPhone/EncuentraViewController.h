//
//  EncuentraViewController.h
//  Diputados
//
//  Created by Arturo Jamaica Garcia on 19/03/13.
//
//

#import <Parse/Parse.h>

@interface EncuentraViewController : PFQueryTableViewController

@property (weak, nonatomic) IBOutlet UISearchBar *searchbar;
@property (weak, nonatomic) IBOutlet PFQuery *query;
@property (nonatomic, strong) PFGeoPoint *userLocation;
@property (weak, nonatomic) IBOutlet UIButton *a1;
@property BOOL *showing;
-(void)addloca;

@end

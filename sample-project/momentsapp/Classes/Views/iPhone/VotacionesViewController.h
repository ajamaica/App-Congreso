//
//  VotacionesViewController.h
//  Diputados
//
//  Created by Arturo Jamaica Garcia on 19/03/13.
//
//

#import <UIKit/UIKit.h>
#import "AFJSONRequestOperation.h"
#import "MBProgressHUD.h"

@interface VotacionesViewController : UITableViewController

@property (strong,nonatomic) NSMutableArray *votaciones;
@property (strong,nonatomic) NSDictionary *data;
@property (strong,nonatomic) PFObject *diputado;
@end

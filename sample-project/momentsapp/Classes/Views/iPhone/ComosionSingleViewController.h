//
//  ComosionSingleViewController.h
//  Diputados
//
//  Created by Arturo Jamaica Garcia on 19/03/13.
//
//

#import <UIKit/UIKit.h>
#import "AFJSONRequestOperation.h"

@interface ComosionSingleViewController : UITableViewController

@property (strong,nonatomic) PFObject  *comision;

@end

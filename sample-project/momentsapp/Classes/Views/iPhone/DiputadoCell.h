//
//  DiputadoCell.h
//  momentsapp
//
//  Created by Arturo Jamaica Garcia on 18/03/13.
//
//

#import <UIKit/UIKit.h>

@interface DiputadoCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nombre;
@property (weak, nonatomic) IBOutlet UILabel *estado;
@property (weak, nonatomic) IBOutlet UILabel *curul;
@property (weak, nonatomic) IBOutlet UILabel *eleccion;
@property (weak, nonatomic) IBOutlet UILabel *partido;
@property (weak, nonatomic) IBOutlet UIImageView *avatar;
@property (weak, nonatomic) IBOutlet UIImageView *partidoimg;

@end

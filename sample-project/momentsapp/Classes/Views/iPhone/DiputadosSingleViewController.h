//
//  DiputadosSingleViewController.h
//  momentsapp
//
//  Created by Arturo Jamaica Garcia on 18/03/13.
//
//

#import <UIKit/UIKit.h>
#import "BrowserViewController.h"
#import <MessageUI/MessageUI.h>

@interface DiputadosSingleViewController : UIViewController<MFMessageComposeViewControllerDelegate,MFMailComposeViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *karma;
@property (weak, nonatomic) IBOutlet UILabel *asistencia;
@property (weak, nonatomic) IBOutlet UILabel *iniciativas;
@property (strong,nonatomic) PFObject *diputado;
@property (weak, nonatomic) IBOutlet UIImageView *avatar;
@property (weak, nonatomic) IBOutlet UILabel *nombre;
@property (weak, nonatomic) IBOutlet UILabel *entidad;
@property (weak, nonatomic) IBOutlet UIImageView *partidoimg;
@property (weak, nonatomic) IBOutlet UILabel *eleccion;
@property (weak, nonatomic) IBOutlet UILabel *curul;
@property (weak, nonatomic) IBOutlet UILabel *email;
@property (weak, nonatomic) IBOutlet UILabel *distrito;
@property (weak, nonatomic) IBOutlet UIButton *twitter;
@property (weak, nonatomic) IBOutlet UIButton *facebook;
- (IBAction)sendmail:(id)sender;

@end

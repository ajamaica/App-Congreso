//
//  DiputadosSingleViewController.m
//  momentsapp
//
//  Created by Arturo Jamaica Garcia on 18/03/13.
//
//

#import "DiputadosSingleViewController.h"
#import "UIImageView+WebCache.h"
#import "AFJSONRequestOperation.h"
#import "VotacionesViewController.h"
#import "ADPopupView.h"
#import <MessageUI/MessageUI.h>
#import "AppDelegate.h"


@interface MailCompose : MFMailComposeViewController {
}
@end

@implementation MailCompose

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return YES;
}

@end

@interface DiputadosSingleViewController ()<ADPopupViewDelegate>{
    NSMutableArray *keysMes;
    NSMutableArray *contentsFechas;
    int puntaje;
    BOOL asis;
    BOOL inicia;
}

@property (nonatomic, strong) ADPopupView *visiblePopup;


@end

@implementation DiputadosSingleViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    asis = NO;
    inicia = NO;
    puntaje = 0;
    keysMes = [NSMutableArray new];
    contentsFechas = [NSMutableArray new];
    
    UIColor *color = [UIColor colorWithPatternImage:[UIImage tallImageNamed:@"background"]];
    [self.view setBackgroundColor:color];
    [self.avatar setImageWithURL:[NSURL URLWithString:[self.diputado objectForKey:@"avatar"]] placeholderImage:nil];
    self.nombre.text = [self.diputado objectForKey:@"nombre"];
    
    self.entidad.text = [[[self.diputado objectForKey:@"entidad"] fetchIfNeeded] objectForKey:@"nombre"];
    
    if([[self.diputado objectForKey:@"fraccion"] isEqualToString:@"PRD"]){
        self.partidoimg.image = [UIImage imageNamed:@"prd01.png"];
    }
    
    if([[self.diputado objectForKey:@"fraccion"] isEqualToString:@"PRI"]){
        self.partidoimg.image = [UIImage imageNamed:@"pri01.png"];
    }
    
    if([[self.diputado objectForKey:@"fraccion"] isEqualToString:@"PAN"]){
        self.partidoimg.image = [UIImage imageNamed:@"pan.png"];
    }
    
    if([[self.diputado objectForKey:@"fraccion"] isEqualToString:@"PANAL"]){
        self.partidoimg.image = [UIImage imageNamed:@"panal.gif"];
    }
    
    if([[self.diputado objectForKey:@"fraccion"] isEqualToString:@"Verde"]){
        self.partidoimg.image = [UIImage imageNamed:@"logvrd.jpg"];
    }
    
    if([[self.diputado objectForKey:@"fraccion"] isEqualToString:@"Movimiento Ciudadano"]){
        self.partidoimg.image = [UIImage imageNamed:@"logo_movimiento_ciudadano.png"];
    }
    
    if([[self.diputado objectForKey:@"fraccion"] isEqualToString:@"PT"]){
        self.partidoimg.image = [UIImage imageNamed:@"logpt.jpg"];
    }
    self.curul.text = [self.diputado objectForKey:@"curul"];
    self.email.text = [self.diputado objectForKey:@"email"];
    self.eleccion.text = [self.diputado objectForKey:@"tipo_de_eleccion"];
    self.distrito.text = [NSString stringWithFormat:@"%@",[self.diputado objectForKey:@"distrito"] ];
    
    if([self.diputado objectForKey:@"twitter"]){
        [self.twitter setEnabled:YES];
        [self.twitter addTarget:self action:@selector(bro:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    if([self.diputado objectForKey:@"facebook_id"]){
        [self.facebook setEnabled:YES];
        [self.facebook addTarget:self action:@selector(brofb:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://congresorest.appspot.com/diputado/%@/proposiciones",[self.diputado objectForKey:@"nu_diputado"]]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFJSONRequestOperation *iniciativasoperation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        
      self.iniciativas.text = [NSString stringWithFormat:@"%lu", (unsigned long)[JSON count]];
        puntaje  = puntaje + [JSON count] * 20;
        inicia = YES;
        
        if(asis && inicia){
            self.karma.text = [NSString stringWithFormat:@"%i",puntaje];
            [self.diputado setValue:[NSNumber numberWithInt:puntaje] forKey:@"puntaje"];
            [self.diputado saveEventually];
        }
        
        
    } failure:^(NSURLRequest *request , NSURLResponse *response , NSError *error , id JSON)
                                         {
                                             NSLog(@"%@",error.description);
                                             
                                         }];
    [iniciativasoperation start];
    
    
    NSURL *url2 = [NSURL URLWithString:[NSString stringWithFormat:@"http://congresorest.appspot.com/diputado/%@/asistencias",[self.diputado objectForKey:@"nu_diputado"]]];
    NSURLRequest *request2 = [NSURLRequest requestWithURL:url2];
    AFJSONRequestOperation *votosoperation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request2 success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        
        for(id key in JSON){
            [keysMes addObject:key];
            [contentsFechas addObject:[JSON objectForKey:key]];
            
        }
        
        NSMutableArray *dias = [NSMutableArray new];
        for(id array in contentsFechas){
            for (NSDictionary *dia in array) {
                [dias addObject:[dia objectForKey:@"estado"]];
            }
        }
        
        int ina = 0;
        for (NSString *dia in dias) {
            if([dia isEqualToString:@"I"]){
                ina++;
                puntaje = puntaje - 10;
            }else{
                puntaje = puntaje + 3;
            }
        }
        int total = [dias count];

        self.asistencia.text = [NSString stringWithFormat:@"%i/%i",total-ina,total];
        asis = YES;
        if(asis && inicia){
            self.karma.text = [NSString stringWithFormat:@"%i",puntaje];
            [self.diputado setValue:[NSNumber numberWithInt:puntaje] forKey:@"puntaje"];
            [self.diputado saveEventually];
        }
        
        
    } failure:^(NSURLRequest *request , NSURLResponse *response , NSError *error , id JSON)
                                                    {
                                                        NSLog(@"%@",error.description);
                                                        
                                                    }];
    [votosoperation start];

    
}

-(void)bro:(id)sender{
    BrowserViewController *bvc = [[BrowserViewController alloc] initWithUrls:[NSURL URLWithString:[NSString stringWithFormat:@"http://twitter.com/%@",[self.diputado objectForKey:@"twitter"]]]];
    [self.navigationController pushViewController:bvc animated:YES];
}

-(void)brofb:(id)sender{
    BrowserViewController *bvc = [[BrowserViewController alloc] initWithUrls:[NSURL URLWithString:[NSString stringWithFormat:@"http://facebook.com/%@",[self.diputado objectForKey:@"facebook_id"]]]];
    [self.navigationController pushViewController:bvc animated:YES];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"VotacionesViewController"]){
        VotacionesViewController *vc = [segue destinationViewController];
        [vc setDiputado:self.diputado];
    }
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setAvatar:nil];
    [self setNombre:nil];
    [self setEntidad:nil];
    [self setPartidoimg:nil];
    [self setEleccion:nil];
    [self setCurul:nil];
    [self setEmail:nil];
    [self setDistrito:nil];
    [self setIniciativas:nil];
    [self setAsistencia:nil];
    [self setKarma:nil];
    [self setTwitter:nil];
    [self setTwitter:nil];
    [self setFacebook:nil];
    [super viewDidUnload];
}

#pragma mark TestPopupContentView





- (IBAction)event:(id)sender {
    
    CGPoint point = CGPointMake(125, 54);
    [self presentPopupAtPointWithContentViewAtPoint: point ];
}

- (void)presentPopupAtPointWithContentViewAtPoint:(CGPoint)point{
    
    [self.visiblePopup hide: YES];
    
        
        self.visiblePopup = [[ADPopupView alloc] initAtPoint:point delegate:self withMessage:@"Puntaje asociado al trabajo lejislativo del Diputado."];
        
        [self.visiblePopup showInView: self.view animated: YES];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [self.visiblePopup hide:YES];
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
   
    [self dismissModalViewControllerAnimated:YES];
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    [appDelegate.window.rootViewController dismissModalViewControllerAnimated:YES];
}


- (IBAction)sendmail:(id)sender {
    
    if([MFMailComposeViewController canSendMail]){
        // get a new new MailComposeViewController object
        
        MailCompose *mc = [MailCompose  new];
        
        // his class should be the delegate of the mc
        mc.mailComposeDelegate = self;
    
        // set a mail subject ... but you do not need to do this :)
        [mc setSubject:@"Asunto:  "];
    
        // set some basic plain text as the message body ... but you do not need to do this :)
        [mc setMessageBody:@"- Enviado mediante Diputados de Brounie." isHTML:NO];
    
        // set some recipients ... but you do not need to do this :)
        [mc setToRecipients:[NSArray arrayWithObjects:[self.diputado objectForKey:@"email"], nil]];
        
        [mc setModalPresentationStyle:UIModalPresentationFullScreen];
            
        
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];

        [appDelegate.window.rootViewController presentViewController:mc animated:YES completion:nil];
    }
}
@end

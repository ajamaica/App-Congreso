//
//  ComosionSingleViewController.m
//  Diputados
//
//  Created by Arturo Jamaica Garcia on 19/03/13.
//
//

#import "ComosionSingleViewController.h"
#import "DiputadoCell.h"
#import "UIImageView+WebCache.h"
#import "MBProgressHUD.h"
#import "DiputadosSingleViewController.h"

@interface ComosionSingleViewController (){
    NSMutableArray *keys;
    NSMutableArray *contents;
    NSMutableDictionary *diputados;
}

@end

@implementation ComosionSingleViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    keys = [NSMutableArray new];
    contents = [NSMutableArray new];
    diputados =[NSMutableDictionary new];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://congresorest.appspot.com/comision/%@",[self.comision objectForKey:@"num_comi"]]];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFJSONRequestOperation *iniciativasoperation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        
        NSMutableArray *ids = [NSMutableArray new];
        for(id key in JSON){
            [keys addObject:key];
            [contents addObject:[JSON objectForKey:key]];
            
            for (NSDictionary *ur in [JSON objectForKey:key]) {
                
                NSString *numero = [ur objectForKey:@"num_dip"];
                [ids addObject: [NSNumber numberWithInt:[numero intValue]]];
            }
            
        }
        
        PFQuery *query = [PFQuery queryWithClassName:@"DiputadoP"];
        [query includeKey:@"entidad"];
        [query whereKey:@"nu_diputado" containedIn:ids];
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if(!error){
                for (PFObject *dip in objects) {
                    [diputados setObject:dip forKey:[dip objectForKey:@"nu_diputado"]];
                }
                [self.tableView reloadData];
            }
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
        }];
        
        
    } failure:^(NSURLRequest *request , NSURLResponse *response , NSError *error , id JSON)
                                                    {
                                                        NSLog(@"%@",error.description);
                                                        [MBProgressHUD hideHUDForView:self.view animated:YES];
                                                    }];
    [iniciativasoperation start];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"singledip"]){
        
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        NSString *numero = [[[contents objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"num_dip"];
        PFObject *object = [diputados objectForKey:[NSNumber numberWithInt:[numero intValue]]];
        
        
        DiputadosSingleViewController *vc = [segue destinationViewController];
        [vc setDiputado:object];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [keys count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [[contents objectAtIndex:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *numero = [[[contents objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"num_dip"];
    PFObject *object = [diputados objectForKey:[NSNumber numberWithInt:[numero intValue]]];
    
    static NSString *CellIdentifier = @"DipCell";
    DiputadoCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    
    
    if (cell == nil) {
        cell = [[DiputadoCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell
    cell.nombre.text = [object objectForKey:@"nombre"];
    cell.curul.text = [object objectForKey:@"curul"];
    cell.eleccion.text = [object objectForKey:@"tipo_de_eleccion"];
    [cell.avatar setImageWithURL:[NSURL URLWithString:[object objectForKey:@"avatar"]] placeholderImage:nil];
    cell.estado.text = [[object objectForKey:@"entidad"] objectForKey:@"nombre"];
    
    if([[object objectForKey:@"fraccion"] isEqualToString:@"PRD"]){
        cell.partidoimg.image = [UIImage imageNamed:@"prd01.png"];
    }
    
    if([[object objectForKey:@"fraccion"] isEqualToString:@"PRI"]){
        cell.partidoimg.image = [UIImage imageNamed:@"pri01.png"];
    }
    
    if([[object objectForKey:@"fraccion"] isEqualToString:@"PAN"]){
        cell.partidoimg.image = [UIImage imageNamed:@"pan.png"];
    }
    
    if([[object objectForKey:@"fraccion"] isEqualToString:@"PANAL"]){
        cell.partidoimg.image = [UIImage imageNamed:@"panal.gif"];
    }
    
    if([[object objectForKey:@"fraccion"] isEqualToString:@"Verde"]){
        cell.partidoimg.image = [UIImage imageNamed:@"logvrd.jpg"];
    }
    
    if([[object objectForKey:@"fraccion"] isEqualToString:@"Movimiento Ciudadano"]){
        cell.partidoimg.image = [UIImage imageNamed:@"logo_movimiento_ciudadano.png"];
    }
    
    if([[object objectForKey:@"fraccion"] isEqualToString:@"PT"]){
        cell.partidoimg.image = [UIImage imageNamed:@"logpt.jpg"];
    }
    

    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [keys objectAtIndex:section];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end

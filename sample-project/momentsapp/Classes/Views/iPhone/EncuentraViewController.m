//
//  EncuentraViewController.m
//  Diputados
//
//  Created by Arturo Jamaica Garcia on 19/03/13.
//
//

#import "EncuentraViewController.h"
#import "DiputadoCell.h"
#import "DiputadosSingleViewController.h"
#import "UIImageView+AFNetworking.h"

@interface EncuentraViewController (){
    NSMutableArray *results;

}

@end

@implementation EncuentraViewController


- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        // Custom the table
        
        // The className to query on
        self.className = @"DiputadoP";
        
        // The key of the PFObject to display in the label of the default cell style
        self.textKey = @"nombre";
        
        // Uncomment the following line to specify the key of a PFFile on the PFObject to display in the imageView of the default cell style
        // self.imageKey = @"image";
        
        // Whether the built-in pull-to-refresh is enabled
        self.pullToRefreshEnabled = NO;
        
        // Whether the built-in pagination is enabled
        self.paginationEnabled = NO;
        
        // The number of objects to show per page
        self.objectsPerPage = 510;
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithClassName:@"DiputadoP"];
    self = [super initWithCoder:aDecoder];
    if (self) {
        // The className to query on
        self.showing = YES;
        self.className = @"DiputadoP";
        results = [[NSMutableArray alloc] initWithObjects: nil];
        // The key of the PFObject to display in the label of the default cell style
        self.textKey = @"nombre";
        
        // Whether the built-in pull-to-refresh is enabled
        self.pullToRefreshEnabled = NO;
        
        // Whether the built-in pagination is enabled
        self.paginationEnabled = NO;
        
        // The number of objects to show per page
        self.objectsPerPage = 510;
    }
    return self;
}

// Override to customize what kind of query to perform on the class. The default is to query for
// all objects ordered by createdAt descending.
- (PFQuery *)queryForTable {
   
    if(self.query){
        return self.query;
    }
    PFQuery *query = [PFQuery queryWithClassName:self.className];
    
    // If Pull To Refresh is enabled, query against the network by default.
   
    
    
    if( self.userLocation == nil){
        [query setLimit:0];
    }else{
        [query setLimit:10];
        [query whereKey:@"location" nearGeoPoint:self.userLocation withinKilometers:40.0f];
    }
    
    [query includeKey:@"entidad"];
    
    
    return query;
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    if([self.searchbar.text length] >2){
        [self mockSearch];
    }
    
    return YES;
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller
shouldReloadTableForSearchScope:(NSInteger)searchOption
{
    if([self.searchbar.text length] >2){
        [self mockSearch];
    }
    
    return YES;
}

- (void)mockSearch
{
    results = [[NSMutableArray alloc]initWithObjects: nil];
    for (PFObject *obj in self.objects) {
        
        NSRange rangeValue = [[obj objectForKey:@"nombre"] rangeOfString:self.searchbar.text options:NSCaseInsensitiveSearch];
        if(rangeValue.length > 0 ){
            [results addObject:obj];
        }
    }
    //[self.searchDisplayController.searchResultsTableView reloadData];
}



- (NSInteger)tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)section {
    if (aTableView == self.searchDisplayController.searchResultsTableView){
        return results.count;
    }
    return [self.objects count];
}


-(void)searchDisplayControllerWillBeginSearch:(UISearchDisplayController *)controller{
    [controller.searchResultsTableView registerClass:[DiputadoCell class] forCellReuseIdentifier:@"DipCell"];
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    UIColor *color = [UIColor colorWithPatternImage:[UIImage tallImageNamed:@"background"]];
    [self.view setBackgroundColor:color];
    [PFGeoPoint geoPointForCurrentLocationInBackground:^(PFGeoPoint *geoPoint, NSError *error) {
        if (!error) {
            self.userLocation = geoPoint;
            [self loadObjects];
        }
    }];
    
    
    
	// Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
    
}

-(void)viewWillDisappear:(BOOL)animated{
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




/*
 // Override to customize what kind of query to perform on the class. The default is to query for
 // all objects ordered by createdAt descending.
 - (PFQuery *)queryForTable {
 PFQuery *query = [PFQuery queryWithClassName:self.className];
 
 // If Pull To Refresh is enabled, query against the network by default.
 if (self.pullToRefreshEnabled) {
 query.cachePolicy = kPFCachePolicyNetworkOnly;
 }
 
 // If no objects are loaded in memory, we look to the cache first to fill the table
 // and then subsequently do a query against the network.
 if (self.objects.count == 0) {
 query.cachePolicy = kPFCachePolicyCacheThenNetwork;
 }
 
 [query orderByDescending:@"createdAt"];
 
 return query;
 }
 */


// Override to customize the look of a cell representing an object. The default is to display
// a UITableViewCellStyleDefault style cell with the label being the textKey in the object,
// and the imageView being the imageKey in the object.


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PFObject *object;
    DiputadoCell *cell;
    static NSString *CellIdentifier = @"DipCell";
    
    if(tableView == self.searchDisplayController.searchResultsTableView) {
        
        object = [results objectAtIndex:indexPath.row];
        cell = (DiputadoCell *)[ self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
    }else{
        object = [self.objects objectAtIndex:indexPath.row];
        cell = (DiputadoCell *)[self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    }
    
    
    
    
    if (cell == nil) {
        cell = [[DiputadoCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell
    cell.nombre.text = [object objectForKey:self.textKey];
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

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 72;
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"single"]){
        DiputadosSingleViewController *vc = [segue destinationViewController];
        
        if(sender == self.searchDisplayController.searchResultsTableView) {
            NSIndexPath *i = self.searchDisplayController.searchResultsTableView.indexPathForSelectedRow;
            [vc setDiputado:[results objectAtIndex:i.row]];
        }else{
            NSIndexPath *i = [self.tableView indexPathForSelectedRow];
            [vc setDiputado:[self.objects objectAtIndex:i.row]];
        }
        
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self performSegueWithIdentifier:@"single" sender:tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

/*
 // Override if you need to change the ordering of objects in the table.
 - (PFObject *)objectAtIndex:(NSIndexPath *)indexPath {
 return [self.objects objectAtIndex:indexPath.row];
 }
 */

/*
 // Override to customize the look of the cell that allows the user to load the next page of objects.
 // The default implementation is a UITableViewCellStyleDefault cell with simple labels.
 - (UITableViewCell *)tableView:(UITableView *)tableView cellForNextPageAtIndexPath:(NSIndexPath *)indexPath {
 static NSString *CellIdentifier = @"NextPage";
 
 UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
 
 if (cell == nil) {
 cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
 }
 
 cell.selectionStyle = UITableViewCellSelectionStyleNone;
 cell.textLabel.text = @"Load more...";
 
 return cell;
 }
 */

#pragma mark - UITableViewDataSource

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the object from Parse and reload the table view
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, and save it to Parse
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */



- (void)viewDidUnload {
    [self setSearchbar:nil];
    [super viewDidUnload];
}
@end

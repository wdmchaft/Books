//
//  IndiceView.m
//  Livros
//
//  Created by Thiago Deserto on 1/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "IndiceView.h"
#import "CellOfertas.h"
#import "MainScroll.h"

@implementation IndiceView
@synthesize table;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
    }
    return self;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [dados count];
}
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [table deselectRowAtIndexPath:indexPath animated:YES];
    [pre setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
    
    [self presentModalViewController:pre animated:YES];
}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *SimpleTableIdentifier = @"SimpleTableIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SimpleTableIdentifier];
    
    if (cell == nil) 
    {
        
        cell = [[CellOfertas alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:SimpleTableIdentifier];
    }
    
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    
    NSUInteger row = [indexPath row];
    
    cell.textLabel.text = [[dados objectAtIndex:row] valueForKey:titulo];
    cell.detailTextLabel.text = [[dados objectAtIndex:row] valueForKey:pagina];
    
    return cell;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}
//texto: 
#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    pre = [[MainScroll alloc] init];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"index.png"]]];
    
    titulo = @"Titulo";
    pagina = @"Pagina";
    
    dados = [NSMutableArray new];
    
    NSMutableDictionary* temp = [NSMutableDictionary dictionary];
    
    [temp setValue:@"Yourself" forKey:titulo];
    [temp setValue:@"01" forKey:pagina];
    
    [dados addObject:[NSDictionary dictionaryWithDictionary:temp]];
    
    [temp setValue:@"Exemplo" forKey:titulo];
     [temp setValue:@"04" forKey:pagina]; 
    
    [dados addObject:[NSDictionary dictionaryWithDictionary:temp]];
    
    [temp setValue:@"Exemplo2" forKey:titulo];
    [temp setValue:@"07" forKey:pagina]; 
    
    [dados addObject:[NSDictionary dictionaryWithDictionary:temp]];
    
    [temp setValue:@"Exemplo3" forKey:titulo];
    [temp setValue:@"11" forKey:pagina]; 
    
    [dados addObject:[NSDictionary dictionaryWithDictionary:temp]];
    
    [temp setValue:@"Exemplo4" forKey:titulo];
    [temp setValue:@"14" forKey:pagina]; 
    
    [dados addObject:[NSDictionary dictionaryWithDictionary:temp]];
    
    [temp setValue:@"Exemplo5" forKey:titulo];
    [temp setValue:@"17" forKey:pagina]; 
    
    [dados addObject:[NSDictionary dictionaryWithDictionary:temp]];
    
    [temp setValue:@"Exemplo6" forKey:titulo];
    [temp setValue:@"21" forKey:pagina]; 
    
    [dados addObject:[NSDictionary dictionaryWithDictionary:temp]];
    
    [temp setValue:@"Exemplo7" forKey:titulo];
    [temp setValue:@"24" forKey:pagina]; 
    
    [dados addObject:[NSDictionary dictionaryWithDictionary:temp]];
    
    [temp setValue:@"Exemplo8" forKey:titulo];
    [temp setValue:@"27" forKey:pagina]; 
    
    [dados addObject:[NSDictionary dictionaryWithDictionary:temp]];
    
    [temp setValue:@"Exemplo9" forKey:titulo];
    [temp setValue:@"31" forKey:pagina]; 
    
    [dados addObject:[NSDictionary dictionaryWithDictionary:temp]];[temp setValue:@"Exemplo10" forKey:titulo];
    [temp setValue:@"34" forKey:pagina]; 
    
    [dados addObject:[NSDictionary dictionaryWithDictionary:temp]];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload {
    [self setTable:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return ((interfaceOrientation == UIInterfaceOrientationPortrait)||(interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown));
}

     
@end

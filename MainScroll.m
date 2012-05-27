//
//  MainScroll.m
//  Livros
//
//  Created by Thiago Deserto on 1/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MainScroll.h"
#import "PaginaView.h"

@implementation MainScroll
@synthesize toggleButton;
@synthesize toolBar;
@synthesize scroll,isKeyboardOn,isHighLighted;

-(PaginaView*) getPageForIndex:(int) index
{
    PaginaView* temp = [[PaginaView alloc] init];
    
    temp.index = index;

    temp.main = self;
    
    return temp;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) 
    {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

-(void) loadPreviousPage
{
    currentPage--;
  
    if (nextView !=nil) 
    {
        [nextView.view removeFromSuperview];
    }
    
    if (currentView != nil) 
    {
        [currentView dismissKeyboard];        
        nextView = currentView;
    }
    
    currentView = previousView;
    
    if (currentView== nil) 
    {
        
        currentView = [self getPageForIndex:currentPage];
        
        [scroll addSubview:currentView.view];
    }
    
    if (currentPage > 1) 
    {
        previousView = [self getPageForIndex:currentPage-1];
        
        [scroll addSubview:previousView.view];
    }
    else
    {
        previousView = nil;
    }
}

-(void) loadNextPage
{
    currentPage++;
    
    if (previousView !=nil) 
    {
       
        [previousView.view removeFromSuperview];
    }
    
    if (currentView != nil) 
    {
        [currentView dismissKeyboard];
        previousView = currentView;
    }
    
    currentView = nextView;
    
    if (currentView==nil) 
    {
        currentView = [self getPageForIndex:currentPage];      
        [scroll addSubview:currentView.view];
    }

    nextView = [self getPageForIndex:currentPage+1];
        
        [scroll addSubview:nextView.view];
}

-(void) scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    isMoving = NO;
}

-(void) scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat pageWidth = scroll.frame.size.width;
    
    isMoving = YES;
    
    [self toggleToolBar];
    int page = floor((scroll.contentOffset.x - pageWidth / 2) / pageWidth) + 2;
    
    if (page < currentPage && page > 0)
    {
        [self loadPreviousPage];
    }
    else if (page > currentPage && page < numberOfPages)
    {
        [self loadNextPage];        
    }
}

-(void)keyboardOn
{
    self.isKeyboardOn = YES;
    
    [currentView highLightFields];
    
    if (previousView) 
    {
        [previousView highLightFields];
    }
    if (nextView) 
    {
        [nextView highLightFields];
    }
   [self toggleToolBar];
}

-(void) keyboardOff
{
    self.isKeyboardOn = NO;
    
    if (!isHighLighted) 
    {
        [currentView unhiLightFields];
        
        if (previousView) 
        {
            [previousView unhiLightFields];
        }
        if (nextView) 
        {
            [nextView unhiLightFields];
        }
    }
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    isHighLighted = NO;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardOn) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardOff) name:UIKeyboardDidHideNotification object:nil];
    
    currentPage = 0;
    
    numberOfPages = 3;
    
    [scroll setContentSize:CGSizeMake(scroll.frame.size.width*numberOfPages, scroll.frame.size.height)];
    
    [self loadNextPage];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setScroll:nil];
    [self setToolBar:nil];
    [self setToggleButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return ((interfaceOrientation == UIInterfaceOrientationPortrait)||(interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown));
}

-(void) toggleToolBar
{
    if (toolBar.alpha == 1.0 && (isKeyboardOn || isMoving)) 
    {
        [UIView beginAnimations:@"" context:nil];
        toolBar.alpha = 0.0;
        [UIView commitAnimations];
    }
    else
    {
        if (!isMoving) 
        {
            if (toolBar.alpha == 1.0) 
            {
                [UIView beginAnimations:@"" context:nil];
                toolBar.alpha = 0.0;
                [UIView commitAnimations];
            }
            else if(!isKeyboardOn)
            {
                [UIView beginAnimations:@"" context:nil];
                toolBar.alpha = 1.0;
                [UIView commitAnimations];
            }
        }
    }
}

- (IBAction)toggleHighLight:(id)sender
{
    isHighLighted = !isHighLighted;
    
    if (isHighLighted) 
    {
        [toggleButton setImage:[UIImage imageNamed:@"highlightover.png"] forState:UIControlStateNormal];
        [currentView highLightFields];
        
        if (previousView) 
        {
            [previousView highLightFields];
        }
        if (nextView) 
        {
            [nextView highLightFields];
        }
    }
    else
    {
        [toggleButton setImage:[UIImage imageNamed:@"highlight.png"] forState:UIControlStateNormal];
        [currentView unhiLightFields];
        
        if (previousView) 
        {
            [previousView unhiLightFields];
        }
        if (nextView) 
        {
            [nextView unhiLightFields];
        }
    }
}

- (IBAction)retornar:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}
@end

//
//  ViewPrincipal.m
//  Livros
//
//  Created by Thiago Deserto on 1/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewPrincipal.h"
#import "ContentParser.h"
#import "Definitions.h"

@implementation ViewPrincipal

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
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

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (NSUInteger) numberOfPagesInLeavesView:(LeavesView*)leavesView {
	return 2;
}

- (void) renderPageAtIndex:(NSUInteger)index inContext:(CGContextRef)ctx
{
	ContentParser* parser = [[ContentParser alloc] init];
    
    NSMutableArray* teste = [parser fetchContentFrom:[NSString stringWithFormat:@"Teste%d",index+1]];
    
    NSMutableString* content = [NSMutableString new];
    
    for (NSMutableDictionary * d in teste) 
    {
      [content appendFormat:@"Um novo campo. \nx=%@ @y=%@\nw=%@ h=%@Linhas=%@\nTexto=%@\n",[d valueForKey:X],[d valueForKey:Y],[d valueForKey:WIDTH],[d valueForKey:HEIGHT],[d valueForKey:LINHAS],[d valueForKey:TEXTO]];
    }
    
    CGRect frame = CGRectMake(0, 0, 200, 200);
    
    UITextView* text = [[UITextView alloc] initWithFrame:frame];
    
    [text setText:content];
    
    UIGraphicsBeginImageContextWithOptions(frame.size, NO, 1.0);
    
    [text.layer renderInContext:UIGraphicsGetCurrentContext()];//provavelmente renderizando a imagem
    // Read the UIImage object
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
	CGContextDrawImage(ctx, frame, [image CGImage]);
}

// called when the user touches up on the left or right side of the page, or finishes dragging the page
- (void) leavesView:(LeavesView *)leavesView willTurnToPageAtIndex:(NSUInteger)pageIndex
{
        for (UIView * v in [self.view subviews]) 
        {
            if ([v class]  == [UITextView class] || [v class]  == [UITextField class]) 
            {
                [v removeFromSuperview];
            }
        }  
}

// called when the page-turn animation (following a touch-up or drag) completes 
- (void) leavesView:(LeavesView *)leavesView didTurnToPageAtIndex:(NSUInteger)pageIndex
{
    ContentParser* parser = [[ContentParser alloc] init];
    
    NSMutableArray* teste = [parser fetchContentFrom:[NSString stringWithFormat:@"Teste%d",pageIndex+1]];
    
    NSMutableString* content = [NSMutableString new];
    
    for (NSMutableDictionary * d in teste) 
    {
        [content appendFormat:@"Um novo campo. \nx=%@ @y=%@\nw=%@ h=%@Linhas=%@\nTexto=%@\n",[d valueForKey:X],[d valueForKey:Y],[d valueForKey:WIDTH],[d valueForKey:HEIGHT],[d valueForKey:LINHAS],[d valueForKey:TEXTO]];
    }
    
    CGRect frame = CGRectMake(0, 0, 200, 200);
    
    UITextView* text = [[UITextView alloc] initWithFrame:frame];
    
    [text setText:content];
    
    [self.view addSubview:text];
    
    /*[self.view addSubview:text];
    
    [text setDelegate:self];
    
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyBoard)];
    
    UIView* temp = [[UIView alloc] initWithFrame:self.view.frame];
    
    [temp addGestureRecognizer:tap];
    
       
    [self.view addSubview:text];
    
    //[self.view addSubview:temp];
    
    [self.view sendSubviewToBack:temp];*/
}

-(BOOL) canBecomeFirstResponder
{
    return YES;
}

-(void)dismissKeyBoard
{
   [[self.view subviews] makeObjectsPerformSelector: @selector(resignFirstResponder)];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end

//
//  PaginaView.m
//  Livros
//
//  Created by Thiago Deserto on 1/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PaginaView.h"
#import "ContentParser.h"
#import "Definitions.h"
#import "ZeroText.h"
#import "MainScroll.h"

@implementation PaginaView
@synthesize index,main;

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
    [super didReceiveMemoryWarning];
}

-(void) highLightFields
{
    [fields makeObjectsPerformSelector:@selector(setBackgroundColor:) withObject:defColor];
}

-(void) unhiLightFields
{
    [fields makeObjectsPerformSelector:@selector(setBackgroundColor:) withObject:[UIColor clearColor]];
}

-(void) adjustToFrame:(CGRect) frame
{
    int end = frame.size.height+frame.origin.y;
    
    if (end > 740) 
    {
        [UIView beginAnimations:@"" context:nil];
        self.view.frame = CGRectOffset(self.view.frame,0, -(end-730));
        [UIView commitAnimations];
    }
}

-(void)startTextField:(id) sender
{
    CGRect frame = ((UITextField*)sender).frame;
    [self adjustToFrame:frame];
}

-(void)returnFromAdjust:(BOOL) animated
{
    if (self.view.frame.origin.y != 0) 
    {
        if (animated)
        {
            [UIView beginAnimations:@"" context:nil];
            self.view.frame = CGRectOffset(self.view.frame, 0, -self.view.frame.origin.y);
            [UIView commitAnimations];
        }
        else
        {
            self.view.frame = CGRectOffset(self.view.frame, 0, -self.view.frame.origin.y);
            
        }
    }
}

-(void)endTextField:(id) sender
{
    [self returnFromAdjust:YES];
}

-(void) textViewDidBeginEditing:(UITextView *)textView
{
    [self adjustToFrame:textView.frame];
}

-(void) textViewDidEndEditing:(UITextView *)textView
{
    [self returnFromAdjust:YES];
}

-(void) textViewDidChange:(UITextView *)textView
{
    NSMutableDictionary* temp = [dicts objectAtIndex:[fields indexOfObject:textView]];
   
    int lenght = [[temp valueForKey:@"MIN_SIZE"] intValue];
    
    @try 
    {
        NSString* endereco = [NSString stringWithFormat:@"Pagina_%d_Campo_%d",self.index,[fields indexOfObject:textView]];
        
        NSString* toSave = [NSString stringWithFormat:@"%@",textView.text];
        
        toSave = [toSave substringFromIndex:lenght];
        
        [ContentParser saveContent:toSave atIndex:endereco];
    }
    @catch (NSException *exception) 
    {
        [textView setText:[temp valueForKey:@"ORIGINAL_TEXT"]];
    }
    
    if (![textView.text hasPrefix:[temp valueForKey:@"ORIGINAL_TEXT"]]) 
    {
        [textView setText:[NSString stringWithFormat:@"%@%@",[temp valueForKey:@"ORIGINAL_TEXT"],[textView.text substringFromIndex:lenght]]];
    }
}

-(BOOL) textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) 
    {
        return NO;
    }
    
    NSMutableDictionary* temp = [dicts objectAtIndex:[fields indexOfObject:textView]];
    int lenght = [[temp valueForKey:@"MIN_SIZE"] intValue];
    
    int maxLenght = (textView.frame.size.width / 9.2) * [[temp valueForKey:LINHAS] intValue]; 
    
    NSLog(@"%d",maxLenght);
    
    if (lenght == [textView.text length] && [text length] == 0) 
    {
        return NO;
    }
    
    if(range.length > text.length)
    {
        return YES;
    }else if ([[textView text] length] + text.length > maxLenght)
    {
        return NO;
    }

    return YES;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    fields = [NSMutableArray new];
    dicts = [NSMutableArray new];
    CGRect frame = self.view.frame;
    
    frame.origin.x = frame.size.width*(index-1);
    
    self.view.frame = frame;
    
    ContentParser* parser = [[ContentParser alloc] init];
    
    NSMutableArray* teste = [parser fetchContentFrom:[NSString stringWithFormat:@"Teste%d",index]];
    
    UIFont* defFont = [UIFont fontWithName:@"Courier New" size:14];
    fontColor = [UIColor colorWithRed:18.0/255.0 green:112.0/225.0 blue:11.0/255.0 alpha:1.0];
    defColor = [UIColor colorWithRed:13.0/255.0 green:255.0/255.0 blue:15.0/255.0 alpha:0.15];
    
    for (NSMutableDictionary * d in teste) 
    { 
        if ([[d valueForKey:LINHAS] intValue] > 1) 
        {
            CGRect frame = CGRectMake([[d valueForKey:X] intValue], [[d valueForKey:Y] intValue]-5, [[d valueForKey:WIDTH] intValue], [[d valueForKey:HEIGHT] intValue]);
            ZeroText* campo = [[ZeroText alloc] initWithFrame:frame];
            
            [campo setFont:defFont];
            
            if (main.isHighLighted) 
            {
                [campo setBackgroundColor:defColor];
            }
            else
            {
                [campo setBackgroundColor:[UIColor clearColor]];
            }
            
            [campo setScrollEnabled:NO];
            
            [campo setText:[d valueForKey:TEXTO]];
            [campo setTextColor:fontColor];
            NSString* endereco = [NSString stringWithFormat:@"Pagina_%d_Campo_%d",self.index,[teste indexOfObject:d]];
            
            NSMutableDictionary* tempD = [NSMutableDictionary dictionary];
            
            [tempD setValue:[d valueForKey:LINHAS] forKey:LINHAS];
            
            if ([[d valueForKey:LINHAS] intValue] == 4)
            {
                frame.size.height = frame.size.height +5;
                campo.frame = frame;
            }
            
            [tempD setValue:[NSString stringWithFormat:@"%d",[campo.text length]] forKey:@"MIN_SIZE"];
            [tempD setValue:[d valueForKey:TEXTO] forKey:@"ORIGINAL_TEXT"];
            
            [campo setText:[NSString stringWithFormat:@"%@%@",campo.text,[ContentParser getText:endereco]]];
            
            [fields addObject:campo];
            
            [dicts addObject:tempD];
            
            [self.view addSubview:campo];
            
            [campo setDelegate:self]; 
        }
        else
        {
            CGRect frame = CGRectMake([[d valueForKey:X] intValue]+1, [[d valueForKey:Y] intValue]+3, [[d valueForKey:WIDTH] intValue], [[d valueForKey:HEIGHT] intValue]);
            
            UITextField* field = [[UITextField alloc] initWithFrame:frame];
            
            [field setFont:defFont];
            
            if (main.isHighLighted) 
            {
                [field setBackgroundColor:defColor];
            }
            else
            {
                [field setBackgroundColor:[UIColor clearColor]];
            }
            
            NSMutableDictionary* tempD = [NSMutableDictionary dictionary];
            
            NSString* endereco = [NSString stringWithFormat:@"Pagina_%d_Campo_%d",self.index,[teste indexOfObject:d]];
            
            [field setText:[ContentParser getText:endereco]];
            [field setTextColor:fontColor];
            [fields addObject:field];
            
            [dicts addObject:tempD];
            
            [field addTarget:self action:@selector(checkTextField:) forControlEvents:UIControlEventEditingChanged];
            [field addTarget:self action:@selector(startTextField:) forControlEvents:UIControlEventEditingDidBegin];
            [field addTarget:self action:@selector(endTextField:) forControlEvents:UIControlEventEditingDidEnd];
            
            [self.view addSubview:field];
        }
    }
    
    UIImage* image = [UIImage imageNamed:[NSString stringWithFormat:@"pg%d",index]];
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:image]];
    
    dismissingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,self.view.frame.size.height)];
    
    tap = [[UITapGestureRecognizer alloc] initWithTarget: self action:@selector(dismissKeyboard)];
    
    [dismissingView addGestureRecognizer:tap];
    
    [self.view addSubview:dismissingView];
    
    [self.view sendSubviewToBack:dismissingView];
       // Do any additional setup after loading the view from its nib.
}

-(void) checkTextField:(id) sender
{
    if ([((UITextField*)sender).text length] > ((UITextField*)sender).frame.size.width  / 8)
    {
        ((UITextField*)sender).text = [ ((UITextField*)sender).text substringToIndex:((UITextField*)sender).frame.size.width  / 8];
    }
    
    NSString* endereco = [NSString stringWithFormat:@"Pagina_%d_Campo_%d",self.index,[fields indexOfObject:sender]];
    
    [ContentParser saveContent:((UITextField*)sender).text atIndex:endereco];
}

-(void) dismissKeyboard
{
    if (!main.isKeyboardOn) 
    {
        [main toggleToolBar];
    }
    else
    {
    [fields makeObjectsPerformSelector:@selector(resignFirstResponder)];    
    }
}

-(BOOL) canBecomeFirstResponder
{
    return YES;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return ((interfaceOrientation == UIInterfaceOrientationPortrait)||(interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown));
}

@end

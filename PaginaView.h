//
//  PaginaView.h
//  Livros
//
//  Created by Thiago Deserto on 1/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MainScroll;
@interface PaginaView : UIViewController<UITextViewDelegate>
{
    NSMutableArray* fields;
    
    UIColor* fontColor;
    UIColor* defColor;
    
    NSMutableArray* dicts;
    
    UIView* dismissingView;
    
    UITapGestureRecognizer* tap;
    
    UITextView* lastField;
}

-(void) dismissKeyboard;

-(void) highLightFields;

-(void) unhiLightFields;

@property(strong) MainScroll* main;

@property (assign) int index;

@end

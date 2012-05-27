//
//  MainScroll.h
//  Livros
//
//  Created by Thiago Deserto on 1/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PaginaView;
@interface MainScroll : UIViewController<UIScrollViewDelegate>
{
    int currentPage;
    
    int numberOfPages;
    
    PaginaView* nextView;
    
    PaginaView* currentView;
    
    PaginaView* previousView;
    BOOL isMoving;
}

@property (strong, nonatomic) IBOutlet UIButton *toggleButton;
@property (strong, nonatomic) IBOutlet UIScrollView *scroll;
@property(assign) BOOL isHighLighted;
@property(assign) BOOL isKeyboardOn;
@property (strong, nonatomic) IBOutlet UIToolbar *toolBar;
- (IBAction)toggleHighLight:(id)sender;
- (IBAction)retornar:(id)sender;
-(void)toggleToolBar;
@end

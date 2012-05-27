//
//  IndiceView.h
//  Livros
//
//  Created by Thiago Deserto on 1/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IndiceView : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray* dados;
    
    NSString* titulo;
    NSString* pagina;
    
    UIViewController* pre;
}
@property (strong, nonatomic) IBOutlet UITableView *table;
@end

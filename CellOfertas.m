//  Created by Sir Cheshire.

#import "CellOfertas.h"

@implementation CellOfertas

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void) layoutSubviews 
{
    [super layoutSubviews];
    
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        [self setBackgroundColor:[UIColor whiteColor]];
        
        [self.textLabel setBackgroundColor:[UIColor clearColor]];
        [self.detailTextLabel setBackgroundColor:[UIColor clearColor]];
        
        //x23 y17  507 17
        CGRect titulo = self.textLabel.frame;
        titulo.origin.x = 23;
        titulo.origin.y = 11;
        titulo.size.width = 200;
        
        
        self.textLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:17];
        self.detailTextLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:17];
        
        self.textLabel.textColor = [UIColor blackColor];
        self.detailTextLabel.textColor = [UIColor blackColor];
         
        
        self.textLabel.frame = titulo;
        
        CGRect sub = self.detailTextLabel.frame;
        sub.origin.x = 507;
        sub.origin.y = 11;
        sub.size.width = 50;
        
        self.detailTextLabel.font = [UIFont systemFontOfSize:17];
        
        self.detailTextLabel.frame = sub;
        
    }
    else
    {
       //NAO MEXA AQUI PORRA
        //ME OBRIGUE LOL
        
        
        [self setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_ofertas.png"]]];
        
        [self.textLabel setBackgroundColor:[UIColor clearColor]];
        [self.detailTextLabel setBackgroundColor:[UIColor clearColor]];
        
        CGRect imf = self.imageView.frame;
        imf.origin.x = 10;
        imf.size.height = 46;
        imf.origin.y = 49;
        imf.size.width = 98;
        
        self.imageView.frame = imf;
        
        CGRect titulo = self.textLabel.frame;
        titulo.origin.x = 5;
        titulo.origin.y = 10;
        titulo.size.width = 295;
        
        self.textLabel.frame = titulo;
        
        CGRect sub = self.detailTextLabel.frame;
        sub.origin.x = 125;
        sub.origin.y = 45;
        sub.size.width = 180;
        
        self.detailTextLabel.frame = sub;
        
        [self.detailTextLabel setFont:[UIFont fontWithName:@"Futura" size:12]];
        [self.textLabel setFont:[UIFont fontWithName:@"Futura" size:15]];
        
        //NAO MEXA AQUI PORRA
    }
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

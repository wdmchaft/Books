//
//  ContentParser.h
//  Livros
//
//  Created by Thiago Deserto on 1/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ContentParser : NSObject<NSXMLParserDelegate>
{
    NSMutableString* tempString;
    
    NSMutableDictionary* tempDict;
    
    NSMutableArray* elementos;
    
    NSXMLParser* parser;
}

-(NSMutableArray*) fetchContentFrom:(NSString*) file;

+(void) saveContent:(NSString*)text atIndex:(NSString*) index; 

+(NSString*) getText:(NSString*) index;

@end

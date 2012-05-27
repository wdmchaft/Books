//
//  ContentParser.m
//  Livros
//
//  Created by Thiago Deserto on 1/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ContentParser.h"
#import "Definitions.h"

@implementation ContentParser

-(NSMutableArray*) fetchContentFrom:(NSString*) file
{
   NSString* path = [[NSBundle mainBundle] pathForResource:file ofType:@"xml"];
    
    parser = [[NSXMLParser alloc] initWithData:[NSData dataWithContentsOfFile:path]];
    
    parser.delegate = self;
    
    if ([parser parse]) 
    {
        NSLog(@"parse bem sucedido de um arquivo");
    }
    else
    {
        NSLog(@"falha no parse de %@",file);
    }
    
    return elementos;
}

+(void) saveContent:(NSString*)text atIndex:(NSString*) index
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);     
    
    NSString *documentsDirectory = [paths objectAtIndex:0]; 
    
    NSString *fullPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"textos.txt"]];    
    
    NSMutableDictionary* textos = [NSMutableDictionary dictionaryWithContentsOfFile:fullPath];
    
    if (textos == nil) 
    {
        textos = [NSMutableDictionary dictionary];
    }
    
    [textos setValue:text forKey:index];
    
    [textos writeToFile:fullPath atomically:NO];
}

+(NSString*) getText:(NSString*) index
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);     
    
    NSString *documentsDirectory = [paths objectAtIndex:0]; 
    
    NSString *fullPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"textos.txt"]];    
    
    NSMutableDictionary* textos = [NSMutableDictionary dictionaryWithContentsOfFile:fullPath];
    
    NSString* ret = @"";
    
    if (textos != nil) 
    {
        if ([textos valueForKey:index]) 
        {
            ret = [textos valueForKey:index];
        }
    }
    
    return ret;
}

-(void) parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    [tempString appendString:string];
}

-(void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    
    if ([elementName isEqualToString:PAGINA]) 
    {
        elementos = [NSMutableArray new];
    }
    else if([elementName isEqualToString:CAMPO])
    {
        tempDict = [NSMutableDictionary dictionary];
    }
    else
    {
        tempString = [NSMutableString new];
    }
}



-(void) parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if ([elementName isEqualToString:CAMPO]) 
    {
        [elementos addObject:tempDict];
    }
    else if(![elementName isEqualToString:PAGINA]) 
    {
        [tempDict setValue:[tempString copy] forKey:elementName];
    }
}

@end

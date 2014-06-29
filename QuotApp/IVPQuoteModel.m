//
//  IVPQuoteModel.m
//  QuotApp
//
//  Created by Ignasi Vegas on 22/06/14.
//  Copyright (c) 2014 Ignasi Vegas. All rights reserved.
//

#import "IVPQuoteModel.h"

@implementation IVPQuoteModel


-(id) initWithContent: (NSString *) aContent
               author: (NSString *) aAuthor
             category: (NSString *) aCategory{
    
    if (self = [super init])
    
    {
        _content = aContent;
        _author = aAuthor;
        _category = aCategory;
    }
    
    return self;
}


@end

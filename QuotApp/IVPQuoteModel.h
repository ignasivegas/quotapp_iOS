//
//  IVPQuoteModel.h
//  QuotApp
//
//  Created by Ignasi Vegas on 22/06/14.
//  Copyright (c) 2014 Ignasi Vegas. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IVPQuoteModel : NSObject


@property (strong, nonatomic) NSString *content;
@property (strong, nonatomic) NSString *author;
@property (strong, nonatomic) NSString *category;


//Inicializador propio

-(id) initWithContent: (NSString *) aContent
               author: (NSString *) aAuthor
             category: (NSString *) category;


@end

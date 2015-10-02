//
//  IVPQuoteViewController.h
//  QuotApp
//
//  Created by Ignasi Vegas on 22/06/14.
//  Copyright (c) 2014 Ignasi Vegas. All rights reserved.
//

@import UIKit;
#import "IVPQuoteModel.h"

@interface IVPQuoteViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *content;
@property (weak, nonatomic) IBOutlet UILabel *author;


@property (strong, nonatomic) IVPQuoteModel *model;


-(id) initWithModel: (IVPQuoteModel *)aModel;

@end

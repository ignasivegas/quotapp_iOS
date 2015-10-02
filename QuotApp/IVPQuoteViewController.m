//
//  IVPQuoteViewController.m
//  QuotApp
//
//  Created by Ignasi Vegas on 22/06/14.
//  Copyright (c) 2014 Ignasi Vegas. All rights reserved.
//

#import "IVPQuoteViewController.h"

@interface IVPQuoteViewController ()

@end

@implementation IVPQuoteViewController


-(id) initWithModel: (IVPQuoteModel *)aModel{
    
    if (self = [super initWithNibName:nil bundle:nil]){
        _model = aModel;
        
    }
    
    return self;
    
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void) viewWillAppear:(BOOL)animated
{
    
    self.view.backgroundColor = [UIColor colorWithRed:0.75 green:0.91 blue:1 alpha:1];

    
    UIColor *textColor = [UIColor colorWithRed:95.0/255.0 green:95.0/255.0 blue:95.0/255.0 alpha:1.0];
    self.author.textColor = textColor;
    self.content.textColor = textColor;
    
    //El booleano dice si va a aparecer con animacion o no
    [super viewWillAppear:animated];
    
    [self syncModelWithView];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Utils

-(void) syncModelWithView{
    
    self.content.text = self.model.content;
    self.author.text = self.model.author;
    
}



@end

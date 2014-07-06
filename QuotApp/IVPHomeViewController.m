//
//  IVPHomeViewController.m
//  QuotApp
//
//  Created by Ignasi Vegas on 21/06/14.
//  Copyright (c) 2014 Ignasi Vegas. All rights reserved.
//

#import "IVPHomeViewController.h"
#import "IVPQuoteModel.h"
#import "IVPQuoteViewController.h"

@interface IVPHomeViewController ()

@end

@implementation IVPHomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"QuotApp";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    //Color de la barra
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:1
                                                                           green:79.0/255.0
                                                                            blue:74.0/255.0
                                                                           alpha:0.7];
    //Color flecha
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    //Color texto
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Motion Events


- (void) motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    //Esta empezando el movimiento
    
}


- (void) motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if (motion == UIEventSubtypeMotionShake)
    {
        //Hay un shake
        
    }
}


#pragma mark - Touch Events

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
  //Se ha clickado en la pantalla
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [self getQuote];
    
}

#pragma mark - Utils

-(void) getQuote{
    
    NSURL *URL = [NSURL URLWithString:@"http://localhost:3000/api/v1/quotes/discover"];
    
    // Initialize Request Operation
    AFHTTPRequestOperation *requestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:[NSURLRequest requestWithURL:URL]];
    
    // Configure Request Operation
    [requestOperation setResponseSerializer:[AFJSONResponseSerializer serializer]];
    [requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        // Process Response Object
        NSLog(@"Response: %@", responseObject);
        NSDictionary *response = (NSDictionary *) responseObject;
        
        
        IVPQuoteModel *quote = [[IVPQuoteModel alloc] initWithContent:response[@"data"][@"content"]
                                                               author:response[@"data"][@"author"]
                                                             category:response[@"data"][@"category"]];
        
        IVPQuoteViewController *quoteVC = [[IVPQuoteViewController alloc] initWithModel:quote];
        
        [self.navigationController pushViewController:quoteVC animated:YES];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Retrieving Weather"
                                                            message:[error localizedDescription]
                                                           delegate:nil
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil];
        [alertView show];
    }];
    
    // Start Request Operation
    [requestOperation start];
    
    
    
    
    
    
    
    
    
}


@end

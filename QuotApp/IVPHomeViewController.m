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
    
    [self.view setUserInteractionEnabled:FALSE];
    
    [self getQuote:^(IVPQuoteModel *quote){
        
        // Parar el activity view
        [self.imageView setHidden:NO];
        [self.activityView stopAnimating];
        [self.view setUserInteractionEnabled:TRUE];

        
        IVPQuoteViewController *quoteVC = [[IVPQuoteViewController alloc] initWithModel:quote];
        
        [self.navigationController pushViewController:quoteVC animated:YES];
    }];
    
}

#pragma mark - Utils

-(void) getQuote: (void(^)(IVPQuoteModel *quote))completionBlock{
    
    NSURL *URL = [NSURL URLWithString:@"http://localhost:3000/api/v1/quotes/discover"];
    // Iniciar el acitvity view
    [self.imageView setHidden:YES];
    [self.activityView startAnimating];
    
    
    // 1. bajar la imagen en segundo plano
    //Creamos o obtenemos cola
    dispatch_queue_t download = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    //Le mandamos a la cola en segundo plano el programa q tiene q ejecutar
    dispatch_async(download, ^{
        
        // Initialize Request Operation
        AFHTTPRequestOperation *requestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:[NSURLRequest requestWithURL:URL]];
        
        // Configure Request Operation
        [requestOperation setResponseSerializer:[AFJSONResponseSerializer serializer]];
        [requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            // Process Response Object
            NSDictionary *response = (NSDictionary *) responseObject;
            
            
            IVPQuoteModel *quote = [[IVPQuoteModel alloc] initWithContent:response[@"data"][@"content"]
                                                                   author:response[@"data"][@"author"]
                                                                 category:response[@"data"][@"category"]];
            //2. Ejecutar el bloque de finalizacion q nos han pasado
            // Los bloques de finalizacion, los ejecutamos en la cola principal, con dispatch_get_main_queue la obtenemos
            dispatch_async(dispatch_get_main_queue(), ^{
                completionBlock(quote);
                
            });
            
            
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Retrieving Weather"
                                                                    message:[error localizedDescription]
                                                                   delegate:nil
                                                          cancelButtonTitle:@"Ok"
                                                          otherButtonTitles:nil];
                [alertView show];
            });
            
            dispatch_async(dispatch_get_main_queue(), ^{
                // Parar el activity view
                [self.imageView setHidden:NO];
                [self.activityView stopAnimating];
                [self.view setUserInteractionEnabled:TRUE];
            });
            
            
        }];
        
        // Start Request Operation
        [requestOperation start];
        
        
       
        
    });
    
    
    

    
}


@end

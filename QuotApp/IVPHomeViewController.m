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
#import "AFNetworking.h"

@interface IVPHomeViewController ()

@end

@implementation IVPHomeViewController

Boolean animating;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"QuotApp";
        self.animating = FALSE;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    //Color fondo
    self.view.backgroundColor = [UIColor colorWithRed:0.75 green:0.91 blue:1 alpha:1];
    
    //Color de la barra
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:131.0/255.0
                                                                           green:188.0/255.0
                                                                            blue:229.0/255.0
                                                                           alpha:0];
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
    animating = TRUE;
    [self getQuote:^(IVPQuoteModel *quote){
        
        // Parar el activity view
        [self.button setHidden:NO];
        [self.logo setHidden:NO];
        [self.view setUserInteractionEnabled:TRUE];

        
        IVPQuoteViewController *quoteVC = [[IVPQuoteViewController alloc] initWithModel:quote];
        
        [self.navigationController pushViewController:quoteVC animated:YES];
    }];
    

    
}

#pragma mark - Utils

- (void)animateRefreshView{
    
    NSArray *colorArray = @[[UIColor redColor],[UIColor blueColor],[UIColor purpleColor],[UIColor cyanColor],[UIColor orangeColor],[UIColor magentaColor]];
    static int colorIndex = 0;
    
    [UIView animateWithDuration:0.3
                          delay:0.3
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         
                         // Change the background color
                         self.view.backgroundColor = [colorArray objectAtIndex:colorIndex];
                         colorIndex = (colorIndex + 1) % colorArray.count;
                     }
                     completion:^(BOOL finished) {
                         
                         if (animating){
                             [self animateRefreshView];
                         }else{
                             self.view.backgroundColor = [UIColor clearColor];
                         }
                         
                     }];
    
}

-(void) getQuote: (void(^)(IVPQuoteModel *quote))completionBlock{
   
    NSURL *URL = [NSURL URLWithString:@"http://localhost:3000/api/v1/quotes/discover"];

    
    // Iniciar el acitvity view
    //[self.view setUserInteractionEnabled:FALSE];
    [self.button setHidden:YES];
    //[self.icon_image setHidden:YES];
    [self.logo setHidden:YES];
    
    animating = TRUE;
    
    
    // 1. bajar  en segundo plano
    //Creamos o obtenemos cola
    dispatch_queue_t download = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    //2.Le mandamos a la cola en segundo plano el programa q tiene q ejecutar
    dispatch_async(download, ^{
        
        
        
        // Prepare the request object
        NSURLRequest *urlRequest = [NSURLRequest requestWithURL:URL
                                                    cachePolicy:NSURLRequestReloadIgnoringCacheData
                                                timeoutInterval:30];
        
        // Prepare the variables for the JSON response
        NSData *urlData;
        NSURLResponse *response;
        NSError *error;
        
        // Make synchronous request
        urlData = [NSURLConnection sendSynchronousRequest:urlRequest
                                        returningResponse:&response
                                                    error:&error];
        
        
        // Construct a Array around the Data from the response
        NSDictionary* json = [NSJSONSerialization
                           JSONObjectWithData:urlData
                           options:kNilOptions
                           error:&error];

        
        IVPQuoteModel *quote = [[IVPQuoteModel alloc] initWithContent:[json objectForKey:@"content"]
                                                               author:[json objectForKey:@"author"]
                                                             category:[json objectForKey:@"category"]];

        
        animating = FALSE;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            completionBlock(quote);

        });
        
    });
    
    [self animateRefreshView];

    
}


@end

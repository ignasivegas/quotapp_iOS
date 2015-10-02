//
//  IVPHomeViewController.h
//  QuotApp
//
//  Created by Ignasi Vegas on 21/06/14.
//  Copyright (c) 2014 Ignasi Vegas. All rights reserved.
//

@import UIKit;

@interface IVPHomeViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityView;

@property (weak, nonatomic) IBOutlet UIImageView *button;
@property (weak, nonatomic) IBOutlet UIImageView *logo;
@property (weak, nonatomic) IBOutlet UIImageView *icon_image;

@property (assign) BOOL animating;

@end

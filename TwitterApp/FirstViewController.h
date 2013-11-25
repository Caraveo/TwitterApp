//
//  FirstViewController.h
//  TwitterApp
//
//  Created by Johnny Caraveo on 11/24/13.
//  Copyright (c) 2013 Johnny Caraveo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Accounts/Accounts.h>
#import <Social/Social.h>
#import "TwitterCell.h"

@interface FirstViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *twitterTableView;
@property NSArray *rawData;
@property UIImage *image;
@property NSURL *url;


@end

//
//  FirstViewController.h
//  TwitterApp
//
//  Created by Johnny Caraveo on 11/24/13.
//  Copyright (c) 2013 Johnny Caraveo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TwitterCell.h"
#import "Twitter.h"

@interface FirstViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, TwitterDelegate>
@property (strong, nonatomic) IBOutlet UITableView *twitterTableView;
@property NSArray *rawData;
@property UIImage *image;
@property NSURL *url;


@end

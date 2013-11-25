//
//  FirstViewController.m
//  TwitterApp
//
//  Created by Johnny Caraveo on 11/24/13.
//  Copyright (c) 2013 Johnny Caraveo. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController
@synthesize twitterTableView, url, image, rawData;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self getTimeline];
    [self.twitterTableView reloadData];
}
-(void)viewDidAppear:(BOOL)animated{
    [self.twitterTableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellID = @"twitterCell";
    TwitterCell *cell = [twitterTableView dequeueReusableCellWithIdentifier:cellID];
    if(cell == nil)
    {
        //If cell is not initiated then intiate cell with reuese identifier
        cell = [[TwitterCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    // NSDictionary *tweet = rawData[[indexPath row]];
    
//    cell.usernameLabel = tweet[@"text"];
//    cell.tweetLabel = tweet[@"text"];
//    cell.dateLabel = tweet[@"created_at"];
    
    // NSDictionary *users = [tweet objectForKey:@"user"];
    
    // url = [[NSURL alloc] initWithString:[users valueForKey:@"profile_image_url"]];
    
    // image = [UIImage imageWithData: [NSData dataWithContentsOfURL:url]];
    
    // cell.profileIcon.image = image;
    
    return cell;
}

- (BOOL)userHasAccessToTwitter
{
    return [SLComposeViewController
            isAvailableForServiceType:SLServiceTypeTwitter];
}

-(void) getTimeline{
    if ([self userHasAccessToTwitter])
    {
        NSLog(@"Twitter Access Granted");
        ACAccountStore *account = [[ACAccountStore alloc] init];
        ACAccountType *accountType = [account accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
        
        [account requestAccessToAccountsWithType:accountType options:nil completion:^(BOOL granted, NSError *error)
        {
            if( granted == YES)
            {
      
                //Create an array of twitter accounts found on device.
                NSArray *accounts = [account accountsWithAccountType:accountType];
                if(accounts.count >= 0)
                {
                    //Create an instance of ACAccount with the first twitter account in accounts array.
                    ACAccount *twitterAccount = [accounts lastObject];
                    
                    //URL to JSON Data
                    NSURL *requestURL = [NSURL URLWithString:@"https://api.twitter.com/1.1/statuses/home_timeline.json"];
                    
                    //Create a mDictionary with parameters to be used with requestURL
                    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
                    [params setObject:@"20" forKey:@"count"];
                    [params setObject:@"1" forKey:@"include_entities"];
                    
                    //Create the template for an HTTP request
                    SLRequest *postRequest = [SLRequest
                                              requestForServiceType:SLServiceTypeTwitter
                                              requestMethod:SLRequestMethodGET
                                              URL:requestURL parameters:params];
            
                    //Attach and account to the request
                    [postRequest setAccount:twitterAccount];
                     
                    //Run the HTTP request and GET twitter with JSON DATA callback
                    [postRequest performRequestWithHandler:
                     ^(NSData *responseData, NSHTTPURLResponse
                       *urlResponse, NSError *error)
                    {
                        //Populate rawData array with JSON Data from responseData
                        self.rawData = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:&error];

                        
                        NSLog(@"1: %@", rawData);
                        
                        if (self.rawData.count != 0){
                            dispatch_async(dispatch_get_main_queue(), ^{
                                [twitterTableView reloadData];
                            });
                        }
                        NSLog(@"Block Scope: %@", rawData);
                        
                    }];
                    
                    NSLog(@"2: %@", rawData);
                }
                else
                {
                    // Access was not granted, or an error occurred
                    NSLog(@"%@", [error localizedDescription]);
                }
            }
        }];
        NSLog(@"Data: %@", rawData);
    }
}
@end

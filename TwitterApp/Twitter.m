//
//  Twitter.m
//  TwitterApp
//
//  Created by user on 11/24/13.
//  Copyright (c) 2013 Johnny Caraveo. All rights reserved.
//

#import "Twitter.h"

@implementation Twitter
ACAccountStore *account;
ACAccountType *accountType;
@synthesize delegate;

-(id)initWithDelegate:(id)delegate {
    if ( self = [super init] ) {
        account = [[ACAccountStore alloc] init];
        accountType = [account accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
        self.delegate = delegate;
    }
    return self;
}

- (BOOL)userHasAccessToTwitter
{
    return [SLComposeViewController
            isAvailableForServiceType:SLServiceTypeTwitter];
}

-(void)requestTimeline{
    NSLog(@"requesting access");
    if ([self userHasAccessToTwitter])
    {
        [account requestAccessToAccountsWithType:accountType options:nil completion:^(BOOL granted, NSError *error)
         {
             if( granted == YES)
             {
                 NSLog(@"access granted");
                 [self twitterAccessGranted:error];
             }
         }];
    }
}

-(void) twitterAccessGranted:(NSError*)error
{
    //Create an array of twitter accounts found on device.
    NSArray *accounts = [account accountsWithAccountType:accountType];
    if(accounts.count > 0)
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
             NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:responseData
                                    options:NSJSONReadingAllowFragments
                                    error:&error];
             
             [delegate twitter:jsonArray];
             
         }];
        
    }
    else
    {
        // Access was not granted, or an error occurred
        NSLog(@"%@", [error localizedDescription]);
    }
    
    
}

@end

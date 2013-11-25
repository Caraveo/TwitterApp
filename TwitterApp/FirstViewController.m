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
Twitter *twitter;
NSArray* timeline;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    timeline = [[NSArray alloc]init];
    twitter = [[Twitter alloc] initWithDelegate:self];
    [twitter requestTimeline];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return timeline.count;
}

-(void)twitter:(NSArray *)twitterTimeline{
    timeline = twitterTimeline;
    [self.twitterTableView reloadData];
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
    NSDictionary *tweet = timeline[[indexPath row]];
    
    NSLog(@"key: %@, value: %@ \n", @"text", [tweet objectForKey:@"text"]);
    cell.usernameLabel = tweet[@"text"];
    cell.tweetLabel = tweet[@"text"];
    cell.dateLabel = tweet[@"created_at"];
    
    // NSDictionary *users = [tweet objectForKey:@"user"];
    
    // url = [[NSURL alloc] initWithString:[users valueForKey:@"profile_image_url"]];
    
    // image = [UIImage imageWithData: [NSData dataWithContentsOfURL:url]];
    
    // cell.profileIcon.image = image;
    
    return cell;
}


@end

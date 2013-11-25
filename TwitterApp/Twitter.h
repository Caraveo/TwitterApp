//
//  Twitter.h
//  TwitterApp
//
//  Created by user on 11/24/13.
//  Copyright (c) 2013 Johnny Caraveo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Accounts/Accounts.h>
#import <Social/Social.h>

@protocol TwitterDelegate;

@interface Twitter : NSObject

@property (nonatomic, weak) id<TwitterDelegate> delegate;

-(id)initWithDelegate:(id)delegate;
-(void)requestTimeline;

@end

@protocol TwitterDelegate <NSObject>

-(void)twitter:(NSArray*)twitterTimeline;

@end

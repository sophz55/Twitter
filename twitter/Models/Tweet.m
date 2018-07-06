//
//  Tweet.m
//  twitter
//
//  Created by Sophia Zheng on 7/2/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "Tweet.h"
#import "User.h"
#import "NSDate+DateTools.h"

@implementation Tweet

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        // Is this a re-tweet?
        NSDictionary *originalTweet = dictionary[@"retweeted_status"];
        if(originalTweet != nil){
            NSDictionary *userDictionary = dictionary[@"user"];
            self.retweetedByUser = [[User alloc] initWithDictionary:userDictionary];
            
            // Change tweet to original tweet
            dictionary = originalTweet;
        }
        self.idStr = dictionary[@"id_str"];
        self.text = dictionary[@"text"];
        self.favoriteCount = [dictionary[@"favorite_count"] intValue];
        self.favorited = [dictionary[@"favorited"] boolValue];
        self.retweetCount = [dictionary[@"retweet_count"] intValue];
        self.retweeted = [dictionary[@"retweeted"] boolValue];
        
        // initialize user
        NSDictionary *user = dictionary[@"user"];
        self.user = [[User alloc] initWithDictionary:user];
        
        self.createdAtString = [self formatDateString:dictionary[@"created_at"]];
    }
    return self;
}

- (NSString *)formatDateString:(NSString *)createdAtOriginalString{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"E MMM d HH:mm:ss Z y";
    
    // Convert String to Date
    NSDate *createdAtDate = [formatter dateFromString:createdAtOriginalString];
    NSLog(@"%@", createdAtDate);
    NSTimeInterval timeAgo = createdAtDate.timeIntervalSinceNow;
    NSDate *timeAgoDate = [NSDate dateWithTimeIntervalSinceNow:timeAgo];
    
    // Configure output format
    formatter.dateStyle = NSDateFormatterShortStyle;
    formatter.timeStyle = NSDateFormatterNoStyle;
    
    // Convert Date to String
    if (timeAgo < 518400) { // 6 days in seconds
        return timeAgoDate.shortTimeAgoSinceNow;
    }
    return [formatter stringFromDate:createdAtDate];
}

+ (NSMutableArray *)tweetsWithArray:(NSArray *)dictionaries {
    NSMutableArray *tweets = [NSMutableArray array];
    for (NSDictionary *dictionary in dictionaries) {
        Tweet *tweet = [[Tweet alloc] initWithDictionary:dictionary];
        [tweets addObject:tweet];
    }
    return tweets;
}

- (void)toggleFavorite {
    if (self.favorited) {
        self.favoriteCount -= 1;
    } else {
        self.favoriteCount += 1;
    }
    self.favorited = !self.favorited;
}

- (void)toggleRetweet {
    if (self.retweeted) {
        self.retweetCount -= 1;
    } else {
        self.retweetCount += 1;
    }
    self.retweeted = !self.retweeted;
}

@end

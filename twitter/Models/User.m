//
//  User.m
//  twitter
//
//  Created by Sophia Zheng on 7/2/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "User.h"

@implementation User

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        self.name = dictionary[@"name"];
        self.screenName = dictionary[@"screen_name"];
        self.descriptionText = dictionary[@"description"];
        self.location = dictionary[@"location"];
        self.profileImageURL = [NSURL URLWithString:dictionary[@"profile_image_url_https"]];
        if (![dictionary[@"profile_background_image_url_https"] isEqual:[NSNull null]]){
            self.backgroundImageURL = [NSURL URLWithString:dictionary[@"profile_background_image_url_https"]];
        }
        self.followersCount = [NSString stringWithFormat:@"%@", dictionary[@"followers_count"]];
        self.followingCount = [NSString stringWithFormat:@"%@", dictionary[@"friends_count"]];
    }
    return self;
}

@end

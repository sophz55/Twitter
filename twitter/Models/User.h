//
//  User.h
//  twitter
//
//  Created by Sophia Zheng on 7/2/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *screenName;
@property (strong, nonatomic) NSString *descriptionText;
@property (strong, nonatomic) NSString *location;
@property (strong, nonatomic) NSURL *profileImageURL;
@property (strong, nonatomic) NSURL *backgroundImageURL;
@property (strong, nonatomic) NSString *followersCount;
@property (strong, nonatomic) NSString *followingCount;


- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

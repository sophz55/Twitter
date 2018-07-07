//
//  UserProfileViewController.m
//  twitter
//
//  Created by Sophia Zheng on 7/6/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "UserProfileViewController.h"
#import "UIImageView+AFNetworking.h"

@interface UserProfileViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *followingCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *followersCountLabel;

@end

@implementation UserProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupProfile];
}

- (void)setupProfile {
    self.backgroundImageView.image = nil;
    [self.backgroundImageView setImageWithURL:self.user.backgroundImageURL];
    
    self.profileImageView.image = nil;
    self.profileImageView.layer.cornerRadius = self.profileImageView.frame.size.height/2;
    [self.profileImageView setImageWithURL:self.user.profileImageURL];
    
    self.nameLabel.text = self.user.name;
    self.screenNameLabel.text = [@"@" stringByAppendingString:self.user.screenName];
    self.descriptionLabel.text = self.user.descriptionText;
    self.locationLabel.text = self.user.location;
    self.followingCountLabel.text = [self.user.followingCount stringByAppendingString:@" Following"];
    self.followersCountLabel.text = [self.user.followersCount stringByAppendingString:@" Followers"];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

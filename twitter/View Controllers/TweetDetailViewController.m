//
//  TweetDetailViewController.m
//  twitter
//
//  Created by Sophia Zheng on 7/6/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "TweetDetailViewController.h"
#import "UIImageView+AFNetworking.h"
#import "APIManager.h"

@interface TweetDetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *profileView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *createdAtLabel;
@property (weak, nonatomic) IBOutlet UILabel *retweetCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *favoriteCountLabel;
@property (weak, nonatomic) IBOutlet UIButton *replyButton;
@property (weak, nonatomic) IBOutlet UIButton *retweetButton;
@property (weak, nonatomic) IBOutlet UIButton *favoriteButton;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;

@end

@implementation TweetDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setCellWithTweet:self.tweet];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setCellWithTweet:(Tweet *)tweet {
    self.tweet = tweet;
    self.profileView.image = nil;
    self.profileView.layer.cornerRadius = self.profileView.frame.size.height/2;
    [self.profileView setImageWithURL:self.tweet.user.profileURL];
    self.nameLabel.text = self.tweet.user.name;
    self.createdAtLabel.text = self.tweet.createdAtString;
    self.screenNameLabel.text = [@"@" stringByAppendingString:self.tweet.user.screenName];
    self.contentLabel.text = self.tweet.text;
    [self.favoriteButton setSelected:self.tweet.favorited];
    self.favoriteCountLabel.text = [NSString stringWithFormat:@"%d Likes",self.tweet.favoriteCount];
    [self.retweetButton setSelected:self.tweet.retweeted];
    self.retweetCountLabel.text = [NSString stringWithFormat:@"%d Retweets",self.tweet.retweetCount];
    //    self.replyButton;
    //    self.replyCountLabel;
}

- (IBAction)didTapFavorite:(id)sender {
    [[APIManager shared] postFavorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
        if(error){
            NSLog(@"Error (un)favoriting tweet: %@", error.localizedDescription);
        } else{
            NSLog(@"Successfully (un)favorited the following Tweet: %@", tweet.text);
        }
    }];
    [self.favoriteButton setSelected:!self.favoriteButton.selected];
    [self.tweet toggleFavorite];
    self.favoriteCountLabel.text = [NSString stringWithFormat:@"%d Likes",self.tweet.favoriteCount];
}

- (IBAction)didTapRetweet:(id)sender {
    [[APIManager shared] postRetweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
        if(error){
            NSLog(@"Error (un)retweeting tweet: %@", error.localizedDescription);
        } else{
            NSLog(@"Successfully (un)retweeted the following Tweet: %@", tweet.text);
        }
    }];
    [self.retweetButton setSelected:!self.retweetButton.selected];
    [self.tweet toggleRetweet];
    self.retweetCountLabel.text = [NSString stringWithFormat:@"%d Retweets",self.tweet.retweetCount];
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

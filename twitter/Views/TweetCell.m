//
//  TweetCell.m
//  twitter
//
//  Created by Sophia Zheng on 7/2/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "TweetCell.h"
#import "UIImageView+AFNetworking.h"
#import "APIManager.h"

@implementation TweetCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (void)setCellWithTweet:(Tweet *)tweet {
    self.tweet = tweet;
    self.profileView.image = nil;
    self.profileView.layer.cornerRadius = self.profileView.frame.size.height/2;
    [self.profileView setImageWithURL:self.tweet.user.profileURL];
    self.nameLabel.text = self.tweet.user.name;
    self.createdAtLabel.text = [@"· " stringByAppendingString:self.tweet.createdAtString];
    self.screenNameLabel.text = [@"@" stringByAppendingString:self.tweet.user.screenName];
    self.contentLabel.text = self.tweet.text;
    [self.favoriteButton setSelected:self.tweet.favorited];
    self.favoriteCountLabel.text = [NSString stringWithFormat:@"%d",self.tweet.favoriteCount];
    [self.retweetButton setSelected:self.tweet.retweeted];
    self.retweetCountLabel.text = [NSString stringWithFormat:@"%d",self.tweet.retweetCount];
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
    [self refreshData];
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
    [self refreshData];
}

- (void)refreshData {
    self.retweetCountLabel.text = [NSString stringWithFormat:@"%d",self.tweet.retweetCount];
    self.favoriteCountLabel.text = [NSString stringWithFormat:@"%d",self.tweet.favoriteCount];
}

@end

//
//  TweetCell.m
//  twitter
//
//  Created by Sophia Zheng on 7/2/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "TweetCell.h"
#import "UIImageView+AFNetworking.h"

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
    [self.profileView setImageWithURL:self.tweet.user.profileURL];
    self.profileView.layer.cornerRadius = self.profileView.frame.size.height/2;
    self.nameLabel.text = self.tweet.user.name;
    self.createdAtLabel.text = self.tweet.createdAtString;
    self.screenNameLabel.text = [@"@" stringByAppendingString:self.tweet.user.screenName];
    self.contentLabel.text = self.tweet.text;
//    self.replyButton;
//    self.retweetButton;
//    self.favoriteButton;
//    self.replyCountLabel;
    self.retweetCountLabel.text = [NSString stringWithFormat:@"%d",self.tweet.retweetCount];
    self.favoriteCountLabel.text = [NSString stringWithFormat:@"%d",self.tweet.favoriteCount];
}

@end

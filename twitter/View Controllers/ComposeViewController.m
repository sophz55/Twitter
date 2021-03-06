//
//  ComposeViewController.m
//  twitter
//
//  Created by Sophia Zheng on 7/3/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "ComposeViewController.h"
#import "APIManager.h"

@interface ComposeViewController () <UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView *statusContentTextView;
@property (weak, nonatomic) IBOutlet UILabel *charactersRemainingLabel;
@property (weak, nonatomic) IBOutlet UIImageView *profileView;
@property (nonatomic) long characterLimit;

@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.statusContentTextView.delegate = self;
    
    self.profileView.layer.cornerRadius = self.profileView.frame.size.height/2;
    
    self.characterLimit = 280;
    self.charactersRemainingLabel.text = [NSString stringWithFormat:@"%ld characters remaining", self.characterLimit];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    textView.text = @"";
    textView.textColor = [UIColor blackColor];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    NSString *newText = [self.statusContentTextView.text stringByReplacingCharactersInRange:range withString:text];
    
    long charactersRemaining = self.characterLimit - newText.length;
    if (charactersRemaining <= 5) {
        self.charactersRemainingLabel.textColor = [UIColor redColor];
    } else {
        self.charactersRemainingLabel.textColor = [UIColor blackColor];
    }
    if (newText.length < self.characterLimit - 1) {
        self.charactersRemainingLabel.text = [NSString stringWithFormat:@"%ld characters remaining", charactersRemaining];
    } else if (newText.length == self.characterLimit - 1) {
        self.charactersRemainingLabel.text = @"1 character remaining";
    } else {
        self.charactersRemainingLabel.text = @"0 characters remaining";
    }
    
    return newText.length <= self.characterLimit;
}

- (IBAction)didTapClose:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

- (IBAction)didTapTweet:(id)sender {
    [[APIManager shared] postStatusWithText:self.statusContentTextView.text completion:^(Tweet *tweet, NSError *error) {
        if(error){
            NSLog(@"Error composing Tweet: %@", error.localizedDescription);
        } else {
            [self.delegate didPostTweet:tweet];
            NSLog(@"Compose Tweet Success!");
        }
    }];
    [self dismissViewControllerAnimated:true completion:nil];
}

/* #pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

//
//  ComposeViewController.m
//  twitter
//
//  Created by Sophia Zheng on 7/3/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "ComposeViewController.h"
#import "APIManager.h"

@interface ComposeViewController ()

@property (weak, nonatomic) IBOutlet UITextView *statusContentTextView;

@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

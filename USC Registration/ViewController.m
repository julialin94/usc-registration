//
//  ViewController.m
//  USC Registration
//
//  Created by hovincen on 2/8/15.
//  Copyright (c) 2015 HoLi. All rights reserved.
//

#import "ViewController.h"
#import "Term.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)viewWillAppear:(BOOL)animated{
    if(self.shownBefore){
        [self.logoViewBackground removeFromSuperview];
    }
    [self.navigationController setNavigationBarHidden:YES];
}
-(void)viewDidAppear:(BOOL)animated{
    [self getTermsWithCode:nil andSender:self];
    if(!self.shownBefore){
        self.shownBefore = YES;
        [UIView animateWithDuration:1.0
                              delay:0.0
                            options:UIViewAnimationOptionAutoreverse | UIViewAnimationOptionRepeat | UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             self.loadingLabel.alpha = 0.0;
                         }
                         completion:NULL];
        [UIView animateWithDuration:1.0
                              delay:2.0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             CGFloat centerX = [UIScreen mainScreen].bounds.size.width/2;
                             [self.animatedLogoImageView setFrame:CGRectMake(centerX-75, 28, 150, 150)];
                         }
                         completion:^(BOOL finished){
                             [UIView animateWithDuration:1.0
                                                   delay:0
                                                 options:UIViewAnimationOptionCurveEaseInOut
                                              animations:^{
                                                  self.logoViewBackground.alpha = 0.0;
                                              }
                                              completion:^(BOOL finished){
                                                  [self.animatedLogoImageView removeFromSuperview];
                                                  [self.logoViewBackground removeFromSuperview];
                                              }];
                         }];
    }
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSError * error;
    NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:self.responseData options:kNilOptions error:&error];
//    NSLog(@"dict: %@", dict);
    
    //should have received terms
    for(NSDictionary * term in dict){
        NSLog(@"%@", [term objectForKey:@"DESCRIPTION"]);
    }
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    NSLog(@"destination: %@", segue.destinationViewController);
}
- (IBAction)goButtonAction:(id)sender {
    [self performSegueWithIdentifier:@"go" sender:self];
}
@end

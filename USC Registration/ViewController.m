//
//  ViewController.m
//  USC Registration
//
//  Created by hovincen on 2/8/15.
//  Copyright (c) 2015 HoLi. All rights reserved.
//

#import "ViewController.h"
#import "Term.h"
#import "VHTermViewController.h"
#import "AppDelegate.h"
#import "MBProgressHUD.h"
@interface ViewController ()

@end

@implementation ViewController
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.tableViewCollapsed) {
        return 1;
    }
    return [self.terms count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(!self.tableViewCollapsed){
        //if it was open
        self.selectedTerm = [self.terms objectAtIndex:indexPath.row];
        self.appDelegate.term = [self.selectedTerm objectForKey:@"TERM_CODE"];
        [self goToTermView];
    }
    self.tableViewCollapsed = !self.tableViewCollapsed;
    [self.tableView reloadData];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    if(self.tableViewCollapsed){
        cell.textLabel.text = [self.selectedTerm objectForKey:@"DESCRIPTION"];
    }
    else{
        cell.textLabel.text = [self.terms[indexPath.row] objectForKey:@"DESCRIPTION"];
    }
    return cell;
}
-(void)goToTermView{
    self.appDelegate.progressHUD.labelText = @"Please wait.";
    self.appDelegate.progressHUD.detailsLabelText = [NSString stringWithFormat:@"Loading %@.", [self.selectedTerm objectForKey:@"DESCRIPTION"]];
    self.appDelegate.progressHUD.mode = MBProgressHUDModeDeterminateHorizontalBar;
    [self.navigationController.view addSubview:self.appDelegate.progressHUD];
    [self.appDelegate.progressHUD show:YES];
    dispatch_queue_t loadingQueue = dispatch_queue_create("loadingQueue",NULL);
    dispatch_async(loadingQueue, ^{
        self.term = [[Term alloc] initWithDictionary:(NSDictionary *)self.selectedTerm];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.appDelegate.progressHUD hide:YES];
            [self performSegueWithIdentifier:@"go" sender:self];
        });
    });
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.appDelegate = [UIApplication sharedApplication].delegate;
    self.appDelegate.progressHUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    self.appDelegate.progressHUD.square = YES;
    self.terms = [[NSArray alloc] init];
    self.isShowingList = [NSMutableArray array];
    self.openSectionIndex = NSNotFound;
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
    self.terms = [NSJSONSerialization JSONObjectWithData:self.responseData options:kNilOptions error:&error];
    [self.tableView reloadData];
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    NSLog(@"destination: %@", segue.destinationViewController);
    VHTermViewController * vc = segue.destinationViewController;
    vc.term = self.term;
    [self.navigationController setNavigationBarHidden:NO];
}
- (IBAction)goButtonAction:(id)sender {
    self.buttonClicked = YES;
    self.appDelegate.progressHUD.labelText = @"Please wait.";
    self.appDelegate.progressHUD.detailsLabelText = [NSString stringWithFormat:@"Loading %@.", [self.selectedTerm objectForKey:@"DESCRIPTION"]];
    self.appDelegate.progressHUD.mode = MBProgressHUDModeDeterminateHorizontalBar;
    [self.navigationController.view addSubview:self.appDelegate.progressHUD];
    [self.appDelegate.progressHUD show:YES];
    dispatch_queue_t loadingQueue = dispatch_queue_create("loadingQueue",NULL);
    dispatch_async(loadingQueue, ^{
        self.term = [[Term alloc] initWithDictionary:(NSDictionary *)self.selectedTerm];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.appDelegate.progressHUD hide:YES];
            [self.appDelegate.progressHUD removeFromSuperview];
            [self performSegueWithIdentifier:@"go" sender:self];
        });
    });
    
}
-(void)getTermsWithCode:(NSString *)code andSender:(id)sender{
    //gets term details
    if(code == nil)
        code = @"";
    NSString * url = [NSString stringWithFormat:@"%@/terms/%@", [self.appDelegate URL], code];
    NSLog(@"request URL: %@", url);
    [self performRequestWithURL:url andSender:sender];
}
-(void)performRequestWithURL:(NSString *)url andSender:(id)sender{
    //    NSLog(@"RequestParentViewController url: %@", url);
    NSLog(@"RequestParentViewController url: %@", [NSURL URLWithString:url]);
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:sender];
    [conn start];
    _responseData = [[NSMutableData alloc] init];
}
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    // A response has been received, this is where we initialize the instance var you created
    // so that we can append data to it in the didReceiveData method
    // Furthermore, this method is called each time there is a redirect so reinitializing it
    // also serves to clear it
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    // Append the new data to the instance variable you declared
    [_responseData appendData:data];
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse*)cachedResponse {
    // Return nil to indicate not necessary to store a cached response for this connection
    return nil;
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    // The request has failed for some reason!
    // Check the error var
    NSLog(@"connection failed: %@", error);
}
@end

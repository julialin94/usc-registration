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
#import "USColor.h"
#import "MBProgressHUD.h"
#import "JLTermTableViewCell.h"
@interface ViewController ()

@end

@implementation ViewController
#pragma mark UITableViewDelegate & UITableViewDataSource
-(void)reloadTableViewWithAnimation:(BOOL)animated{
    
    [self.tableView reloadData];
    [self reloadTableViewFrameWithAnimation:animated];
}
-(void)reloadTableViewFrameWithAnimation:(BOOL)animated{
    CGRect frame = self.tableView.frame;
    frame.origin.x = [[UIScreen mainScreen] bounds].size.width/2 - frame.size.width/2;
    frame.size.height = (self.tableViewCollapsed) ? 80 : 80*self.terms.count;
    if(animated)
        [UIView animateWithDuration:0.2
                              delay:0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             self.tableView.frame = frame;
                         }
                         completion:^(BOOL finished){
                             
                         }];
    else{
        dispatch_async(dispatch_get_main_queue(), ^{
            self.tableView.frame = frame;
        });
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.tableViewCollapsed) {
        return 1;
    }
    return [self.isShowingList count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(!self.tableViewCollapsed){
        //if it was open
        self.tableViewCollapsed = !self.tableViewCollapsed;
        self.selectedTerm = [self.isShowingList objectAtIndex:indexPath.row];
        self.appDelegate.term = [self.selectedTerm objectForKey:@"TERM_CODE"];
        [self.isShowingList removeAllObjects];
        [self.isShowingList addObject:self.terms[indexPath.row]];
        [self reloadTableViewWithAnimation:YES];
        [self goToTermView];
    }
    else{
        if(self.terms.count != 0){
            self.tableViewCollapsed = !self.tableViewCollapsed;
            self.isShowingList = [self.terms mutableCopy];
            [self reloadTableViewWithAnimation:YES];
        }
        else{
            //try to download again
            [self getTermsWithCode:nil andSender:self];
        }
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"termCell";
    JLTermTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[JLTermTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.arrowImage.hidden = !self.tableViewCollapsed;
    cell.termLabel.text = [[self.isShowingList objectAtIndex:indexPath.row] objectForKey:@"DESCRIPTION"];
    [cell.termLabel setTextColor:[USColor JLGoldColor]];
    [cell setBackgroundColor:[USColor JLCardinalColor]];
    // Remove seperator inset
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    // Prevent the cell from inheriting the Table View's margin settings
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
    // Explictly set your cell's layout margins
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    return cell;
}
#pragma mark View Load/Appear methods
- (void)viewDidLoad {
    [super viewDidLoad];
    self.appDelegate = [UIApplication sharedApplication].delegate;
    if(!self.terms){
        [self getTermsWithCode:nil andSender:self];
    }
    self.appDelegate.progressHUD = [[MBProgressHUD alloc] initWithView:self.view];
    self.appDelegate.progressHUD.square = YES;
    self.isShowingList = [NSMutableArray array];
    self.openSectionIndex = NSNotFound;
    
    self.tableView.layer.cornerRadius = 10.0;
    self.tableView.layer.borderColor = [[USColor JLGoldColor] CGColor];
    self.tableView.layer.borderWidth = 2.0;
    self.tableView.scrollEnabled = NO;
    self.selectedTerm = nil;
    self.tableViewCollapsed = YES;
    NSDictionary * dict = [[NSDictionary alloc] initWithObjects:[NSArray arrayWithObject:@"Select"] forKeys:[NSArray arrayWithObject:@"DESCRIPTION"]];
    [self.isShowingList addObject:dict];
}
-(void)viewWillAppear:(BOOL)animated{
    if(self.shownBefore){
        [self.logoViewBackground removeFromSuperview];
    }
    [self reloadTableViewWithAnimation:NO];
}
-(void)viewWillDisappear:(BOOL)animated{
    [self reloadTableViewFrameWithAnimation:NO];
}
-(void)viewDidAppear:(BOOL)animated{
    if(!self.shownBefore){
        self.shownBefore = YES;
        [self animatePulse];
    }
}
#pragma mark Animate
-(void)animateFade{
    
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
-(void)animatePulse{
    [UIView animateWithDuration:1.0
                          delay:0.0
                        options:UIViewAnimationOptionAutoreverse | UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.loadingLabel.alpha = 0.0;
                     }
                     completion:^(BOOL finished){
                         NSLog(@"doneConnecting: %d", self.doneConnecting);
                         if(self.doneConnecting){
                             [self animateFade];
                         }
                         else{
                             [self animatePulse];
                         }
                     }];
}
-(void)goToTermView{
    self.appDelegate.progressHUD.labelText = @"Please wait.";
    self.appDelegate.progressHUD.detailsLabelText = [NSString stringWithFormat:@"Loading %@.", [self.selectedTerm objectForKey:@"DESCRIPTION"]];
    self.appDelegate.progressHUD.mode = MBProgressHUDModeDeterminate;
    self.appDelegate.progressHUD.progress = 0.0;
    [self.view addSubview:self.appDelegate.progressHUD];
    [self.appDelegate.progressHUD show:YES];
    dispatch_queue_t loadingQueue = dispatch_queue_create("loadingQueue",NULL);
    dispatch_async(loadingQueue, ^{
        self.term = [[Term alloc] initWithDictionary:(NSDictionary *)self.selectedTerm];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.appDelegate.progressHUD hide:YES];
            [self reloadTableViewFrameWithAnimation:NO];
            [self performSegueWithIdentifier:@"go" sender:self];
        });
    });
}
#pragma mark NSURLConnection
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSError * error;
    self.terms = [NSJSONSerialization JSONObjectWithData:self.responseData options:kNilOptions error:&error];
    [self reloadTableViewWithAnimation:NO];
    self.doneConnecting = YES;
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
    self.doneConnecting = YES;
    UIAlertView * av = [[UIAlertView alloc] initWithTitle:@"Connection error!" message:@"Please check your internet connection." delegate:self cancelButtonTitle:@"OK!" otherButtonTitles:nil];
    [av show];
}
#pragma mark Segue
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
//    NSLog(@"destination: %@", segue.destinationViewController);
//    VHTermViewController * vc = segue.destinationViewController;
    self.appDelegate.termSchedule = [[TermSchedule alloc] init];
    self.appDelegate.termSchedule.termCode = self.term.termCode;
    self.appDelegate.termObject = self.term;
}
@end

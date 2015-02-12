//
//  RequestParentViewController.m
//  USC Registration
//
//  Created by Vincent Ho on 2/11/15.
//  Copyright (c) 2015 HoLi. All rights reserved.
//

#import "RequestParentViewController.h"

@interface RequestParentViewController ()

@end

static NSString * baseURL = @"http://petri.usc.edu/socAPI";
@implementation RequestParentViewController

#pragma mark NSURLConnection Delegate Methods
-(void)getCoursesWithTerm:(NSString *)term andOptions:(NSString *)options andSender:(id)sender{
    //get courses with term code
    //empty string gives all, all gives section, other gives courses
    NSString * url = [NSString stringWithFormat:@"%@/courses/%@/%@", baseURL, term, options];
    [self performRequestWithURL:url andSender:sender];
}
-(void)getSectionsWithID:(NSString *)sectionID andSender:(id)sender{
    //returns all sections with the id
    NSString * url = [NSString stringWithFormat:@"%@/sections/%@", baseURL, sectionID];
    [self performRequestWithURL:url andSender:sender];
}
-(void)getTermsWithCode:(NSString *)code andSender:(id)sender{
    //gets term details
    NSString * url;
    if(code == nil){
        url = [NSString stringWithFormat:@"%@/terms", baseURL];
    }
    else{
        url = [NSString stringWithFormat:@"%@/terms/%@", baseURL, code];
    }
    NSLog(@"request URL: %@", url);
    [self performRequestWithURL:url andSender:sender];
}
-(void)getSchoolWithName:(NSString *)name andSender:(id)sender{
    //get school with the department code provided, BUAD, etc
    NSString * url = [NSString stringWithFormat:@"%@/schools/%@", baseURL, name];
    [self performRequestWithURL:url andSender:sender];
}
-(void)getSessionsWithID:(NSString *)sessionID andSender:(id)sender{
    //input session identifier, retursn session information: start/end date etc
    NSString * url = [NSString stringWithFormat:@"%@/Sessions/%@", baseURL, sessionID];
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

//
//  RegistrationRequest.m
//  USC Registration
//
//  Created by hovincen on 2/8/15.
//  Copyright (c) 2015 HoLi. All rights reserved.
//

#import "RegistrationRequest.h"
static NSString * baseURL = @"http://www.petri.usc.edu/socAPI/";
@implementation RegistrationRequest
#pragma mark NSURLConnection Delegate Methods
-(void)getCoursesWithTerm:(NSString *)term andOptions:(NSString *)options{
    //get courses with term code
    //empty string gives all, all gives section, other gives courses
    NSString * url = [NSString stringWithFormat:@"%@/courses/%@/%@", baseURL, term, options];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [conn start];
}
-(void)getSectionsWithID:(NSString *)sectionID{
    //returns all sections with the id
    NSString * url = [NSString stringWithFormat:@"%@/sections/%@", baseURL, sectionID];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [conn start];
}
-(void)getTermsWithCode:(NSString *)code{
    //gets term details
    NSString * url;
    if(code == nil){
        url = [NSString stringWithFormat:@"%@", baseURL];
    }
    else{
        url = [NSString stringWithFormat:@"%@/terms/%@", baseURL, code];
    }
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [conn start];
}
-(void)getSchoolWithName:(NSString *)name{
    //get school with the department code provided, BUAD, etc
    NSString * url = [NSString stringWithFormat:@"%@/schools/%@", baseURL, name];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [conn start];
}
-(void)getSessionsWithID:(NSString *)sessionID{
    //input session identifier, retursn session information: start/end date etc
    NSString * url = [NSString stringWithFormat:@"%@/Sessions/%@", baseURL, sessionID];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [conn start];
}
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    // A response has been received, this is where we initialize the instance var you created
    // so that we can append data to it in the didReceiveData method
    // Furthermore, this method is called each time there is a redirect so reinitializing it
    // also serves to clear it
    _responseData = [[NSMutableData alloc] init];
    NSError * error;
    NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:self.responseData options:kNilOptions error:&error];
    NSLog(@"dict: %@", dict);
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

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    // The request is complete and data has been received
    // You can parse the stuff in your instance variable now
    
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    // The request has failed for some reason!
    // Check the error var
}
@end

//
//  RegistrationRequest.h
//  USC Registration
//
//  Created by hovincen on 2/8/15.
//  Copyright (c) 2015 HoLi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RegistrationRequest : NSObject<NSURLConnectionDelegate>
@property (nonatomic, strong) NSMutableData *responseData;
@end

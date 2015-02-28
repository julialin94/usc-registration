//
//  USColor.m
//  USC Registration
//
//  Created by hovincen on 2/8/15.
//  Copyright (c) 2015 HoLi. All rights reserved.
//

#import "USColor.h"

@implementation USColor
+(id)JLCardinalColor{
    return [super colorWithRed:153.0/255.0  green:0.0/255.0 blue:0.0/255.0 alpha:1.0];
//    return [super colorWithRed:0/255.0  green:0.0/255.0 blue:0.0/255.0 alpha:1.0];
}
+(id)JLGoldColor{
    return [super colorWithRed:255.0/255.0  green:204.0/255.0 blue:0.0/255.0 alpha:1.0];
}
+(id)JLLightGrayColor{
    return [super groupTableViewBackgroundColor];
}
+(id)JLLightBlueColor{
    return [super colorWithRed:11.0/255.0 green:145.0/255.0 blue:229.0/255.0 alpha:1.0];
}
+(id)JLDarkBlueColor{
    return [super colorWithRed:10.0/255.0 green:67.0/255.0 blue:102.0/255.0 alpha:1.0];
}
+(id)JLDarkRedColor{
    return [super colorWithRed:133.0/255.0 green:13.0/255.0 blue:13.0/255.0 alpha:1.0];
}
@end

//
//  ClassView.m
//  USC Registration
//
//  Created by Vincent Ho on 2/26/15.
//  Copyright (c) 2015 HoLi. All rights reserved.
//

#import "ClassView.h"
@implementation ClassView

- (instancetype)initWithSection:(Section *)section andWidth:(CGFloat) width
{
    self = [super init];
    self.s = section;
    self.width = width;
    NSDateFormatter * df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"HH:mm"];
    NSDate * start = [df dateFromString:section.beginTime];
    NSDate * end = [df dateFromString:section.endTime];
    [df setDateFormat:@"HH"];
    NSInteger startH = [[df stringFromDate:start] integerValue];
    NSInteger endH = [[df stringFromDate:end] integerValue];
    [df setDateFormat:@"mm"];
    NSInteger startM = [[df stringFromDate:start] integerValue];
    NSInteger endM = [[df stringFromDate:end] integerValue];
    startH -= 7;
    endH -= 7;
    NSInteger startY = (startH*60+startM)/2.0;
    NSInteger endY = (endH*60+endM)/2.0;
    self.layer.borderColor = [UIColor blackColor].CGColor;
    self.layer.borderWidth = 1.0f;
    self.backgroundColor = [UIColor cyanColor];
    CGFloat inset = 2.0;
    self.frame = CGRectMake(inset, startY, width - 2.0*inset, endY - startY);
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(1, 1, 10, 10)];
    label.text = @"X";
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor redColor];
    label.layer.borderWidth = 1.0;
    label.layer.borderColor = [UIColor blackColor].CGColor;
    label.font = [UIFont systemFontOfSize:12.0];
    [self addSubview:label];
    return self;
}
-(id)copy{
    ClassView * cv = [[ClassView alloc] initWithSection:self.s andWidth:self.width];
    cv.frame = self.frame;
    cv.layer.borderColor = [UIColor blackColor].CGColor;
    cv.layer.borderWidth = 1.0f;
    cv.backgroundColor = [UIColor cyanColor];
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(1, 1, 10, 10)];
    label.text = @"X";
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor redColor];
    label.layer.borderWidth = 1.0;
    label.layer.borderColor = [UIColor blackColor].CGColor;
    label.font = [UIFont systemFontOfSize:12.0];
    [cv addSubview:label];
    return cv;
}
@end

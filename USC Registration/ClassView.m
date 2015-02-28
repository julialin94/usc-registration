//
//  ClassView.m
//  USC Registration
//
//  Created by Vincent Ho on 2/26/15.
//  Copyright (c) 2015 HoLi. All rights reserved.
//

#import "ClassView.h"
#import "USColor.h"
#import "Section.h"
@implementation ClassView
-(void)conflict{
    self.hasConflict = YES;
    self.backgroundColor = [USColor JLCardinalColor];
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    if (self.selected) {
        [self deselect];
    }
    else{
        [self.delegate selectedClassView:self];
        [self select];
    }
}
-(void)deselect{
    self.selected = NO;
    [UIView animateWithDuration:0.2 animations:^{
        if (!self.hasConflict) {
            self.backgroundColor = [USColor JLLightBlueColor];
            self.label2.textColor = [USColor blackColor];
        }
        self.transform = CGAffineTransformMakeScale(1, 1);
        self.label.backgroundColor = [USColor clearColor];
        self.label.textColor = [USColor blackColor];
    }];
}
-(void)select{
    self.selected = YES;
    [UIView animateWithDuration:0.2 animations:^{
        if (!self.hasConflict) {
            self.backgroundColor = [USColor JLDarkBlueColor];
            self.label2.textColor = [USColor whiteColor];
        }
        self.transform = CGAffineTransformMakeScale(1.5, 1.5);
        self.label.backgroundColor = [USColor JLDarkBlueColor];
        self.label.textColor = [USColor whiteColor];
    }];
}
- (instancetype)initWithSection:(Section *)section andWidth:(CGFloat) width andCount:(NSInteger)count andLabel:(UILabel *)label andNumberInTBA:(NSInteger)num
{
    self = [super init];
    self.tbaCount = num;
    self.label = label;
    self.count = count;
    self.s = section;
    self.width = width;
    if ([section.beginTime isEqualToString:@"TBA"]) {
        NSInteger startY = 30*num;
        NSInteger endY = startY + 25;
        self.frame = CGRectMake(1, startY, width - 3, endY - startY);
    }
    else{
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
        self.frame = CGRectMake(1, startY, width - 3, endY - startY);
    }
    self.layer.borderColor = [USColor JLDarkBlueColor].CGColor;
    self.layer.borderWidth = 1.0f;
    self.backgroundColor = [USColor JLLightBlueColor];
    self.label2 = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, width-10, 10)];
    self.label2.font = [UIFont fontWithName:@"Roboto" size:12.0];
    self.label2.text = [NSString stringWithFormat:@"%ld.", (long)count];
    [self addSubview:self.label2];
    return self;
}
-(id)copy{
    ClassView * cv = [[ClassView alloc] initWithSection:self.s andWidth:self.width andCount:self.count andLabel:self.label andNumberInTBA:self.tbaCount];
//    cv.frame = self.frame;
//    cv.layer.borderColor = [USColor JLDarkBlueColor].CGColor;
//    cv.layer.borderWidth = 1.0f;
//    cv.backgroundColor = [USColor JLLightBlueColor];
//    UILabel * label2 = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, self.width-10, 10)];
//    label2.font = [UIFont fontWithName:@"Roboto" size:12.0];
//    label2.text = [NSString stringWithFormat:@"%ld.", (long)self.count];
//    [cv addSubview:label2];
    return cv;
}
@end

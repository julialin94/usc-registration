//
//  Popup.m
//  USC Registration
//
//  Created by Vincent Ho on 2/26/15.
//  Copyright (c) 2015 HoLi. All rights reserved.
//

#import "Popup.h"

@implementation Popup
-(id)init{
    CGRect frame = [UIApplication sharedApplication].keyWindow.frame;
    self = [super initWithFrame:frame];
    self.backgroundColor = [UIColor clearColor];
    CGFloat width = frame.size.width - 30.0;
    CGFloat height = frame.size.height - 45.0;
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(15, -height, width, height)];
    self.backgroundButton = [[UIButton alloc] initWithFrame:frame];
    self.backgroundButton.backgroundColor = [UIColor blackColor];
    self.backgroundButton.alpha = 0.0;
    self.scrollView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.scrollView];
    self.closeButton = [[UIButton alloc] initWithFrame:CGRectMake(-15, -15, 30, 30)];
    self.closeButton.backgroundColor = [UIColor blueColor];
    self.closeButton.layer.cornerRadius = self.closeButton.frame.size.width/2;
    [self.closeButton setTitle:@"X" forState:UIControlStateNormal];
    self.closeButton.showsTouchWhenHighlighted = YES;
    [self.scrollView addSubview:self.closeButton];
    return self;
}
-(void)show{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [[UIApplication sharedApplication].keyWindow bringSubviewToFront:self];
    [self addSubview:self.backgroundButton];
    [self sendSubviewToBack:self.backgroundButton];
    [UIView animateWithDuration:0.2
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.backgroundButton.alpha = 0.7;
                         self.scrollView.frame = CGRectMake(15, 30, self.scrollView.frame.size.width, self.scrollView.frame.size.height);
                     }
                     completion:^(BOOL finished){
                         
                     }];
}
-(void)hide{
    [UIView animateWithDuration:0.2
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.backgroundButton.alpha = 0.0;
                         self.scrollView.frame = CGRectMake(15, -self.scrollView.frame.size.height, self.scrollView.frame.size.width, self.scrollView.frame.size.height);
                     }
                     completion:^(BOOL finished){
                         [self.backgroundButton removeFromSuperview];
                         [self removeFromSuperview];
                     }];
}
@end

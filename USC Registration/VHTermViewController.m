//
//  VHTermViewController.m
//  USC Registration
//
//  Created by Vincent Ho on 2/11/15.
//  Copyright (c) 2015 HoLi. All rights reserved.
//

#import "VHTermViewController.h"

@interface VHTermViewController ()

@end

@implementation VHTermViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    UISwipeGestureRecognizer *rightSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(rightSwipeHandle:)];
    rightSwipe.direction = UISwipeGestureRecognizerDirectionRight;
    [rightSwipe setNumberOfTouchesRequired:1];
    UISwipeGestureRecognizer *leftSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(leftSwipeHandle:)];
    leftSwipe.direction = UISwipeGestureRecognizerDirectionLeft;
    [leftSwipe setNumberOfTouchesRequired:1];
    
    //add the your gestureRecognizer , where to detect the touch..
    [self.menuView addGestureRecognizer:leftSwipe];
    [self.menuView addGestureRecognizer:rightSwipe];
    self.arrayOfLabels = [[NSMutableArray alloc] initWithObjects:self.schoolLabel, self.departmentLabel, self.prefixLabel, nil];
//    [self getSchoolWithName:nil andSender:self];
}
-(void)viewDidAppear:(BOOL)animated{
    
    CGRect frame = self.schoolLabel.frame;
    self.lineView = [[UIView alloc] initWithFrame:CGRectMake(frame.origin.x, frame.origin.y+frame.size.height+2, frame.size.width, 3)];
    self.lineView.backgroundColor = [UIColor redColor];
    [self.menuView addSubview:self.lineView];
    [self.menuView bringSubviewToFront:self.lineView];
    self.index = 0;
}
-(void)reloadView{
    [UIView animateWithDuration:0.2
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         CGRect frame = ((UILabel *)self.arrayOfLabels[self.index]).frame;
                         [self.lineView setFrame:CGRectMake(frame.origin.x, frame.origin.y+frame.size.height+2, frame.size.width, 3)];
                     }
                     completion:^(BOOL finished){
                         
                     }];
}
- (void)rightSwipeHandle:(UISwipeGestureRecognizer*)gestureRecognizer
{
    if(self.index>0){
        self.index--;
        [self reloadView];
    }
}

- (void)leftSwipeHandle:(UISwipeGestureRecognizer*)gestureRecognizer
{
    if(self.index<2){
        self.index++;
        [self reloadView];
    }
}
-(void)setTerm:(NSDictionary *)term{
    [self setTitle:[term objectForKey:@"DESCRIPTION"]];
    NSLog(@"Term: %@", term);
}
//- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
//    NSError * error;
//    NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:self.responseData options:kNilOptions error:&error];
//    for(NSDictionary * term in dict){
//        NSLog(@"%@", term);
//    }
//}
@end

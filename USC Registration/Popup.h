//
//  Popup.h
//  USC Registration
//
//  Created by Vincent Ho on 2/26/15.
//  Copyright (c) 2015 HoLi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Popup : UIView
@property (nonatomic, strong) UIScrollView * scrollView;
@property (nonatomic, strong) UIButton * backgroundButton;
@property (nonatomic, strong) UIButton * closeButton;
-(void)show;
-(void)hide;
@end

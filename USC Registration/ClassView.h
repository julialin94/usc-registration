//
//  ClassView.h
//  USC Registration
//
//  Created by Vincent Ho on 2/26/15.
//  Copyright (c) 2015 HoLi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Section;
@protocol ClassViewDelegate <NSObject>
@required
- (void) selectedClassView:(id)cv;
@end
@interface ClassView : UIView
@property (nonatomic, strong) id <ClassViewDelegate> delegate;
@property (nonatomic, strong) Section * s;
@property (nonatomic) CGFloat width;
@property (nonatomic) NSInteger count;
@property (nonatomic) NSInteger tbaCount;
@property (nonatomic) BOOL selected;
@property (nonatomic) BOOL hasConflict;
@property (nonatomic, strong) UILabel * label;
@property (nonatomic, strong) UILabel * label2;
- (instancetype)initWithSection:(Section *)section andWidth:(CGFloat) width andCount:(NSInteger)count andLabel:(UILabel *)label andNumberInTBA:(NSInteger)num;
-(void)deselect;
-(void)conflict;
@end

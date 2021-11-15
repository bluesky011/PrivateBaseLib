//
//  CustomPickerView.m
//  test
//
//  Created by linyansen on 2018/3/21.
//  Copyright © 2018年 linyansen. All rights reserved.
//

#import "CustomPickerView.h"

#define kMainScreenWidth [UIScreen mainScreen].bounds.size.width
#define kMainScreenHeight [UIScreen mainScreen].bounds.size.height
@interface CustomPickerView ()<UIPickerViewDelegate,UIPickerViewDataSource>

@property (strong, nonatomic) UIView *toolBarView;
@property (strong, nonatomic) UIView *selectDateView;
@property (strong, nonatomic) UIDatePicker *datePicker;
@property (assign, nonatomic) BOOL isStartDateSelected;
@property (strong, nonatomic) UIButton *startDateBtn;
@property (strong, nonatomic) UIButton *endDateBtn;
@property (strong, nonatomic) UIView *startDateLineView;
@property (strong, nonatomic) UIView *endDateBtnLineView;
@property (strong, nonatomic) NSString *startDateStr;
@property (strong, nonatomic) NSString *endDateStr;
@end

@implementation CustomPickerView


- (instancetype)initWithFrame:(CGRect)frame
{

    if(self = [super initWithFrame:frame])
    {

    }
    
    return self;
}




+ (void)print
{
    NSLog(@"Hello World!");
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

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
//    if (frame.size.height >= 355) {
//        frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, 355);
//    }
    if(self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor whiteColor];
        [self addToolBarView];
        [self addSelectDateView];
        [self addDatePicker];
    }
    
    return self;
}

- (void)addToolBarView
{
    self.toolBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 40)];
    self.toolBarView.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:self.toolBarView];
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame = CGRectMake(0, 0, 60, 40);
//    [cancelBtn setBackgroundColor:[UIColor redColor]];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancelBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.toolBarView addSubview:cancelBtn];
    
    UIButton *finishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    finishBtn.frame = CGRectMake(kMainScreenWidth-60, 0, 60, 40);
//    [finishBtn setBackgroundColor:[UIColor redColor]];
    [finishBtn setTitle:@"完成" forState:UIControlStateNormal];
    [finishBtn addTarget:self action:@selector(finishBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.toolBarView addSubview:finishBtn];
}


- (void)cancelBtnClick:(UIButton *)sender
{
    if (self.btnClickBlock) {
        self.btnClickBlock(sender);
    }
}


- (void)finishBtnClick:(UIButton *)sender
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];//设置输出的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    self.endDateStr = [dateFormatter stringFromDate:self.datePicker.date];
    NSString *str = [NSString stringWithFormat:@"%@-%@",self.startDateStr,self.endDateStr];
    NSLog(@"%@",str);
    if (self.btnClickBlock) {
        self.btnClickBlock(sender);
    }
}

- (void)addSelectDateView
{
    self.selectDateView = [[UIView alloc] initWithFrame:CGRectMake(0, 40, kMainScreenWidth, 65)];
    self.selectDateView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.selectDateView];
    
    UIButton *startDateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    startDateBtn.frame = CGRectMake(15, 10, 170, 45);
    //    [cancelBtn setBackgroundColor:[UIColor redColor]];
    [startDateBtn setTitle:@"开始时间" forState:UIControlStateNormal];
    [startDateBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [startDateBtn addTarget:self action:@selector(startDateBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    _startDateBtn = startDateBtn;
    [self.selectDateView addSubview:startDateBtn];
    
    UIView *startDateLineView = [[UIView alloc] initWithFrame:CGRectMake(15, 55, 170, 1)];
    startDateLineView.backgroundColor = [UIColor lightGrayColor];
    _startDateLineView = startDateLineView;
    [self.selectDateView addSubview:startDateLineView];
    
    
    UIButton *endDateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    endDateBtn.frame = CGRectMake(kMainScreenWidth-15-170, 10, 170, 45);
    //    [cancelBtn setBackgroundColor:[UIColor redColor]];
    [endDateBtn setTitle:@"结束时间" forState:UIControlStateNormal];
    [endDateBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [endDateBtn addTarget:self action:@selector(endDateBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    _endDateBtn = endDateBtn;
    [self.selectDateView addSubview:endDateBtn];
    
    UIView *endDateBtnLineView = [[UIView alloc] initWithFrame:CGRectMake(kMainScreenWidth-15-170, 55, 170, 1)];
    endDateBtnLineView.backgroundColor = [UIColor lightGrayColor];
    _endDateBtnLineView = endDateBtnLineView;
    [self.selectDateView addSubview:endDateBtnLineView];
    
    
    UILabel *tip = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, 30, 45)];
    tip.textAlignment = NSTextAlignmentCenter;
    tip.center = CGPointMake(self.selectDateView.center.x, tip.center.y);
    tip.text = @"至";
    [self.selectDateView addSubview:tip];
    
    self.isStartDateSelected = YES;
}

- (void)startDateBtnClick:(UIButton *)sender
{
    self.isStartDateSelected = YES;
}

- (void)endDateBtnClick:(UIButton *)sender
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];//设置输出的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    self.startDateStr = [dateFormatter stringFromDate:self.datePicker.date];
    NSLog(@"%@",self.startDateStr);
    [self.startDateBtn setTitle:self.startDateStr forState:UIControlStateNormal];
    self.isStartDateSelected = NO;
}


- (void)addDatePicker
{
    self.datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 105, self.frame.size.width, 240)];
    self.datePicker.backgroundColor = [UIColor whiteColor];
    if (@available(iOS 14.0, *)) {
        self.datePicker.preferredDatePickerStyle = UIDatePickerStyleWheels;
    }
    
    
    [self.datePicker setDatePickerMode:UIDatePickerModeDate];
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];//设置为中文
    self.datePicker.locale = locale;
//    [self.datePicker addTarget:self action:@selector(dateChange:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:self.datePicker];
    

}


- (void)dateChange:(UIDatePicker *)sender
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];//设置输出的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *str = [dateFormatter stringFromDate:sender.date];
    NSLog(@"%@",str);
    
    if (self.isStartDateSelected == YES) {
        [self.startDateBtn setTitle:str forState:UIControlStateNormal];
    }
    else
    {
        [self.endDateBtn setTitle:str forState:UIControlStateNormal];
    }
}

- (void)setIsStartDateSelected:(BOOL)isStartDateSelected
{
    _isStartDateSelected = isStartDateSelected;
    if (_isStartDateSelected == YES) {
        [self.startDateBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        self.startDateLineView.backgroundColor = [UIColor blueColor];
        [self.endDateBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        self.endDateBtnLineView.backgroundColor = [UIColor lightGrayColor];
    }
    else
    {
        [self.startDateBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        self.startDateLineView.backgroundColor = [UIColor lightGrayColor];
        [self.endDateBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        self.endDateBtnLineView.backgroundColor = [UIColor blueColor];
    }
}



//- (void)show
//{
//    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionBeginFromCurrentState|7<<16 animations:^{
//        self.frame = CGRectMake(0, kMainScreenHeight-400, kMainScreenWidth, 400);
//
//    } completion:^(BOOL finished) {
//    }];
//}
//
//- (void)dismiss
//{
//    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionBeginFromCurrentState|7<<16 animations:^{
//        self.frame = CGRectMake(0, kMainScreenHeight, kMainScreenWidth, 400);
//
//    } completion:^(BOOL finished) {
//    }];
//}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

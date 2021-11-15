//
//  CustomPickerView.h
//  test
//
//  Created by linyansen on 2018/3/21.
//  Copyright © 2018年 linyansen. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void (^BtnClickBlock) (UIButton *btn);
@interface CustomPickerView : UIView


@property (nonatomic, copy) BtnClickBlock btnClickBlock;
- (void)show;
- (void)dismiss;
@end

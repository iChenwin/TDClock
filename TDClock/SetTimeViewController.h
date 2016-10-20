//
//  SetTimeViewController.h
//  TDClock
//
//  Created by wayne on 16/10/20.
//  Copyright © 2016年 wayne. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SetTimeViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>
- (instancetype)initWithVC:(UIViewController *)father;
@end

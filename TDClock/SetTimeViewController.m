//
//  SetTimeViewController.m
//  TDClock
//
//  Created by wayne on 16/10/20.
//  Copyright © 2016年 wayne. All rights reserved.
//

#import "SetTimeViewController.h"

@interface SetTimeViewController ()
@property (strong, nonatomic) UIViewController *fatherVC;
@property (assign, nonatomic) NSArray *hourArr;
@property (assign, nonatomic) NSArray *minArr;
@property (weak, nonatomic) IBOutlet UIPickerView *timePickerView;

@end

@implementation SetTimeViewController

- (instancetype)initWithVC:(UIViewController *)father {
    self = [super init];
    if (self) {
        self.fatherVC = father;
        
        self.title = @"番茄时长";
        UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(saveAction:)];
        self.navigationItem.rightBarButtonItem = doneBtn;
        
//        self.hourArr = [NSArray arrayWithObjects: @"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"11", @"12", nil];
//        self.minArr = [NSArray arrayWithObjects: @"0", @"5", @"10", @"15", @"20", @"25", @"30", @"35", @"40", @"45", @"50", @"55", nil];
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.hourArr = [NSArray arrayWithObjects: @"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"11", @"12", nil];
    self.minArr = [NSArray arrayWithObjects: @"0", @"5", @"10", @"15", @"20", @"25", @"30", @"35", @"40", @"45", @"50", @"55", nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.timePickerView.delegate = self;
    self.timePickerView.dataSource = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (1 == component) {
        return [self.minArr count];
    } else {
        return [self.hourArr count];
    }
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (1 == component) {
        return self.minArr[row];
    } else {
        return self.hourArr[row];
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:
(NSInteger)row inComponent:(NSInteger)component
{
    // 使用一个UIAlertView来显示用户选中的列表项
    UIAlertView* alert = [[UIAlertView alloc]
                          initWithTitle:@"提示"
                          message:[NSString stringWithFormat:@"你选中的时间是：%@:%@"
                                   , [self.hourArr objectAtIndex:row], [self.minArr objectAtIndex:row]]
                          delegate:nil
                          cancelButtonTitle:@"确定"
                          otherButtonTitles:nil];
    [alert show];
}

-(void)saveAction:(id)sender {
    [self.fatherVC.navigationController popViewControllerAnimated:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

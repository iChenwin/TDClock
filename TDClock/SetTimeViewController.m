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
@property (strong, nonatomic) NSArray *minArr;
@property (assign, nonatomic) NSInteger savedTime;
@property (weak, nonatomic) IBOutlet UIPickerView *timePickerView;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end

@implementation SetTimeViewController

- (instancetype)initWithVC:(UIViewController *)father {
    self = [super init];
    if (self) {
        self.fatherVC = father;
        
        self.title = @"番茄时长";
        UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(saveAction:)];
        self.navigationItem.rightBarButtonItem = doneBtn;
        self.minArr = [NSArray arrayWithObjects: @"Default", @"5", @"10", @"15", @"20", @"25", @"30", @"35", @"40", @"45", @"50", @"55", nil];
        
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.timePickerView.delegate = self;
    self.timePickerView.dataSource = self;
    
    self.timePickerView.hidden = YES;
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSInteger savedTime = [userDefault integerForKey:@"savedTime"];
    if (0 == savedTime) {
        [self.timePickerView selectRow:5 inComponent:0 animated:NO];
        [self.timeLabel setText:self.minArr[5]];
    } else {
        [self.timePickerView selectRow:savedTime / 5 inComponent:0 animated:NO];
        self.savedTime = savedTime;
        [self.timeLabel setText:self.minArr[savedTime / 5]];
    }
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelTappedAction:)];
    self.timeLabel.userInteractionEnabled = YES;
    [self.timeLabel addGestureRecognizer:tap];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [self.minArr count];
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return self.minArr[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    // 使用一个UIAlertView来显示用户选中的列表项
    self.savedTime = [self.minArr[row] integerValue];
    self.timePickerView.hidden = YES;
    self.timeLabel.hidden = NO;
    [self.timeLabel setText:self.minArr[row]];
}

- (void)labelTappedAction:(UITapGestureRecognizer *)sender {
    self.timePickerView.hidden = NO;
    self.timeLabel.hidden = YES;
}

-(void)saveAction:(id)sender {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setInteger:self.savedTime forKey:@"savedTime"];
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

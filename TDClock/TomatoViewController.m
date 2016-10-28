//
//  FirstViewController.m
//  TDClock
//
//  Created by wayne on 16/10/17.
//  Copyright © 2016年 wayne. All rights reserved.
//

#import "TomatoViewController.h"
#import "SetTimeViewController.h"

#define DEFAULT_CLOCK 10

@interface TomatoViewController ()
@property (weak, nonatomic) IBOutlet UILabel *countDownLabel;
@property (strong, nonatomic) NSTimer *countDownTimer;
@property (weak, nonatomic) IBOutlet UIButton *startTimerButton;
@property (assign, nonatomic) BOOL isStart;
@end

@implementation TomatoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSInteger savedTime = [userDefault integerForKey:@"savedTime"];
    
    if (0 == savedTime) {
        self.secondsCountDown = 1500;
    } else {
        self.secondsCountDown = savedTime * 60;
    }

    long minutePart = self.secondsCountDown / 60;
    long secondPart = self.secondsCountDown % 60;
    NSString *timeString = [[NSString alloc] initWithFormat:@"%ld:%.2ld", minutePart, secondPart];
    self.countDownLabel.text = timeString;
    NSLog(@"%d", self.startTimerButton.isSelected);
    self.startTimerButton.layer.cornerRadius = 10.0f;
    
//    self.navigationController.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSInteger savedTime = [userDefault integerForKey:@"savedTime"];
    
    if (self.isStart == NO) {
        if (0 == savedTime) {
            self.secondsCountDown = 1500;
        } else {
            self.secondsCountDown = savedTime * 60;
        }
        
        long minutePart = self.secondsCountDown / 60;
        long secondPart = self.secondsCountDown % 60;
        NSString *timeString = [[NSString alloc] initWithFormat:@"%ld:%.2ld", minutePart, secondPart];
        self.countDownLabel.text = timeString;
    }
}

-(void)viewWillDisappear:(BOOL)animated {
}

- (IBAction)startTimer:(id)sender {
    
    if (self.isStart == NO) {
        self.countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES];
        self.countDownLabel.textColor = [UIColor grayColor];
        self.countDownLabel.font = [UIFont systemFontOfSize: 100];
        [self.startTimerButton setTitle:@"取消" forState:UIControlStateNormal];
        self.isStart = YES;
    } else {
        [self.countDownTimer invalidate];
        self.countDownTimer = nil;
        self.countDownLabel.textColor = [UIColor blackColor];
        self.countDownLabel.font = [UIFont systemFontOfSize: 80];
        [self.startTimerButton setTitle:@"开始" forState:UIControlStateNormal];
        
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        NSInteger savedTime = [userDefault integerForKey:@"savedTime"];
        if (0 == savedTime) {
            self.secondsCountDown = 1500;
        } else {
            self.secondsCountDown = savedTime * 60;
        }
        self.countDownLabel.text = [NSString stringWithFormat:@"%ld:%.2ld",
                                    self.secondsCountDown / 60,
                                    self.secondsCountDown % 60];
        self.isStart = NO;
    }
    
}

-(void)timeFireMethod{
    self.secondsCountDown--;
    self.countDownLabel.text = [NSString stringWithFormat:@"%ld:%.2ld",
                                                          self.secondsCountDown / 60,
                                                          self.secondsCountDown % 60];
    NSLog(@"%d", self.startTimerButton.isSelected);
    if(self.secondsCountDown == 0) {
        [self.countDownTimer invalidate];
        [self.startTimerButton setTitle:@"完成" forState:UIControlStateNormal];
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"一个番茄时间已完成" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"完成" style:UIAlertActionStyleDefault handler:^(UIAlertAction *_Nonnull action) {
            
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"记录" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        [self presentViewController:alert animated:true completion:nil];
    }
}

- (IBAction)setTimeAction:(id)sender {
    SetTimeViewController *setTimeVC = [[SetTimeViewController alloc] initWithVC:self];
    [setTimeVC setHidesBottomBarWhenPushed:YES];
    UIBarButtonItem *backBtn = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backBtn;
    [self.navigationController pushViewController:setTimeVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

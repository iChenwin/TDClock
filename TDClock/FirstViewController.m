//
//  FirstViewController.m
//  TDClock
//
//  Created by wayne on 16/10/17.
//  Copyright © 2016年 wayne. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()
@property (weak, nonatomic) IBOutlet UILabel *countDownLabel;
@property (strong, nonatomic) NSTimer *countDownTimer;
@property (weak, nonatomic) IBOutlet UIButton *startTimerButton;
@property (assign, nonatomic) BOOL isStart;
@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.secondsCountDown = 25 * 60;
    long minutePart = self.secondsCountDown / 60;
    long secondPart = self.secondsCountDown % 60;
    NSString *timeString = [[NSString alloc] initWithFormat:@"%ld:%.2ld", minutePart, secondPart];
    self.countDownLabel.text = timeString;
    NSLog(@"%d", self.startTimerButton.isSelected);
    self.startTimerButton.layer.cornerRadius = 3.0f;
    
    
}
- (IBAction)startTimer:(id)sender {
    
    if (self.isStart == NO) {
        self.countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES];
        self.countDownLabel.textColor = [UIColor grayColor];
        self.countDownLabel.font = [UIFont systemFontOfSize: 60];
        self.isStart = YES;
    } else {
//        [self.countDownTimer ]
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
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

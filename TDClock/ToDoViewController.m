//
//  SecondViewController.m
//  TDClock
//
//  Created by wayne on 16/10/17.
//  Copyright © 2016年 wayne. All rights reserved.
//

#import "ToDoViewController.h"

@interface ToDoViewController ()
@property (strong, nonatomic) NSMutableArray *eventArr;
@end

@implementation ToDoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.eventArr count] == 0) {
        UITableViewCell *cell = [[UITableViewCell alloc] init];
        cell.textLabel.text = @"点击右上角‘+’号添加事件";
        return cell;
    } else {
        UITableViewCell *cell = self.eventArr[indexPath.row];
        return cell;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([self.eventArr count] == 0) {
        return 1;
    } else {
        return [self.eventArr count];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 30;
}

@end

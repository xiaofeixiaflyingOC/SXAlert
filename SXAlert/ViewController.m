//
//  ViewController.m
//  SXAlert
//
//  Created by shengxin on 16/6/23.
//  Copyright © 2016年 shengxin. All rights reserved.
//

#import "ViewController.h"
#import "SXAlertCenter.h"
#import "SXLoading.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *iTableView;
@property (nonatomic, strong) SXLoading *iSXLoading;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.iTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.iTableView.delegate = self;
    self.iTableView.dataSource = self;
    [self.view addSubview:self.iTableView];
//    self.iSXLoading = [[SXLoading alloc] initWithMessage:@"发送中⋯⋯"];
    self.iSXLoading = [[SXLoading alloc] initWithMessage:@"发送中⋯⋯"];
    [self.iSXLoading setShowBoarder:YES];
    __weak ViewController *weself = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weself.iSXLoading hideWithAnimated:YES];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifer = @"11111111";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
    }
    cell.textLabel.text = @"1";
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [SXAlertCenter defaultCenter].alertPosition = SXAlertPositionCenter;
//    [[SXAlertCenter defaultCenter] postAlertWithMessage:@"取消收藏"];
//    [[SXAlertCenter defaultCenter] postAlertWithMessage:@"取消收藏" image:[UIImage imageNamed:@"successImage"]];
    [self.iSXLoading showInView:self.view modaled:NO];
}
@end

//
//  ReduceViewController.m
//  Limit_1509
//
//  Created by gaokunpeng on 15/7/27.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "ReduceViewController.h"
#import "LimitModel.h"
#import "ReduceCell.h"

@interface ReduceViewController ()<MyDownloaderDelegate>

@end

@implementation ReduceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self creatNav];
    [self downloadData];
}

//导航
-(void)creatNav
{
    [self addNavBtn:CGRectMake(0, 0, 60, 36) title:@"" target:self action:@selector(gotoCategry:) isLeft:YES];
    [self addNavTitle:CGRectMake(60, 0, 255, 44) title:@""];
    [self addNavBtn:CGRectMake(0, 0, 60, 36) title:@"" target:self action:@selector(gotoSet:) isLeft:NO];
}

-(void)gotoCategry:(id)sender{}

-(void)gotoSet:(id)sender{}

-(void)downloadData
{
    MyDownloader *download = [[MyDownloader alloc] init];
    download.delegate = self;
    
    NSInteger curPage = 1;
    NSString *urlString = [NSString stringWithFormat:kReduceUrl,curPage];
    [download downloadWithUrlString:urlString];
}


#pragma makr - Mydownloader代理
-(void)downloader:(MyDownloader *)downloader failWithError:(NSError *)error
{
    
}

-(void)downloaderFinish:(MyDownloader *)downloader
{
    id result = [NSJSONSerialization JSONObjectWithData:downloader.receiveData options:NSJSONReadingMutableContainers error:nil];
    if ([result isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dict = result;
        NSArray *appArray = dict[@"applications"];
        for(NSDictionary *appDict in appArray)
        {
            LimitModel *model = [[LimitModel alloc] init];
            [model setValuesForKeysWithDictionary:appDict];
            [_dataArray addObject:model];
        }
    }
}


#pragma mark - UITableView代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"reduceCellId";
    //从重用队列获取
    ReduceCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (nil == cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ReduceCell" owner:nil options:nil] lastObject];
    }
    //模型对象
    LimitModel *model = _dataArray[indexPath.row];
    [cell configModel:model index:indexPath.row];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

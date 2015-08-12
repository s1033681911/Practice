//
//  LimitFreeViewController.m
//  Limit_1509
//
//  Created by gaokunpeng on 15/7/27.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "LimitFreeViewController.h"
#import "LimitModel.h"
#import "LimitCell.h"


@interface LimitFreeViewController ()<MyDownloaderDelegate,UISearchBarDelegate>
{
    
    
}

@end

@implementation LimitFreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //导航
    [self createMyNav];
    
     [self creatSearcherBar];
}


-(void)creatSearcherBar
{
    UISearchBar *searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, 375, 30)];
    searchBar.delegate = self;
    searchBar.placeholder = @"baidu";
    _tbView.tableHeaderView = searchBar;
    
}



//下载数据
- (void)downloadData
{
    
    //修改下载的状态
    _isLoading = YES;
    
    MyDownloader *downloader = [[MyDownloader alloc] init];
    downloader.delegate = self;
    

    NSString *urlString = [NSString stringWithFormat:kLimitUrl,_curPage];
    [downloader downloadWithUrlString:urlString];
}

//创建导航
- (void)createMyNav
{
    //标题
    [self addNavTitle:CGRectMake(60, 0, 255, 44) title:@"限免"];
    //分类
    [self addNavBtn:CGRectMake(0, 0, 60, 36) title:@"分类" target:self action:@selector(gotoCategory:) isLeft:YES];
    //设置
    [self addNavBtn:CGRectMake(0, 0, 60, 36) title:@"设置" target:self action:@selector(gotoSet:) isLeft:NO];
    
}
//分类
- (void)gotoCategory:(id)sender{}
//设置
- (void)gotoSet:(id)sender{}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - MyDownloader代理
//下载失败
-(void)downloader:(MyDownloader *)downloader failWithError:(NSError *)error
{
    NSLog(@"%@",error);
}

//下载成功
-(void)downloaderFinish:(MyDownloader *)downloader
{
    //下拉刷新
    if (_curPage == 1) {
        [_dataArray removeAllObjects];
    }
    
    
    //解析数据
    id result = [NSJSONSerialization JSONObjectWithData:downloader.receiveData options:NSJSONReadingMutableContainers error:nil];
    if ([result isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dict = result;
        
        NSArray *appArray = dict[@"applications"];
        for (NSDictionary *appDict in appArray) {
            //创建模型对象
            LimitModel *model = [[LimitModel alloc] init];
            //kvc设置属性
            [model setValuesForKeysWithDictionary:appDict];
            //添加到数据源数组中
            [_dataArray addObject:model];
            
        }
        
        //刷新表格
        [_tbView reloadData];
        
        //修改下载的状态
        _isLoading = NO;
        
        [_headerView endRefreshing];
        [_footerView endRefreshing];
        
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
    static NSString *cellId = @"limitCellId";
    //从重用队列获取
    LimitCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (nil == cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"LimitCell" owner:nil options:nil] lastObject];
    }
    //模型对象
    LimitModel *model = _dataArray[indexPath.row];
    [cell configModel:model index:indexPath.row];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

#pragma mark - MJRefreshBaseView代理
-(void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    //如果正在刷新，不进行任何操作
    if (_isLoading) {
        return;
    }
    
    
    if (refreshView == _headerView) {
        //下拉刷新
        _curPage = 1;
        
        [self downloadData];
        
    }else if (refreshView == _footerView){
        //上拉加载更多
        _curPage++;
        
        [self downloadData];
    }
}



#pragma mark - UISearcherBar代理
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    searchBar.showsCancelButton = YES;
    UIView *firstSub = [searchBar.subviews firstObject];
    for(UIView *sub in firstSub.subviews)
    {
        Class cls = NSClassFromString(@"UINavigationButton");
        if ([sub isKindOfClass:cls]) {
            UIButton *btn = (UIButton *)sub;
            [btn setTitle:@"" forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage imageNamed:@"buttonbar_action"] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:14];
        }
    }
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    searchBar.showsCancelButton = NO;
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    
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

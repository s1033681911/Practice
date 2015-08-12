//
//  SearchViewController.m
//  Limit_1509
//
//  Created by qianfeng on 15/7/29.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController ()<MyDownloaderDelegate>

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


-(void)backAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)creatNav
{
    [self addNavBtn:CGRectMake(0, 0, 60, 36) title:@"return" target:self action:@selector(backAction:) isLeft:YES];
    [self addNavTitle:CGRectMake(60, 0, 255, 44) title:@"search"];
}


- (void)downloadData
{
    MyDownloader *downloader = [[MyDownloader alloc] init];
    downloader.delegate = self;
    
    NSString *urlString = [NSString stringWithFormat:kLimitSearchUrl,_curPage,self.keyword];
    [downloader downloadWithUrlString:urlString];
}

-(void)downloader:(MyDownloader *)downloader failWithError:(NSError *)error
{
    
}
-(void)downloaderFinish:(MyDownloader *)downloader
{
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

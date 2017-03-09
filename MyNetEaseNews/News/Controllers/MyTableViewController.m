//
//  MyTableViewController.m
//  MyNetEaseNews
//
//  Created by Bob on 17/2/5.
//  Copyright © 2017年 Bob. All rights reserved.
//

#import "MyTableViewController.h"
#import "NewsModel.h"
#import "NetworkTool.h"
#import "YYModel.h"
#import "MyWebViewController.h"
#import "NewsCell.h"
#import "MJRefresh.h"
//#import "UIImage+Common.h"
#define WS(weakSelf) __weak __typeof(&*self)weakSelf = self;
#define baseCellID @"baseCell"
#define bigCellID @"bigCell"
#define imagesCellID @"imagesCell"

@interface MyTableViewController ()

@property (nonatomic, retain) NSMutableArray<NewsModel *> *newsModelArray;
@end

@implementation MyTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableHeaderView = [UIView new];
    self.tableView.tableFooterView = [UIView new];
    _newsModelArray = [NSMutableArray new];
    [self addMJRefresh];
}

- (void)setTid:(NSString *)tid
{
    _tid = tid;
    if (self.newsModelArray.count != 0) {
        return;
    }
    WS(weakSelf)
    NSString *urlString = [NSString stringWithFormat:@"article/list/%@/0-20.html",weakSelf.tid];
    [[NetworkTool sharedTool] ys_Get:urlString success:^(NSURLSessionDataTask *task, NSDictionary* responseObject) {
        [weakSelf.newsModelArray removeAllObjects];
        [weakSelf.newsModelArray addObjectsFromArray:[NSArray yy_modelArrayWithClass:[NewsModel class] json:responseObject[responseObject.keyEnumerator.nextObject]]];
        [self.tableView reloadData];
    } faile:^(NSURLSessionDataTask *task, NSError *error) {
    }];
}

-(void)addMJRefresh{
    WS(weakSelf)
    
    __unsafe_unretained UITableView *tableView = self.tableView;
    // 下拉刷新
    tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        NSString *urlString = [NSString stringWithFormat:@"article/list/%@/0-20.html",weakSelf.tid];
        [[NetworkTool sharedTool] ys_Get:urlString success:^(NSURLSessionDataTask *task, NSDictionary* responseObject) {
            [weakSelf.newsModelArray removeAllObjects];
            [weakSelf.newsModelArray addObjectsFromArray:[NSArray yy_modelArrayWithClass:[NewsModel class] json:responseObject[responseObject.keyEnumerator.nextObject]]];
            NSLog(@"_newsModelArray====%@====",weakSelf.newsModelArray);
            [self.tableView reloadData];
            [tableView.mj_header endRefreshing];
        } faile:^(NSURLSessionDataTask *task, NSError *error) {
            [tableView.mj_header endRefreshing];
        }];
        
    }];
    
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    tableView.mj_header.automaticallyChangeAlpha = YES;
    // 上拉刷新
    tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{

        NSString *URLString = [NSString stringWithFormat:@"article/list/%@/%ld-20.html",weakSelf.tid,weakSelf.newsModelArray.count - weakSelf.newsModelArray.count%10];
        [[NetworkTool sharedTool] ys_Get:URLString success:^(NSURLSessionDataTask *task, NSDictionary* responseObject) {

//            [weakSelf.newsModelArray removeAllObjects];
            [weakSelf.newsModelArray addObjectsFromArray:[NSArray yy_modelArrayWithClass:[NewsModel class] json:responseObject[responseObject.keyEnumerator.nextObject]]];
            NSLog(@"_newsModelArray====%@====",weakSelf.newsModelArray);
            [self.tableView reloadData];

            // 结束刷新
            [tableView.mj_footer endRefreshing];
        } faile:^(NSURLSessionDataTask *task, NSError *error) {
            // 结束刷新
            [tableView.mj_footer endRefreshing];
        }];

    }];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _newsModelArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *cellID;
    NewsModel *model = _newsModelArray[indexPath.row];
    if(model.imgType)
        cellID = bigCellID;
    else if(model.imgextra)
        cellID = imagesCellID;
    else
        cellID = baseCellID;
    
    NewsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    
    cell.newsModel = model;
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewsModel *model = _newsModelArray[indexPath.row];
    if(model.imgType)
        return 180;
    else if(model.imgextra)
        return 130;
    else
        return 80;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NewsModel *model = _newsModelArray[indexPath.row];
    MyWebViewController *vc = [MyWebViewController new];
    vc.detailID = model.docid;
    vc.title = @"";
    [self.nav pushViewController:vc animated:YES];
}


@end

//
//  MyViewController.m
//  MyNetEaseNews
//
//  Created by Bob on 2017/3/3.
//  Copyright © 2017年 Bob. All rights reserved.
//

#import "MyViewController.h"
#import "XBMeHeaderView.h"
#import "XBConst.h"
#import "XBSettingCell.h"
#import "XBSettingItemModel.h"
#import "XBSettingSectionModel.h"
#import "DemoSettingController.h"
@interface MyViewController ()
@property (nonatomic,strong) XBMeHeaderView *header;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,strong) NSArray  *sectionArray; /**< section模型数组*/
@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = XBMakeColorWithRGB(234, 234, 234, 1);
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self setupSections];
    
    XBMeHeaderView *header = [[[NSBundle mainBundle]loadNibNamed:@"XBMeHeaderView" owner:nil options:nil] firstObject];
    header.frame = CGRectMake(0, 0, self.view.frame.size.width, 200);
    self.header.backgroundColor = [UIColor blueColor];
    self.header = header;
    self.tableView.tableHeaderView = header;
    self.tableView.tableFooterView = [UIView new];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    UILabel *titleLB = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    titleLB.text = @"我";
    titleLB.textAlignment = 1;
    titleLB.font = [UIFont systemFontOfSize:19];
    titleLB.textColor = [UIColor whiteColor];
    self.tabBarController.navigationItem.titleView = titleLB;
    self.tabBarController.title = @"我";
    
}

- (void)setupSections
{
    
    //************************************section1
    XBSettingItemModel *item1 = [[XBSettingItemModel alloc]init];
    item1.funcName = @"我的消息";
    item1.executeCode = ^{
        NSLog(@"我的消息");
    };
    item1.img = [UIImage imageNamed:@"user_set_icon_mail"];
    item1.detailText = @"1个未读消息";
    item1.accessoryType = XBSettingAccessoryTypeDisclosureIndicator;
    
    
    XBSettingItemModel *item2 = [[XBSettingItemModel alloc]init];
    item2.funcName = @"最新动态";
    item2.img = [UIImage imageNamed:@"user_set_icon_message"];
    item2.accessoryType = XBSettingAccessoryTypeDisclosureIndicator;
    
    XBSettingItemModel *item3 = [[XBSettingItemModel alloc]init];
    item3.funcName = @"金币商城";
    item3.img = [UIImage imageNamed:@"user_set_icon_mall"];
    item3.accessoryType = XBSettingAccessoryTypeDisclosureIndicator;
    
    XBSettingItemModel *item4 = [[XBSettingItemModel alloc]init];
    item4.funcName = @"我的钱包";
    item4.img = [UIImage imageNamed:@"user_set_icon_wallet"];
    item4.accessoryType = XBSettingAccessoryTypeDisclosureIndicator;
    
    XBSettingSectionModel *section1 = [[XBSettingSectionModel alloc]init];
    section1.sectionHeaderHeight = 18;
    section1.itemArray = @[item1,item2,item3,item4];
    
    XBSettingItemModel *item5 = [[XBSettingItemModel alloc]init];
    item5.funcName = @"金币任务";
    item5.img = [UIImage imageNamed:@"user_set_icon_mission"];
    item5.detailText = @"6个任务未完成";
    item5.executeCode = ^{
        NSLog(@"金币任务");
    };
    item5.accessoryType = XBSettingAccessoryTypeDisclosureIndicator;
    
    XBSettingItemModel *item6 = [[XBSettingItemModel alloc]init];
    item6.funcName = @"活动广场";
    item6.img = [UIImage imageNamed:@"user_set_icon_promo"];
    item6.executeCode = ^{
        
    };
    item6.accessoryType = XBSettingAccessoryTypeDisclosureIndicator;
    
    XBSettingItemModel *item7 = [[XBSettingItemModel alloc]init];
    item7.funcName = @"设置";
    item7.img = [UIImage imageNamed:@"user_set_icon_setting"];
    item7.executeCode = ^{
        
    };
    item7.accessoryType = XBSettingAccessoryTypeDisclosureIndicator;
    
    XBSettingSectionModel *section2 = [[XBSettingSectionModel alloc]init];
    section2.sectionHeaderHeight = 18;
    section2.itemArray = @[item5,item6,item7];
    
    self.sectionArray = @[section1,section2];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.sectionArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    XBSettingSectionModel *sectionModel = self.sectionArray[section];
    return sectionModel.itemArray.count;}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"setting";
    XBSettingSectionModel *sectionModel = self.sectionArray[indexPath.section];
    XBSettingItemModel *itemModel = sectionModel.itemArray[indexPath.row];
    
    XBSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[XBSettingCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.item = itemModel;
    return cell;
}

#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    XBSettingSectionModel *sectionModel = self.sectionArray[section];
    return sectionModel.sectionHeaderHeight;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    XBSettingSectionModel *sectionModel = self.sectionArray[indexPath.section];
    XBSettingItemModel *itemModel = sectionModel.itemArray[indexPath.row];
    if (itemModel.executeCode) {
        itemModel.executeCode();
    }
}
//uitableview处理section的不悬浮，禁止section停留的方法，主要是这段代码
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    XBSettingSectionModel *sectionModel = [self.sectionArray firstObject];
    CGFloat sectionHeaderHeight = sectionModel.sectionHeaderHeight;
    
    if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
    
    CGFloat offSetY = 0;
    if (scrollView == _tableView) {
        CGPoint offset = scrollView.contentOffset;
        //下拉放大实现
        if (offset.y < 0) {
            offSetY = offset.y;
        }
    }
    [self.header setOffSet:offSetY];

}
@end


//
//  ViewController.m
//  MyNetEaseNews
//
//  Created by Bob on 17/1/13.
//  Copyright © 2017年 Bob. All rights reserved.
//

#import "ViewController.h"
#import "JB_TopMenuScrollView.h"
#import "MyCollectionViewCell.h"
#import "UINavigationController+FDFullscreenPopGesture.h"

#define MAinWidth [UIScreen mainScreen].bounds.size.width
#define MAinHeight [UIScreen mainScreen].bounds.size.height

@interface ViewController ()<JB_TopMenuScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,retain) JB_TopMenuScrollView *myTopScroll;
@property (nonatomic, retain) UICollectionView *myCo;
@property (nonatomic, retain)  NSArray<ChannelModel*> *channelModelArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    self.channelModelArray = [ChannelModel channels];
    [self setUpUI];
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    UIImageView *titleView = [[UIImageView alloc]initWithFrame:CGRectMake((MAinWidth - 74)/2.0, 10, 74, 24)];
    UIImage *image = [UIImage imageNamed:@"home_header_logo"];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    titleView.image = image;
    titleView.contentMode = UIViewContentModeScaleAspectFit;
    titleView.tintColor = [UIColor whiteColor];
    self.tabBarController.navigationItem.titleView = titleView;
    self.tabBarController.title = @"";
}

- (void)setUpUI
{
    self.fd_prefersNavigationBarHidden = NO;
//    self.tabBarController.navigationController.navigationBar.barTintColor = [UIColor redColor];
//    self.tabBarController.navigationController.navigationBar.tintColor = [UIColor whiteColor];

    
    self.tabBarController.automaticallyAdjustsScrollViewInsets = NO;
    self.myTopScroll = [[JB_TopMenuScrollView alloc]initWithFrame:CGRectMake(0, 64, MAinWidth, 35)];
//    self.myTopScroll.backgroundColor = [UIColor brownColor];
    self.myTopScroll.channelModelArray = [ChannelModel channels];
    [self.view addSubview:self.myTopScroll];
    self.myTopScroll.delegate2 = self;
    
    UICollectionViewFlowLayout *fl = [[UICollectionViewFlowLayout alloc]init];
    fl.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    fl.itemSize = CGSizeMake(MAinWidth, MAinHeight - 99-49);
    fl.minimumLineSpacing = 0.1;
    
    _myCo = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 99, MAinWidth, MAinHeight - 99 - 49) collectionViewLayout:fl];
    _myCo.backgroundColor = [UIColor whiteColor];
    _myCo.delegate = self;
    _myCo.dataSource = self;
    _myCo.pagingEnabled = YES;
    
    for (int i = 0; i < self.channelModelArray.count; i ++) {
        NSString *identifier = [NSString stringWithFormat:@"cell%d",i];
         [_myCo registerClass:[MyCollectionViewCell class] forCellWithReuseIdentifier:identifier];
    }
    
   
    [self.view addSubview:_myCo];
}

#pragma mark- JB_TopMenuScrollViewDelegate
- (void)JB_TopMenuScrollView:(JB_TopMenuScrollView *)JB_ScrollView DidTapLabelIndex:(NSIndexPath *)indexPath
{
    [_myCo scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.myTopScroll.channelModelArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = [NSString stringWithFormat:@"cell%ld",indexPath.row];
    MyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.nav = self.navigationController;
    cell.channelModel = self.channelModelArray[indexPath.row];
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.myTopScroll J_ScrollView_MainScrollViewDidScroll:scrollView];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self.myTopScroll J_ScrollView_MainScrollViewEndScroll:scrollView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

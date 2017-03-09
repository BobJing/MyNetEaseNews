//
//  AnimationBar.m
//  MyNetEaseNews
//
//  Created by Bob on 2017/3/3.
//  Copyright © 2017年 Bob. All rights reserved.
//

#import "AnimationBar.h"
#import "UIImage+color.h"
@interface AnimationBar()
@property (nonatomic, retain) UIImageView *imagView;
@property (nonatomic, retain) UILabel *label;
@end
@implementation AnimationBar

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype )initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _imagView = [[UIImageView alloc]initWithFrame:CGRectMake(7, 8, 34, 30)];
        _imagView.contentMode = UIViewContentModeScaleAspectFit;
        _imagView.image = [[UIImage imageNamed:@"night_nav_live_room_image"] imageWithColor:[UIColor whiteColor]];
        
        NSArray *imageArr = @[
                              [[UIImage imageNamed:@"night_nav_live_room_rolling_first"] imageWithColor:[UIColor whiteColor]],
                              [[UIImage imageNamed:@"night_nav_live_room_rolling_second"] imageWithColor:[UIColor whiteColor]],
                              [[UIImage imageNamed:@"night_nav_live_room_rolling_third"] imageWithColor:[UIColor whiteColor]]
                              ];
        _imagView.animationImages = imageArr;
        _imagView.tintColor = [UIColor whiteColor];
        _imagView.animationRepeatCount = 10;
        _imagView.animationDuration = 1/50.0*3;

        
        [self addSubview:_imagView];
        
        
        _label = [[UILabel alloc]initWithFrame:CGRectMake(-3, 11, 15, 24)];
        _label.text = @"15";
        _label.textColor = [UIColor colorWithWhite:0.95 alpha:0.95];
        _label.font = [UIFont systemFontOfSize:12];
        _label.textAlignment = NSTextAlignmentRight;
        [self addSubview:_label];
        
//        [self animation];
        
        
    }
    return self;
}


- (void)animation
{
    [_imagView startAnimating];
    [UIView beginAnimations:@"label" context:nil];
    [UIView setAnimationRepeatCount:4];
    [UIView setAnimationDuration:0.04];
    [UIView setAnimationDelay:1/50.0*7];
    [UIView setAnimationRepeatAutoreverses:YES];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    _label.frame = CGRectMake(8, 11, 15, 23);
    [UIView commitAnimations];
    _label.frame = CGRectMake(-3, 11, 15, 23);
}

@end

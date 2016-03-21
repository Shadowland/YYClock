//
//  ViewController.m
//  05-时钟练习
//
//  Created by strongwallyi on 15/11/17.
//  Copyright © 2015年 strongwallyi. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic,weak)CALayer *second;
@property (nonatomic ,weak)CALayer *minute;
@property (nonatomic ,weak)CALayer *hour;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor cyanColor];
    //创建表盘
    CALayer *clock = [[CALayer alloc]init];
    //大小
    clock.bounds = CGRectMake(0, 0, 200, 200);
    //位置
    clock.position = CGPointMake(200, 200);
    //内容
    clock.contents = (__bridge id _Nullable)([UIImage imageNamed:@"clock"].CGImage);
    [self.view.layer addSublayer:clock];
    //圆角
    clock.cornerRadius = 100;
    //裁剪
    clock.masksToBounds = YES;
    
    //创建秒针
    CALayer *second = [[CALayer alloc]init];
    self.second = second;
    //大小
    second.bounds = CGRectMake(0, 0, 2, 100);
    //位置
    second.position = clock.position;
    //颜色
    second.backgroundColor = [UIColor redColor].CGColor;
    //锚点
    second.anchorPoint = CGPointMake(0.5, 0.8);
    [self.view.layer addSublayer:second];
    
    //创建分针
    CALayer *minute = [[CALayer alloc]init];
    self.minute = minute;
    //大小
    minute.bounds = CGRectMake(0, 0, 3, 80);
    //位置
    minute.position = clock.position;
    //颜色
    minute.backgroundColor = [UIColor blueColor].CGColor;
    //锚点
    minute.anchorPoint = CGPointMake(0.5, 0.8);
    [self.view.layer addSublayer:minute];
    
    //创建时针
    CALayer *hour = [[CALayer alloc]init];
    self.hour = hour;
    //大小
    hour.bounds = CGRectMake(0, 0, 4, 60);
    //位置
    hour.position = clock.position;
    //颜色
    hour.backgroundColor = [UIColor purpleColor].CGColor;
    //锚点
    hour.anchorPoint = CGPointMake(0.5, 0.8);
    [self.view.layer addSublayer:hour];
    
    CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(timeChange)];
    [link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
 
    [self timeChange];
}

-(void)timeChange{
    NSDate *date = [NSDate date];
//
//    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
//    formatter.dateFormat = @"ss";
//    NSString *ms = [formatter stringFromDate:date];
//    CGFloat msValue = [ms floatValue];


    NSCalendar *cal = [NSCalendar currentCalendar];
    CGFloat ms = [cal component:NSCalendarUnitNanosecond fromDate:date];
    CGFloat s= [cal component:NSCalendarUnitSecond fromDate:date];
    CGFloat m = [cal component:NSCalendarUnitMinute fromDate:date];
    CGFloat h = [cal component:NSCalendarUnitHour fromDate:date];
    
    //秒针角度
    CGFloat angle = (2 * M_PI/60) / 1000000000;
    CGFloat angle1 = 2 * M_PI / 60;
    self.second.affineTransform = CGAffineTransformMakeRotation(angle1 * s + angle * ms);
    //分针角度
    CGFloat minuteAngle = 2 * M_PI / 60;
    self.minute.affineTransform = CGAffineTransformMakeRotation(minuteAngle * m + angle1 * s / 60 + angle * ms / 60);
    //时针角度
    CGFloat hourAngle = 2 * M_PI / 12;
    self.hour.affineTransform = CGAffineTransformMakeRotation(hourAngle * h + minuteAngle * m / 12 + angle1 * s / 60 + angle * ms / 60);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

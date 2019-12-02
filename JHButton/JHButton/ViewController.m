//
//  ViewController.m
//  JHButton
//
//  Created by iOS on 2018/3/3.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import "ViewController.h"
#import <Masonry/Masonry.h>
#import "JHButton.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view, typically from a nib.
    
    JHButton *btn1 = [[JHButton alloc] initWithType:JHImageButtonTypeTop AndMarginArr:@[@5]];
    btn1.backgroundColor = ColorOfRandom;
    btn1.image = [UIImage imageNamed:@"image1"];
    btn1.text = @"按钮1按钮1按钮1按钮1按钮1按钮1按钮1按钮1按钮1";
    btn1.contentLabel.textColor = [UIColor redColor];
    btn1.contentLabel.font = [UIFont systemFontOfSize:13];
    btn1.contentLabel.textAlignment =NSTextAlignmentLeft;
    [self.view addSubview:btn1];
    [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(self.view).offset(20);
    }];

    JHButton *btn2 = [[JHButton alloc] initWithType:JHImageButtonTypeLeft AndMarginArr:@[@5]];
    btn2.backgroundColor = ColorOfRandom;
    btn2.image = [UIImage imageNamed:@"image3"];
    btn2.text = @"按钮2";
    btn2.contentLabel.textColor = [UIColor redColor];
    btn2.contentLabel.font = [UIFont systemFontOfSize:13];
    btn2.contentLabel.textAlignment =NSTextAlignmentLeft;
    [self.view addSubview:btn2];
    [btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(btn1.mas_bottom).offset(20);
        make.left.mas_equalTo(btn1.mas_left).offset(10);
    }];
    
    JHButton *btn3 = [[JHButton alloc] initWithType:JHImageButtonTypeLeft AndMarginArr:@[@0]];
    btn3.backgroundColor = ColorOfRandom;
    btn3.text = @"按钮3";
    btn3.contentLabel.textColor = [UIColor redColor];
    btn3.contentLabel.font = [UIFont systemFontOfSize:13];
    btn3.contentLabel.textAlignment =NSTextAlignmentLeft;
    [self.view addSubview:btn3];
    [btn3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(btn1.mas_bottom).offset(20);
        make.left.mas_equalTo(btn2.mas_right).offset(20);
    }];
    
    JHButton *btn4 = [[JHButton alloc] initWithType:JHImageButtonTypeLeft AndMarginArr:@[@0]];
    btn4.backgroundColor = ColorOfRandom;
    btn4.image = [UIImage imageNamed:@"image3"];
    btn4.contentLabel.textColor = [UIColor redColor];
    btn4.contentLabel.font = [UIFont systemFontOfSize:13];
    btn4.contentLabel.textAlignment =NSTextAlignmentLeft;
    [self.view addSubview:btn4];
    [btn4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(btn1.mas_bottom).offset(20);
        make.left.mas_equalTo(btn3.mas_right).offset(20);
    }];
    
    JHButton *btn5 = [[JHButton alloc] initWithType:JHImageButtonTypeLeft AndMarginArr:@[@0]];
    [btn5 setNormolImage:[UIImage imageNamed:@"image1"] AndHighLightImage:[UIImage imageNamed:@"image3"]];
    [btn5 setNormolTextColor:[UIColor redColor] AndHighLightTextColor:[UIColor greenColor]];
    [btn5 setNormolLayerColor:[UIColor purpleColor] AndhighLightLayerColor:[UIColor blueColor]];
    btn5.text = @"123123";
    btn5.contentLabel.textColor = [UIColor redColor];
    btn5.contentLabel.font = [UIFont systemFontOfSize:13];
    btn5.contentLabel.textAlignment =NSTextAlignmentLeft;
    btn5.layer.borderWidth = 2;
    [self.view addSubview:btn5];
    [btn5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(btn2.mas_bottom).offset(10);
        make.left.mas_equalTo(self.view.mas_left).offset(10);
    }];
    
    JHButton *btn6 = [[JHButton alloc] initWithType:JHImageButtonTypeLeft AndMarginArr:@[@10]];
    btn6.backgroundColor = ColorOfRandom;
    btn6.image = [UIImage imageNamed:@"image3"];
    btn6.text = @"123123";
    btn6.contentLabel.textColor = [UIColor redColor];
    btn6.contentLabel.font = [UIFont systemFontOfSize:13];
    btn6.contentLabel.textAlignment =NSTextAlignmentLeft;
    [self.view addSubview:btn6];
    [btn6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(btn5.mas_bottom).offset(10);
        make.left.mas_equalTo(self.view.mas_left).offset(10);
        make.width.height.mas_equalTo(100);
    }];
    //这样可以移动文字或者图片位置
//    [btn6.imageView updateConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(0);
//        make.width.priorityHigh();
//    }];
    [btn6 handleControlEvent:UIControlEventTouchUpInside withBlock:^(id sender) {
        JHButton *btn = sender;
        NSLog(@"%@",btn.text);
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

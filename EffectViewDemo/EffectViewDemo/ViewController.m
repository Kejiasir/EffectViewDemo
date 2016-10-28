//
//  ViewController.m
//  EffectViewDemo
//
//  Created by Arvin on 16/1/14.
//  Copyright © 2016年 Arvin. All rights reserved.
//

#import "ViewController.h"
#import "UIView+Extension.h"
#import "UIImageView+LBBlurredImage.h"

#define FONT_SIZE 18
#define kWIDTH [UIScreen mainScreen].bounds.size.width
#define RGB(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

@interface ViewController ()

@end

@implementation ViewController


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    UIImageView *bgImgView = [[UIImageView alloc] init];
    [bgImgView setFrame:self.view.bounds];
    [bgImgView setUserInteractionEnabled:YES];
    [bgImgView setContentMode:UIViewContentModeScaleAspectFill];
    
    //------- 使用第三方工具类的方法请把这里的代码注释掉 -------//
    
    [bgImgView setImage:[UIImage imageNamed:@"huoying4.jpg"]];
    [self.view addSubview:bgImgView];

    // iOS7 UIToolbar
    [self toolbar:bgImgView];

    // iOS8 UIBlurEffect
    [self blurEffect:bgImgView];
    
    //-------------------------------------------------//
    
    // 使用第三方工具类
    //[self blurredImage:bgImgView];
    
    // 头像
    UIImageView *headImgView = [[UIImageView alloc] init];
    [bgImgView addSubview:({
        [headImgView setUserInteractionEnabled:YES];
        [headImgView setFrame:(CGRect){bgImgView.centerX-53, 80, 106, 106}];
        [headImgView setImage:[UIImage imageNamed:@"huba.jpeg"]];
        [headImgView setContentMode:UIViewContentModeScaleAspectFill];
        [headImgView.layer setCornerRadius:CGRectGetHeight(headImgView.frame)*0.5];
        [headImgView.layer setMasksToBounds:YES];
        [headImgView.layer setBorderWidth:6.f];
        [headImgView.layer setBorderColor:RGB(170, 170, 170, 0.5).CGColor];
        [headImgView addGestureRecognizer:[[UITapGestureRecognizer alloc]
                                           initWithTarget:self action:@selector(headImgViewClick:)]];
        headImgView;
    })];
    
    // 签名
    [bgImgView addSubview:({
        UILabel *lable = [[UILabel alloc] init];
        [lable setText:@"我是测试签名"];
        [lable setTextColor:[UIColor greenColor]];
        [lable setTextAlignment:NSTextAlignmentCenter];
        [lable setFont:[UIFont systemFontOfSize:FONT_SIZE]];
        [lable setBackgroundColor:[UIColor orangeColor]];
        CGSize lableSize = [lable.text boundingRectWithSize:CGSizeMake(MAXFLOAT,MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:FONT_SIZE]} context:nil].size;
        [lable setFrame:CGRectMake((kWIDTH*0.5)-(lableSize.width*0.5),CGRectGetMaxY(headImgView.frame)+15, lableSize.width, lableSize.height)];
        [lable sizeToFit];
        lable;
    })];
}

- (void)toolbar:(UIImageView *)bgImgView {
    /**
     iOS7.0
     毛玻璃的样式(枚举)
     UIBarStyleDefault          = 0,
     UIBarStyleBlack            = 1,
     UIBarStyleBlackOpaque      = 1, // Deprecated. Use UIBarStyleBlack
     UIBarStyleBlackTranslucent = 2, // Deprecated. Use UIBarStyleBlack and set the translucent property to YES
     */
    UIToolbar *toolbar = [[UIToolbar alloc] init];
    toolbar.frame = (CGRect){0, 0, bgImgView.w * 0.5, bgImgView.h};
    toolbar.barStyle = UIBarStyleBlackTranslucent;
    [bgImgView addSubview:toolbar];
    
    CGRect frame = CGRectMake(0, bgImgView.h-80, kWIDTH * 0.5, 30);
    [bgImgView addSubview:[self labelWithFrame:frame text:@"iOS7-UIToolbar"]];
}


- (void)blurEffect:(UIImageView *)bgImgView {
    /**
     iOS8.0
     毛玻璃的样式(枚举)
     UIBlurEffectStyleExtraLight,
     UIBlurEffectStyleLight,
     UIBlurEffectStyleDark,
     
     // iOS 10新增的枚举值
     UIBlurEffectStyleRegular NS_ENUM_AVAILABLE_IOS(10_0), // Adapts to user interface style
     UIBlurEffectStyleProminent NS_ENUM_AVAILABLE_IOS(10_0), // Adapts to user interface style
     */
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    effectView.frame = CGRectMake(bgImgView.w * 0.5, 0, bgImgView.w * 0.5, bgImgView.h);
    [bgImgView addSubview:effectView];
    
    CGRect frame = CGRectMake(kWIDTH * 0.5, bgImgView.h-80, kWIDTH * 0.5, 30);
    [bgImgView addSubview:[self labelWithFrame:frame text:@"iOS8-UIBlurEffect"]];
    
    // 加上以下代码可以使毛玻璃特效更明亮点
    UIVibrancyEffect *vibrancyView = [UIVibrancyEffect effectForBlurEffect:effect];
    UIVisualEffectView *visualEffectView = [[UIVisualEffectView alloc] initWithEffect:vibrancyView];
    visualEffectView.translatesAutoresizingMaskIntoConstraints = NO;
    [effectView.contentView addSubview:visualEffectView];
}


- (void)blurredImage:(UIImageView *)bgImgView {
    // 方法1,没有blurRadius参数,因为默认是20
    //[bgImgView setImageToBlur:[UIImage imageNamed:@"huoying4.jpg"] completionBlock:nil];
    
    // 方法2,对背景图片进行毛玻璃效果处理,参数blurRadius默认是20,可指定,最后一个参数block回调可为nil
    [bgImgView setImageToBlur:[UIImage imageNamed:@"huoying4.jpg"] blurRadius:35 completionBlock:nil];
    [self.view addSubview:bgImgView];
    
    CGRect frame = CGRectMake(0, bgImgView.h-80, kWIDTH, 30);
    [bgImgView addSubview:[self labelWithFrame:frame text:@"LBBlurredImage"]];
}


- (UILabel *)labelWithFrame:(CGRect)frame text:(NSString *)text {
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.text = text;
    label.textColor = [UIColor redColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:FONT_SIZE];
    return label;
}


- (void)headImgViewClick:(UITapGestureRecognizer *)gesture {
    NSLog(@"%@->你点我干啥?",gesture);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

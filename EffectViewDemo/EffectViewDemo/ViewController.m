//
//  ViewController.m
//  EffectViewDemo
//
//  Created by Arvin on 16/1/14.
//  Copyright © 2016年 Arvin. All rights reserved.
//

#import "ViewController.h"
#import "UIImageView+LBBlurredImage.h"

#define kWIDTH [UIScreen mainScreen].bounds.size.width
#define BG_IMAGE_WIDTH 110
#define BG_IMAGE_HEIGHT 110
#define HEAD_IMAGE_WIDTH 100
#define HEAD_IMAGE_HEIGHT 100
#define BG_VIEW_Y 60
#define FONT_SIZE 18

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*
     iOS7.0
     毛玻璃的样式(枚举)
     UIBarStyleDefault          = 0,
     UIBarStyleBlack            = 1,
     UIBarStyleBlackOpaque      = 1, // Deprecated. Use UIBarStyleBlack
     UIBarStyleBlackTranslucent = 2, // Deprecated. Use UIBarStyleBlack and set the translucent property to YES
     
     UIImageView *bgImgView = [[UIImageView alloc] initWithFrame:self.view.bounds];
     bgImgView.image = [UIImage imageNamed:@"huoying4.jpg"];
     [self.view addSubview:bgImgView];
     
     UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, bgImgView.frame.size.width*0.5, bgImgView.frame.size.height)];
     toolbar.barStyle = UIBarStyleBlackTranslucent;
     [bgImgView addSubview:toolbar];
     */
    
    UIImageView *bgImgView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    //bgImgView.image = [UIImage imageNamed:@"huoying4.jpg"];
    bgImgView.contentMode = UIViewContentModeScaleAspectFill;
    // 方法1,没有blurRadius参数,因为默认是20
    //[bgImgView setImageToBlur:[UIImage imageNamed:@"huoying4.jpg"] completionBlock:nil];
    // 方法2,对背景图片进行毛玻璃效果处理,参数blurRadius默认是20,可指定,最后一个参数block回调可为nil
    [bgImgView setImageToBlur:[UIImage imageNamed:@"huoying4.jpg"] blurRadius:30 completionBlock:nil];
    bgImgView.userInteractionEnabled = YES;
    [self.view addSubview:bgImgView];
    
    /*
     iOS8.0
     毛玻璃的样式(枚举)
     UIBlurEffectStyleExtraLight,
     UIBlurEffectStyleLight,
     UIBlurEffectStyleDark
     
     UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
     UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
     effectView.frame = CGRectMake(0, 0, bgImgView.frame.size.width*0.5, bgImgView.frame.size.height);
     [bgImgView addSubview:effectView];
     */
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake((kWIDTH*0.5)-(BG_IMAGE_WIDTH*0.5), BG_VIEW_Y, BG_IMAGE_WIDTH, BG_IMAGE_HEIGHT)];
    bgView.alpha = 0.5;
    bgView.layer.cornerRadius = BG_IMAGE_WIDTH*0.5;
    bgView.layer.masksToBounds = YES;
    bgView.backgroundColor = [UIColor grayColor];
    [bgImgView addSubview:bgView];
    
    UIImageView *headImgView = [[UIImageView alloc] initWithFrame:CGRectMake((kWIDTH*0.5)-(HEAD_IMAGE_WIDTH*0.5), CGRectGetMaxY(bgView.frame)-(HEAD_IMAGE_HEIGHT+5), HEAD_IMAGE_WIDTH, HEAD_IMAGE_HEIGHT)];
    headImgView.image = [UIImage imageNamed:@"huba.jpeg"];
    headImgView.layer.cornerRadius = HEAD_IMAGE_WIDTH*0.5;
    headImgView.layer.masksToBounds = YES;
    headImgView.userInteractionEnabled = YES;
    headImgView.contentMode = UIViewContentModeScaleAspectFill;
    [bgImgView addSubview:headImgView];
    
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headImgViewClick:)];
    gesture.numberOfTapsRequired = 1;
    gesture.numberOfTouchesRequired = 1;
    [headImgView addGestureRecognizer:gesture];
    
    UILabel *lable = [[UILabel alloc] init];
    lable.text = @"我是测试签名";
    lable.textColor = [UIColor greenColor];
    lable.textAlignment = NSTextAlignmentCenter;
    lable.font = [UIFont systemFontOfSize:FONT_SIZE];
    lable.backgroundColor = [UIColor orangeColor];
    CGSize lableSize = [lable.text boundingRectWithSize:CGSizeMake(MAXFLOAT,MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:FONT_SIZE]} context:nil].size;
    lable.frame = CGRectMake((kWIDTH*0.5)-(lableSize.width*0.5),CGRectGetMaxY(bgView.frame)+15, lableSize.width, lableSize.height);
    [lable sizeToFit];
    [bgImgView addSubview:lable];
    
}

- (void)headImgViewClick:(UITapGestureRecognizer *)gesture {
    NSLog(@"%@->你点我干啥?",gesture);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

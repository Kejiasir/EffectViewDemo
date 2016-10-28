//
//  UIView+Extension.m
//  EffectViewDemo
//
//  Created by Arvin on 16/10/28.
//  Copyright © 2016年 Arvin. All rights reserved.
//

#import "UIView+Extension.h"

@implementation UIView (Extension)

- (void)setW:(CGFloat)w {
    CGRect frm = self.frame;
    frm.size.width = w;
    self.frame = frm;
}
- (CGFloat)w {
    return self.size.width;
}

- (void)setH:(CGFloat)h {
    CGRect frm = self.frame;
    frm.size.height = h;
    self.frame = frm;
}
- (CGFloat)h {
    return self.size.height;
}

- (void)setX:(CGFloat)x {
    CGRect org = self.frame;
    org.origin.x = x;
    self.frame = org;
}
- (CGFloat)x {
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y {
    CGRect org = self.frame;
    org.origin.y = y;
    self.frame  = org;
}
- (CGFloat)y {
    return self.frame.origin.y;
}

- (void)setSize:(CGSize)size {
    self.bounds = CGRectMake(0, 0, size.width, size.height);
}
- (CGSize)size {
    return self.bounds.size;
}

- (void)setCenterX:(CGFloat)centerX {
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}
- (CGFloat)centerX {
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY {
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}
- (CGFloat)centerY {
    return self.center.y;
}

@end

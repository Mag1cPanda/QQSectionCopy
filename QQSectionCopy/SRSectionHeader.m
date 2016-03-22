//
//  SRSectionHeader.m
//  QQSectionCopy
//
//  Created by Siren on 16/1/30.
//  Copyright © 2016年 Siren. All rights reserved.
//

#import "SRSectionHeader.h"
#define kScreenW [UIScreen mainScreen].bounds.size.width

@implementation SRSectionHeader

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
  
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.frame = CGRectMake(0, 0, kScreenW, kHeaderHeight);
        
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn.frame = self.bounds;
        //设置按钮图片
        [_btn setImage:[UIImage imageNamed:@"buddy_header_arrow"] forState:0];
        
        
//        UIViewContentModeScaleToFill,
//        UIViewContentModeScaleAspectFit,      // contents scaled to fit with fixed aspect. remainder is transparent
//        UIViewContentModeScaleAspectFill,     // contents scaled to fill with fixed aspect. some portion of content may be clipped.
//        UIViewContentModeRedraw,              // redraw on bounds change (calls -setNeedsDisplay)
//        UIViewContentModeCenter,
        
//        _btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _btn.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        _btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        //设置按钮内容的显示位置
        [_btn setContentHorizontalAlignment:1];
//        UIControlContentHorizontalAlignmentCenter = 0,
//        UIControlContentHorizontalAlignmentLeft   = 1,
//        UIControlContentHorizontalAlignmentRight  = 2,
//        UIControlContentHorizontalAlignmentFill   = 3,
        
        [_btn addTarget:self action:@selector(clickButton) forControlEvents:1 <<  6];
//        UIControlEventValueChanged = 1 << 12
    
        [self.contentView addSubview:_btn];
    }
    return self;
}

- (void)clickButton{
    
    //执行代理方法
    if ([_delegate respondsToSelector:@selector(sr_SectionHeaderDidSelectedHeader:)]) {
    
        [_delegate sr_SectionHeaderDidSelectedHeader:self];
        
    }

}

#pragma mark - isOpen的setter方法
- (void)setIsOpen:(BOOL)isOpen{
    _isOpen = isOpen;
    CGFloat angle = isOpen ? M_PI_2 : 0;
    
    [UIView animateWithDuration:0.5f animations:^{
       
        [_btn.imageView setTransform:CGAffineTransformMakeRotation(angle)];
        
    }];

}

@end

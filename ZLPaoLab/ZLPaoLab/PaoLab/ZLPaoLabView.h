//
//  ZLPaoLabView.h
//  ZLPaoLab
//
//  Created by ZhenwenLi on 2018/5/18.
//  Copyright © 2018年 lizhenwen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UILabel+YBAttributeTextTapAction.h"

@interface ZLPaoLabView : UIView
{
    UILabel *pao1;
    UILabel *pao2;
    
    //是否能够进行跑马动画
    BOOL    isMonkey;
    //是否正在跑马动画
    BOOL    isMonkeying;
}
-(void)prepare;
//文字颜色
@property(nonatomic,strong)UIColor *textColor;
//文字大小
@property(nonatomic,strong)UIFont *font;
//需要跑马的文字
@property(nonatomic,strong)NSString *text;
//富文本显示
@property(nonatomic,strong)NSMutableAttributedString *attributStr;

//开始动画
-(void)beganAnimation;
//停止动画
-(void)stopAnimation;
//移除动画
-(void)remAnimation;

- (void)zl_addAttributeTapActionWithStrings:(NSArray <NSString *> *)strings
                                 tapClicked:(void (^) (NSString *string , NSRange range , NSInteger index))tapClick;

@end

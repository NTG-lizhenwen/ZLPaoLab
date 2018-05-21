//
//  ZLPaoLabView.m
//  ZLPaoLab
//
//  Created by ZhenwenLi on 2018/5/18.
//  Copyright © 2018年 lizhenwen. All rights reserved.
//

#import "ZLPaoLabView.h"


@implementation ZLPaoLabView
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.layer setMasksToBounds:YES];
        self.font=[UIFont systemFontOfSize:15];
        self.textColor=[UIColor blackColor];
        self.text=@"";
        self.attributStr=nil;
    }
    return self;
}
//准备数据：
-(void)prepare
{
    if (!self.font) {
        self.font=[UIFont systemFontOfSize:15];
    }
    if (!self.text) {
        self.text=@"";
    }
    if (!self.textColor) {
        self.textColor=[UIColor blackColor];
    }
    if (!self.attributStr) {
        self.attributStr=nil;
    }
    
    pao1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, self.frame.size.height)];
    pao1.font=self.font;
    pao1.textColor=self.textColor;
    pao1.backgroundColor=[UIColor clearColor];
    [self addSubview:pao1];
    NSLog(@">>>>>>>>>%@",self.font);
    if (self.attributStr) {
        NSString *string=self.attributStr.string;
        CGFloat ww=[self labelText:string font:self.font labelH:self.frame.size.height];
        pao1.frame=CGRectMake(0, 0, ww, self.frame.size.height);
        pao1.attributedText=self.attributStr;
        
        isMonkey=NO;
        if (ww>self.frame.size.width) {//如果一行显示不下则贴pao2
            isMonkey=YES;
            
            pao2 = [[UILabel alloc]initWithFrame:CGRectMake(pao1.frame.size.width, 0, ww, self.frame.size.height)];
            pao2.font=self.font;
            pao2.textColor=self.textColor;
            pao2.attributedText=self.attributStr;
            pao2.backgroundColor=[UIColor clearColor];
            [self addSubview:pao2];
            
            [self toAnimation];//执行动画
        }

    }else{
        NSString *string=self.text;
        CGFloat ww=[self labelText:string font:self.font labelH:self.frame.size.height];
        pao1.frame=CGRectMake(0, 0, ww, self.frame.size.height);
        pao1.text=self.text;
        pao1.backgroundColor=[UIColor clearColor];
        isMonkey=NO;
        if (ww>self.frame.size.width) {//如果一行显示不下则贴pao2
            isMonkey=YES;
            
            pao2 = [[UILabel alloc]initWithFrame:CGRectMake(pao1.frame.size.width, 0, ww, self.frame.size.height)];
            pao2.font=self.font;
            pao2.textColor=self.textColor;
            pao2.text=self.text;
            pao2.backgroundColor=[UIColor clearColor];
            [self addSubview:pao2];
            
            [self toAnimation];//执行动画
        }
        
    }
    
    
    
}

//开始动画
-(void)beganAnimation
{
    //如果动画正在进行，且不能进行动画
    if (isMonkeying||isMonkey) {
        return;
    }
    isMonkeying=YES;
    [self resumeLayer:pao1.layer];
    [self resumeLayer:pao2.layer];
}
//停止动画
-(void)stopAnimation
{   //如果动画已经停止或者不能进行动画
    if (!isMonkeying||isMonkey) {
        return;
    }
    isMonkeying=NO;
    [self pauseLayer:pao1.layer];
    [self pauseLayer:pao2.layer];
}

- (void)toAnimation
{
    [UIView animateWithDuration:pao1.frame.size.width/20.0 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        //让两个label向左平移
        self->pao1.transform = CGAffineTransformMakeTranslation(-self->pao1.frame.size.width, 0);
        self->pao2.transform = CGAffineTransformMakeTranslation(-self->pao2.frame.size.width, 0);
    } completion:^(BOOL finished) {
        self->pao1.transform = CGAffineTransformIdentity;
        self->pao1.frame = CGRectMake(0, self->pao1.frame.origin.y, self->pao1.frame.size.width, self->pao1.frame.size.height);
        self->pao2.transform = CGAffineTransformIdentity;
        self->pao2.frame = CGRectMake(self->pao1.frame.size.width, self->pao2.frame.origin.y, self->pao2.frame.size.width, self->pao2.frame.size.height);

        //递归调用
        [self toAnimation];
    }];
}

//暂停动画
- (void)pauseLayer:(CALayer*)layer
{
    CFTimeInterval pausedTime = [layer convertTime:CACurrentMediaTime() fromLayer:nil];
    layer.speed = 0;
    layer.timeOffset = pausedTime;
}

//恢复动画
- (void)resumeLayer:(CALayer*)layer
{
    CFTimeInterval pauseTime = [layer timeOffset];
    layer.speed = 1.0;
    layer.timeOffset = 0.0;
    layer.beginTime = 0.0;
    
    CFTimeInterval timeSincePause = [layer convertTime:CACurrentMediaTime() fromLayer:nil]-pauseTime;
    layer.beginTime = timeSincePause;
}


- (void)zl_addAttributeTapActionWithStrings:(NSArray <NSString *> *)strings
                                 tapClicked:(void (^) (NSString *string , NSRange range , NSInteger index))tapClick
{
    [pao1 yb_addAttributeTapActionWithStrings:strings tapClicked:tapClick];
    if (pao2) {
        [pao2 yb_addAttributeTapActionWithStrings:strings tapClicked:tapClick];
    }
}
-(CGFloat)labelText:(NSString *)text font:(UIFont *)font labelH:(CGFloat)labelH
{
    CGSize titleSize = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, labelH) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
    return titleSize.width;
}
@end

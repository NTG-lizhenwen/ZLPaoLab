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

-(void)setText:(NSString *)text
{
    _text = text;
    
    if (pao1) {//如果lab已经存在
        if (!self.attributStr) {
            
            NSString *string=text;
            CGFloat ww=[self labelText:string font:self.font labelH:self.frame.size.height];
            //先停止动画
            [self remAnimation];
            pao1.frame=CGRectMake(0, 0, ww, self.frame.size.height);
            pao1.text=text;
            
            
            isMonkey=NO;
            if (ww>self.frame.size.width) {//如果一行显示不下则贴pao2
                isMonkey=YES;
                
                if (pao2) {//如果有则直接改值
                    pao2.frame=CGRectMake(pao1.frame.size.width, 0, ww, self.frame.size.height);
                    pao2.text=text;
                    
                }else{//如果没有创建
                    pao2 = [[UILabel alloc]initWithFrame:CGRectMake(pao1.frame.size.width, 0, ww, self.frame.size.height)];
                    pao2.font=self.font;
                    pao2.textColor=self.textColor;
                    pao2.text=text;
                    pao2.backgroundColor=[UIColor clearColor];
                    [self addSubview:pao2];
                    
//                    NSLog(@"=================123");
                    
                    //开始动画
                    [self toAnimation];//执行动画
                }
                
            }else{//如果宽度够！
                if (pao2) {
                    [pao2 removeFromSuperview];
                    pao2=nil;
                }
            }
        }
    }
}
-(void)setTextColor:(UIColor *)textColor
{
    _textColor = textColor;
    if (pao1) {//如果lab已经存在
        pao1.textColor=textColor;
        if (pao2) {
            pao2.textColor=textColor;
        }
    }
}
-(void)setAttributStr:(NSMutableAttributedString *)attributStr
{
    _attributStr=attributStr;
    if (pao1) {//如果lab已经存在
        
        NSString *string=self.attributStr.string;
        CGFloat ww=[self labelText:string font:self.font labelH:self.frame.size.height];
        pao1.frame=CGRectMake(0, 0, ww, self.frame.size.height);
        pao1.attributedText=attributStr;
        
        isMonkey=NO;
        if (ww>self.frame.size.width) {//如果一行显示不下则贴pao2
            isMonkey=YES;
            
            if (pao2) {
                pao2.attributedText=attributStr;
                pao2.frame=CGRectMake(pao1.frame.size.width, 0, ww, self.frame.size.height);
            }else{
                pao2 = [[UILabel alloc]initWithFrame:CGRectMake(pao1.frame.size.width, 0, ww, self.frame.size.height)];
                pao2.font=self.font;
                pao2.textColor=self.textColor;
                pao2.attributedText=attributStr;
                pao2.backgroundColor=[UIColor clearColor];
                [self addSubview:pao2];
                
                //开始动画
                [self toAnimation];//执行动画
            }
        }else{
            if (pao2) {
                [pao2 removeFromSuperview];
                pao2=nil;
            }
        }
    }
}
-(void)setFont:(UIFont *)font
{
    _font=font;
    if (pao1) {//如果lab已经存在
        
        if (!self.attributStr) {
            
            NSString *string=self.text;
            CGFloat ww=[self labelText:string font:font labelH:self.frame.size.height];
            //先停止动画
            [self remAnimation];
            pao1.font=font;
            pao1.frame=CGRectMake(0, 0, ww, self.frame.size.height);
            
            
            isMonkey=NO;
            if (ww>self.frame.size.width) {//如果一行显示不下则贴pao2
                isMonkey=YES;
                
                if (pao2) {//如果有则直接改值
                    pao2.font=font;
                    pao2.frame=CGRectMake(pao1.frame.size.width, 0, ww, self.frame.size.height);
               
                }else{//如果没有创建
                    pao2 = [[UILabel alloc]initWithFrame:CGRectMake(pao1.frame.size.width, 0, ww, self.frame.size.height)];
                    pao2.font=font;
                    pao2.textColor=self.textColor;
                    pao2.text=self.text;
                    pao2.backgroundColor=[UIColor clearColor];
                    [self addSubview:pao2];
      
                    //开始动画
                    [self toAnimation];//执行动画
                }
            }else{//如果宽度够！
                if (pao2) {
                    [pao2 removeFromSuperview];
                    pao2=nil;
                }
            }
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
-(void)remAnimation
{
    [self stopLayer:pao1.layer];
    [self stopLayer:pao2.layer];
}

- (void)toAnimation
{
    [UIView animateWithDuration:pao1.frame.size.width/40.0 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        //让两个label向左平移
        self->pao1.transform = CGAffineTransformMakeTranslation(-self->pao1.frame.size.width, 0);
        self->pao2.transform = CGAffineTransformMakeTranslation(-self->pao2.frame.size.width, 0);
    } completion:^(BOOL finished) {
        self->pao1.transform = CGAffineTransformIdentity;
        self->pao1.frame = CGRectMake(0, self->pao1.frame.origin.y, self->pao1.frame.size.width, self->pao1.frame.size.height);
        self->pao2.transform = CGAffineTransformIdentity;
        self->pao2.frame = CGRectMake(self->pao1.frame.size.width, self->pao2.frame.origin.y, self->pao2.frame.size.width, self->pao2.frame.size.height);
        
        //如果是可以动画的
        if (isMonkey) {
            //递归调用
            [self toAnimation];
        }
    }];
}

//暂停动画
- (void)pauseLayer:(CALayer*)layer
{
    CFTimeInterval pausedTime = [layer convertTime:CACurrentMediaTime() fromLayer:nil];
    layer.speed = 0;
    layer.timeOffset = pausedTime;
}
//停止动画
- (void)stopLayer:(CALayer*)layer
{
    [layer removeAllAnimations];
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

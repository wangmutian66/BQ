//
//  WmtBiaoqingboardView.m
//  BQ
//
//  Created by wangmutian on 2018/1/30.
//  Copyright © 2018年 wangmutian. All rights reserved.
//

#import "WmtBiaoqingboardView.h"

@interface WmtBiaoqingboardView()
/** 添加btn**/
@property(nonatomic,strong) NSMutableArray *btns;
/**数组的标题**/
@property(nonatomic,strong) NSArray *btnsTitle;
@end

@implementation WmtBiaoqingboardView

-(NSArray *)btnsTitle{
    if(!_btnsTitle){
       
        _btnsTitle=@[@"😊",@"😢",@"😊",@"😢",@"😢",@"😊",@"😢",@"😢",@"😊",@"😢",@"😢",@"😊",@"😢",@"😢",@"😊",@"😢",@"😢",@"😊",@"😢",@"😢",@"😊",@"😢",@"😢",@"😊",@"😢",@"😢",@"😊",@"😢",@"😢",@"😊",@"😢"];
    }
    return _btnsTitle;
}

-(NSMutableArray *)btns{
    if(!_btns){
        _btns=[NSMutableArray array];
    }
    return _btns;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor colorWithRed:243/255.0 green:243/255.0 blue:243/255.0 alpha:1];
        //添加子控件
        for(NSString *title in self.btnsTitle){
            
            [self wmt_setBtnWithTile:title];
        }
    }
    return self;
}

#pragma  - 添加按钮
-(void)wmt_setBtnWithTile:(NSString *) title{
    UIButton *btn  = [[UIButton alloc] init];
    btn.backgroundColor=[UIColor redColor];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:22.0];
    [btn addTarget:self action:@selector(moreinputBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    [self.btns addObject:btn];
    
}
-(void)moreinputBtnClick:(UIButton *)btn{
    
    NSLog(@"---BTN:%@---",btn.titleLabel.text);
}



-(void)layoutSubviews{
    [super layoutSubviews];
    NSLog(@" ===> layoutSubviews  ");
    CGFloat btnW = 40;
    CGFloat btnH = btnW;
    CGFloat orx = 10;
    CGFloat ory = 5;
    
    NSInteger maxRowCount  = 3;
    NSInteger maxColCount = 8;
    CGFloat colMargin  = (CGRectGetWidth(self.bounds) - 2*orx - maxColCount * btnW)/(maxColCount + 1);
    CGFloat rowMargin  = (CGRectGetHeight(self.bounds) - 2*ory - maxRowCount * btnH)/(maxRowCount + 2);
    
    NSInteger index=0;
    for(UIButton *btn in self.btns){
        if(index < (maxRowCount * maxColCount)){
            NSInteger col = index % maxColCount;
            NSInteger row= index / maxColCount;
            btn.frame = CGRectMake(orx+ col*(btnW + colMargin) , ory + row*(btnH + rowMargin), btnW, btnH);
        }
        index++;
    }
}

@end

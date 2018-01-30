//
//  ViewController.m
//  BQ
//
//  Created by wangmutian on 2018/1/30.
//  Copyright © 2018年 wangmutian. All rights reserved.
//

#import "ViewController.h"
#import "WMTinputview.h"
#import "UIView+Frame.h"
#import "WmtBiaoqingboardView.h"
#define kInputViewH 44
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate,WMTinputview>
@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,strong)WMTinputview *inputViewS;
@property(nonatomic,strong) WmtBiaoqingboardView *biaoqing;
@end

@implementation ViewController
-(WmtBiaoqingboardView *)biaoqing
{
    if(!_biaoqing){
        _biaoqing =[[WmtBiaoqingboardView alloc] init];
        _biaoqing.frame = CGRectMake(0, CGRectGetHeight(self.view.bounds), CGRectGetWidth(self.view.bounds), kWMTMoreinputkeyboardView);
        
        [[UIApplication sharedApplication].keyWindow addSubview:_biaoqing];
    }
    return _biaoqing;
}
-(void)viewDidAppear:(BOOL)animated{
    [self biaoqing];
}
-(UITableView *)tableview{
    if(!_tableview){
        _tableview = [[UITableView alloc] init];
        _tableview.dataSource=self;
        _tableview.delegate=self;
        _tableview.frame=CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - kInputViewH);

    }
    return _tableview;
}

-(UIView *)inputViewS{
    if(!_inputViewS){
        _inputViewS=[WMTinputview wmt_inputview];
//        _inputViewS.delegate=self;
        _inputViewS.delegate=self;
        [[UIApplication sharedApplication].keyWindow addSubview:_inputViewS];
        _inputViewS.frame=CGRectMake(0, self.view.bounds.size.height - 44, self.view.bounds.size.width, 44);
    }
    return _inputViewS;
}


- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view, typically from a nib.
    [self.view addSubview:self.tableview];
    [self.view addSubview:self.inputViewS];
    
    //监听键盘弹出，对相应的布局做修改
    [[NSNotificationCenter defaultCenter] addObserverForName:UIKeyboardWillChangeFrameNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
    
        CGFloat endY=[note.userInfo [UIKeyboardFrameEndUserInfoKey] CGRectValue].origin.y;
        CGFloat tempY = endY - self.view.bounds.size.height;
        CGFloat duration=[note.userInfo [UIKeyboardAnimationDurationUserInfoKey] floatValue];
        self.view.frame=CGRectMake(0, tempY, self.view.bounds.size.width, self.view.bounds.size.height);
        [UIView animateWithDuration:duration animations:^{
            [self.view setNeedsLayout];
            self.inputViewS.wmt_y=self.view.bounds.size.height - 44;
        }];
        
        
    }];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}



-(void)wmt_inputview:(WMTinputview *) inputView moreBtnClickWith:(NSInteger) moreStyle{
    NSLog(@"------这回好了-----");
    if (self.view.frame.origin.y == 0) {
        
        [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
             [self backinit];
            CGRect tempRect = CGRectMake(0, -kWMTMoreinputkeyboardView, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds));
            self.view.frame = tempRect;
            
            //
        } completion:^(BOOL finished) {
            //
            self.biaoqing.backgroundColor=[UIColor colorWithRed:243/255.0 green:243/255.0 blue:243/255.0 alpha:1];
            self.biaoqing.frame = CGRectMake(0, CGRectGetHeight(self.view.bounds) - kWMTMoreinputkeyboardView, CGRectGetWidth(self.view.bounds), kWMTMoreinputkeyboardView);
        }];
    }else
    {
        [self.inputViewS.testfield becomeFirstResponder];
  
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//监听滚动滚动
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self backinit];
    //叫键盘回去
    [self.view endEditing:YES];
}

//将more恢复到原样
-(void) backinit{
    [UIView animateWithDuration:0.3 animations:^{
        self.view.frame=self.view.bounds;
        self.biaoqing.frame = CGRectMake(0, CGRectGetHeight(self.view.bounds), CGRectGetWidth(self.view.bounds), kWMTMoreinputkeyboardView);
    }];
    
}


@end

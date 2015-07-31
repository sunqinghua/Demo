//
//  YIIBNavigationViewController.m
//  YIVasMobile
//
//  Created by admin on 15/4/2.
//  Copyright (c) 2015年 YixunInfo Inc. All rights reserved.
//

#import "YIIBNavigationViewController.h"
#import "YIIBNavigationSearhView.h"
#import "YIIBNavigationLineViewController.h"
#import "YIIBMapViewController.h"
#import "YIIBNavigationModel.h"
#import "YIIBMapLineManager.h"
#import "MBProgressHUD+Addition.h"
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface YIIBNavigationViewController ()<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate,UITextFieldDelegate>{
    YIIBNavigationSearhView *_searchView;
    NSDictionary *_dataDic;
    UITableView *_tableView;
}
@property (nonatomic,strong) NSMutableDictionary *location;
@property (nonatomic,strong) NSArray *items;

@end

@implementation YIIBNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initViews];
    [self initParams];
}

-(void)initViews{
    [self initSelfView];
    [self initTableView];
    [self initHeadTableView];
}

-(void)initParams{
    self.location=[NSMutableDictionary dictionary];
}

-(void)initSelfView{
    self.title=@"导航搜索";
    self.view.backgroundColor=[UIColor whiteColor];
}

-(void)initTableView{
    
    UITableView *tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    tableView.dataSource=self;
    tableView.delegate=self;
    
    //1.设置tableview清除多余的分割线
    UIView *line = [UIView new];
    line.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:line];
    _tableView=tableView;
    
    [self.view addSubview:tableView];
}

-(void)initHeadTableView{
    
    NSBundle *bundle = [NSBundle bundleWithURL:[[NSBundle mainBundle] URLForResource:@"WeconexSDKResources" withExtension:@"bundle"]];
    NSArray *nibView =  [bundle loadNibNamed:@"IDC_Navigation_Search_HeadView" owner:nil options:nil];
    
    YIIBNavigationSearhView *view=[nibView objectAtIndex:0];
    view.curLocation.delegate=self;
    view.curLocation.clearButtonMode=UITextFieldViewModeWhileEditing;
    view.destionLocation.delegate=self;
    view.destionLocation.clearButtonMode=UITextFieldViewModeWhileEditing;
    [view.search addTarget:self action:@selector(search:) forControlEvents:UIControlEventTouchUpInside];
    [view.change addTarget:self action:@selector(change:) forControlEvents:UIControlEventTouchUpInside];
    _tableView.tableHeaderView=view;
    view.curLocation.text=@"我的位置";
    _searchView=view;
}

#pragma mark -起、终地址切换
-(void)change:(UIButton *)aBtn{
    NSString *temp=_searchView.curLocation.text;
    _searchView.curLocation.text=_searchView.destionLocation.text;
    _searchView.destionLocation.text=temp;
}

#pragma mark -查找详细地址
-(void)search:(UIButton *)aBtn{
    NSLog(@"%s",__FUNCTION__);
    [_searchView.curLocation resignFirstResponder];
    [_searchView.destionLocation resignFirstResponder];
    if (_searchView.curLocation.text.length<=0||_searchView.destionLocation.text.length<=0) {
        [YIToast showText:@"地址不能为空"];
        return ;
    }
    if ([_searchView.curLocation.text isEqual:_searchView.destionLocation.text]) {
        [YIToast showText:@"开始位置与终点位置不能相同"];
        return ;
    }
    [self queryAddressMatching];
}

#pragma mark -获取详细地址
-(void)queryAddressMatching{
    NSString *start=_searchView.curLocation.text;
    NSString *end=_searchView.destionLocation.text;
    
    if (!start) {
        start=_searchView.curLocation.text;
    }
    if (!end) {
        end=_searchView.destionLocation.text;
    }
    
    if ([start isEqual:@"我的位置"]) {
        start=@"1";
    }
    
    if ([end isEqual:@"我的位置"]) {
        end=@"1";
    }
    
    __weak YIIBNavigationViewController *__self=self;
    [MBProgressHUD shareMyHUDAt:__self];
    YIIBMapLineManager *manager=[YIIBMapLineManager manager];
    //地址唯一不带坐标，跳转，导航界面要详细坐标查询数据
    manager.mapMatchAddressBlock=^(NSDictionary *data,NSString *error){
        [MBProgressHUD dismissMyHUD:__self];
        //传递不详细地址，1，1不唯一
        if (error) {
            [YIToast showText:error];
        }else{
            //1 表示我的位置
            if (![start isEqual:@"1"]) {
                if ([[data objectForKey:@"start"] integerValue]==0) {
                    [YIToast showText:@"开始位置不存在"];
                    return ;
                }
            }
            if (![end isEqual:@"1"]) {
                if ([[data objectForKey:@"end"] integerValue]==0) {
                    [YIToast showText:@"终点位置不存在"];
                    return ;
                }
            }
            
            _dataDic=data;
            
            if ([[data objectForKey:@"only"]integerValue]!=0) {
                [__self gotoNavigationVC];
            }else{
                __self.items=[data objectForKey:@"data"];
                [__self viewRefresh];
            }
        }
    };
      [manager queryAddressMatchingWithStartName:start endName:end floor:self.currentLocation.floor place:self.currentLocation.placeId];
}

#pragma mark -刷新view
-(void)viewRefresh{
    [_tableView reloadData];
}

#pragma mark -跳转到导航View
-(void)gotoNavigationVC{
    UIStoryboard *myStoryboard = [UIStoryboard storyboardWithName:@"Main_lizengshun" bundle:nil];
    YIIBNavigationLineViewController *vc = [myStoryboard instantiateViewControllerWithIdentifier:@"YIIBNavigationLineViewController"];
    YIIBNavigationModel *model=[[YIIBNavigationModel alloc]init];
    
    
    model.currentName=[self.location objectForKey:_searchView.curLocation.text];
    model.destinationName=[self.location objectForKey:_searchView.destionLocation.text];
    
    
    if ([[_dataDic objectForKey:@"startOnly"]isEqual:@"0"]) {
        if ([_searchView.curLocation.text isEqual:@"我的位置"]) {
            model.currentName=[NSString stringWithFormat:@"我的位置,人,%f,%f",self.currentLocation.x,self.currentLocation.y];
        }else{
            NSArray *start=[_dataDic objectForKey:@"startValue"];
            model.currentName=[start objectAtIndex:0];
        }
        
    }
    
    if ([[_dataDic objectForKey:@"endOnly"]isEqual:@"0"]) {
        if ([_searchView.destionLocation.text isEqualToString:@"我的位置"]) {
            model.destinationName=[NSString stringWithFormat:@"我的位置,人,%f,%f",self.currentLocation.x,self.currentLocation.y];
        }else{
            NSArray *end=[_dataDic objectForKey:@"endValue"];
            model.destinationName=[end objectAtIndex:0];
        }
    }
    
    
    model.placeid=_currentLocation.placeId;
    model.currenfloor=_currentLocation.floor;
    vc.navigationModel=model;
    [self.navigationController pushViewController:vc animated:YES];
}

-(NSString *)charComponent:(NSString *)str{
    NSArray *temp=[str componentsSeparatedByString:@","];
    NSMutableString *str1=[[NSMutableString alloc]init];
    for (int i=1; i<temp.count; i++) {
        [str1 stringByAppendingString:[NSString stringWithFormat:@"%@,",[temp objectAtIndex:i]]];
    }
    return str1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //    NSArray *rows=[self.items objectAtIndex:section];
    //    return rows.count;
    NSDictionary *dic=[self.items objectAtIndex:section];
    NSArray *rows=[dic objectForKey:@"list"];
    return rows.count;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.items.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier=@"NavigationView";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    //    NSArray *rows=[self.items objectAtIndex:indexPath.section];
    //    NSString *title=[rows objectAtIndex:indexPath.row];
    
    NSDictionary *dic=[self.items objectAtIndex:indexPath.section];
    NSArray *rows=[dic objectForKey:@"list"];
    NSString *title=[rows objectAtIndex:indexPath.row];
    
    cell.textLabel.text=[[title componentsSeparatedByString:@","]objectAtIndex:0];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [_searchView.curLocation resignFirstResponder];
    [_searchView.destionLocation resignFirstResponder];
    
    NSDictionary *dic=[self.items objectAtIndex:indexPath.section];
    NSArray *rows=[dic objectForKey:@"list"];
    NSString *title=[rows objectAtIndex:indexPath.row];
    NSString *type=[dic objectForKey:@"type"];
    
    if ([type isEqual:@"start"]) {
        NSString *name=[[title componentsSeparatedByString:@","]objectAtIndex:0];
        [self.location setValue:title forKey:name];
        _searchView.curLocation.text=name;
    }else{
        NSString *name=[[title componentsSeparatedByString:@","]objectAtIndex:0];
        [self.location setValue:title forKey:name];
        _searchView.destionLocation.text=name;
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //    NSArray *rows=[self.items objectAtIndex:indexPath.section];
    //    NSString *title=[rows objectAtIndex:indexPath.row];
    //    switch (indexPath.section) {
    //        case 0:
    //        {
    //            NSString *name=[[title componentsSeparatedByString:@","]objectAtIndex:0];
    //            [self.location setValue:title forKey:name];
    //            _searchView.curLocation.text=name;
    //        }break;
    //        case 1:{
    //            NSString *name=[[title componentsSeparatedByString:@","]objectAtIndex:0];
    //            [self.location setValue:title forKey:name];
    //            _searchView.destionLocation.text=name;
    //        }break;
    //        default:
    //            break;
    //    }
}



-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, KMainScreenSize.width, 30)];
    view.backgroundColor=UIColorFromRGB(0xc7c7c7);
    UILabel *l=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, 200, 30)];
    l.textColor=[UIColor whiteColor];
    [view addSubview:l];
    //    if (section==0) {
    //        l.text=@"起始站选择";
    //    }else{
    //        l.text=@"终点站选择";
    //    }
    
    NSDictionary *dic=[self.items objectAtIndex:section];
    l.text=[dic objectForKey:@"title"];
    
    return view;
    
}



-(CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    NSArray *rows=[self.items objectAtIndex:section];
    if (rows.count==0) {
        return 0.1;
    }else{
        return 30;
    }
}



/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end

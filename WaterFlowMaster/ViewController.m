//
//  ViewController.m
//  WaterFlowMaster
//
//  Created by Duomai on 15/8/26.
//  Copyright (c) 2015年 zpf. All rights reserved.
//

#import "ViewController.h"
#import "ListDataModel.h"
#import "WaterFlowCell.h"
#import "UIImageView+WebCache.h"
#define KColumns 2
@interface ViewController ()
@property(nonatomic,strong)NSMutableArray * listData;

@end

@implementation ViewController


-(NSMutableArray*)listData{

    if (_listData == nil) {
        _listData = [NSMutableArray array];
    }
    return _listData;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    NSString * filePath = [[NSBundle mainBundle] pathForResource:@"mogujie00" ofType:@"plist"];
    NSDictionary * dict = [NSDictionary dictionaryWithContentsOfFile:filePath];
  
    NSMutableArray * arr = dict[@"result"][@"list"];
    for (NSDictionary * dict in arr) {
         NSDictionary *showDict = dict[@"show"];
        ListDataModel * data = [[ListDataModel alloc] initWithDict:showDict];
        [self.listData addObject:data];
    }
    
    [self.waterFlowView reloadData];
    
}

-(NSInteger)WaterFlowView:(WaterFlowView *)waterFlowView numberOfRowsInColumns:(NSInteger)columns{
    return self.listData.count;
}

- (NSInteger)numberOfColumnsInWaterFlowView:(WaterFlowView *)waterFlowView{
    if ([UIDevice currentDevice].orientation == UIInterfaceOrientationLandscapeLeft || [UIDevice currentDevice].orientation == UIInterfaceOrientationLandscapeRight) {
        return 4;
    }
    return KColumns;
}

-(WaterFlowCell*)WaterFlowView:(WaterFlowView *)waterFlowView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellIdentifier = @"cellIdentifier";
    WaterFlowCell * cell = [waterFlowView  dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[WaterFlowCell alloc] initWithReusableIdentifier:cellIdentifier];
    }
    ListDataModel * data = self.listData[indexPath.row];
    [cell.imageView setImageWithURL:data.img];
    cell.titleLabel.text = data.price;
    return  cell;
}

- (CGFloat)waterFlowView:(WaterFlowView *)waterFlowView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    ListDataModel * data = self.listData[indexPath.row];
    CGFloat ColumnsWidth = self.view.bounds.size.width / KColumns; // 每个单元格的宽度
    return ColumnsWidth / data.w * data.h;
}


-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation{
    [self.waterFlowView reloadData];
}

@end

//
//  WaterFlowView.m
//  WaterFlowMaster
//
//  Created by Duomai on 15/8/26.
//  Copyright (c) 2015年 zpf. All rights reserved.
//

#import "WaterFlowView.h"
#import "WaterFlowCell.h"
@interface WaterFlowView()

@property(nonatomic,assign)NSInteger numberOfColumns; //列数
@property(nonatomic,assign)NSInteger numberOfRows; //行数
@property(nonatomic,strong)NSMutableArray * indexPaths;
@property(nonatomic,strong)NSMutableSet * reusableCellSet;

@property(nonatomic,strong)NSMutableDictionary * visibleCellDict;

@end

@implementation WaterFlowView

#pragma mark 查询可重用的单元格
-(id) dequeueReusableCellWithIdentifier:(NSString*)identifier{
    WaterFlowCell * cell = [self.reusableCellSet anyObject];
    if (cell) {
        [self.reusableCellSet removeObject:cell];
    }
   
    return cell;
}

-(void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    [self reloadData];
    
}

#pragma mark 列数
-(NSInteger)numberOfColumns{
    NSInteger number = 1;
    if ([self.dataSouce respondsToSelector:@selector(numberOfColumnsInWaterFlowView:)]) {
          number = [self.dataSouce numberOfColumnsInWaterFlowView:self];
    }
    _numberOfColumns = number;
    
    return _numberOfColumns;
}
#pragma mark 行数
-(NSInteger)numberOfRows{
    if ([self.dataSouce respondsToSelector:@selector(WaterFlowView:numberOfRowsInColumns:)]) {
        _numberOfRows = [self.dataSouce WaterFlowView:self numberOfRowsInColumns:0];
    }
    return _numberOfRows;
}

#pragma mark 刷新数据
-(void)reloadData{
    
    if (self.numberOfRows == 0) {
        return;
    }
    [self setupSubViews]; //布局子视图
}

#pragma mark setupSubViews 布局子视图
-(void)setupSubViews{

    for (UIView * aview in self.subviews) {
        [aview removeFromSuperview];
    }
    
    if (self.indexPaths == nil) {
        self.indexPaths = [NSMutableArray arrayWithCapacity:self.numberOfRows];
    }else{
        [self.indexPaths removeAllObjects];
    }
    
    
    if (self.cellFrameArray == nil) {
        self.cellFrameArray = [NSMutableArray array];
    }else{
        [self.cellFrameArray removeAllObjects];
    }
    
    if (self.reusableCellSet == nil) {
        self.reusableCellSet = [NSMutableSet set];
    }else{
        [self.reusableCellSet removeAllObjects];
    }
    
    
    if (self.visibleCellDict == nil) {
        self.visibleCellDict  = [NSMutableDictionary dictionary];
    }else{
        [self.visibleCellDict removeAllObjects];
    }
    
    CGFloat cellWidth = self.bounds.size.width / self.numberOfColumns; // 每个单元格的宽度
    for (NSInteger index = 0; index < self.numberOfRows; index++) {
        NSIndexPath * indexPath = [NSIndexPath indexPathForRow:index inSection:0];
        [self.indexPaths addObject:indexPath];
    }
    
    CGFloat cellYArray[self.numberOfColumns];
    for (NSInteger i = 0; i < self.numberOfColumns; i++) { //初始化 单元格Y值
        cellYArray[i] = 0.0;
    }
    
    NSInteger col = 0;
    for (NSIndexPath * indexPath in self.indexPaths) {
       // NSInteger colum = indexPath.row % self.numberOfColumns;
        CGFloat cellHeight  = [self.delegate waterFlowView:self heightForRowAtIndexPath:indexPath]; //每个单元格的高度
        CGFloat cellX = col * cellWidth; //每个单元格的X
        CGFloat cellY = cellYArray[col];
        cellYArray[col] += cellHeight;
        
        NSInteger  nextCol =(col+1)%self.numberOfColumns;
        if (cellYArray[col] > cellYArray[nextCol]) {
            col = nextCol;
        }
        
        [self.cellFrameArray addObject:[NSValue valueWithCGRect:CGRectMake(cellX, cellY, cellWidth, cellHeight)]];
        
    }
    
    
    CGFloat MaxY = 0;
    for (NSInteger index = 0; index < self.numberOfColumns; index++) {
        if (cellYArray[index] > MaxY) {
            MaxY = cellYArray[index];
        }
        
    }
    self.contentSize = CGSizeMake(0, MaxY);
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
   
    NSInteger  index = 0;
    for (NSIndexPath * indexPath in self.indexPaths) {
        
        WaterFlowCell * cell = self.visibleCellDict[indexPath];
        cell.didTapBlock = ^(){
        
            NSLog(@"_______%d",cell.tag);
        };
        cell.tag = indexPath.row;
        if (cell == nil) {
            WaterFlowCell * cell = [self.dataSouce WaterFlowView:self cellForRowAtIndexPath:indexPath];
            CGRect frame = [self.cellFrameArray[index] CGRectValue];
            if ([self IsInScreenWithFrame:frame]) {
                cell.frame = frame;
                [self addSubview:cell];
                
            [self.visibleCellDict setObject:cell forKey:indexPath];
            }
        }else{
            if (![self IsInScreenWithFrame:cell.frame]) {
                [cell removeFromSuperview];
                
                [self.reusableCellSet addObject:cell];
//                  NSLog(@"%lu",(unsigned long)self.reusableCellSet.count);
                [self.visibleCellDict removeObjectForKey:indexPath];
                
            }
        }
        
         index++;
    }
    
}


-(BOOL)IsInScreenWithFrame:(CGRect)frame{

    return   ((frame.origin.y + frame.size.height > self.contentOffset.y)  && (frame.origin.y < self.contentOffset.y + self.bounds.size.height));
    
}

@end

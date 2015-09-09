//
//  WaterFlowLayout.m
//  WaterFlowMaster
//
//  Created by Duomai on 15/8/31.
//  Copyright (c) 2015年 zpf. All rights reserved.
//

#import "WaterFlowLayout.h"


@interface WaterFlowLayout ()

@property(nonatomic,strong)NSMutableDictionary * maxYDict;//存储每一列的最大高度

@property(nonatomic,strong)NSMutableArray * layoutArrtbuteArray;
@end

@implementation WaterFlowLayout

-(NSMutableDictionary*)maxYDict{

    if (_maxYDict == nil) {
        _maxYDict = [NSMutableDictionary dictionary];
       
    }
    return _maxYDict;
}

-(NSMutableArray*)layoutArrtbuteArray{

    if (_layoutArrtbuteArray == nil) {
        _layoutArrtbuteArray = [NSMutableArray array];
    }
    return _layoutArrtbuteArray;
}

-(id)init{
    if (self = [super init]) {
        
        self.columnMargin = 10;
        self.rowMargin = 10 ;
        self.columnCount = 3;
        self.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    }
    return self;
}

-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{

    return YES;
}


-(CGSize)collectionViewContentSize{

    //假设第0列是最长
    __block  NSString * maxColum = @"0";
    [self.maxYDict enumerateKeysAndObjectsUsingBlock:^(NSString *  column, NSNumber * maxY, BOOL *stop) {
        if ([maxY floatValue] > [self.maxYDict[maxColum] floatValue]) {
            maxColum = column;
        }
        
    }];
    
    return CGSizeMake(0, [self.maxYDict[maxColum] floatValue]);
}


//每次布局都会调用
-(void)prepareLayout{
    [super prepareLayout];
}


-(UICollectionViewLayoutAttributes*)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{

    //假设第0列是最短
    __block  NSString * minColum = @"0";
    [self.maxYDict enumerateKeysAndObjectsUsingBlock:^(NSString *  column, NSNumber * maxY, BOOL *stop) {
        if ([maxY floatValue] < [self.maxYDict[minColum] floatValue]) {
            minColum = column;
        }
        
    }];
    
    CGFloat width = (self.collectionView.frame.size.width - self.sectionInset.left - self.sectionInset.right - (self.columnCount - 1)* self.columnMargin)/ self.columnCount;
    CGFloat heigth = [self.delegate waterFlowLayout:self heightForWith:width atIndexPath:indexPath];
    
    CGFloat x = self.sectionInset.left + (width + self.columnMargin) * [minColum integerValue];
    CGFloat y = self.rowMargin + [self.maxYDict[minColum] floatValue];
    
    self.maxYDict[minColum] = @(y+heigth);
    
    UICollectionViewLayoutAttributes * layoutAttributes= [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    layoutAttributes.frame = CGRectMake(x, y, width, heigth);
    return layoutAttributes;
}

-(NSArray*)layoutAttributesForElementsInRect:(CGRect)rect{
    for (int index = 0; index < self.columnCount; index++) {
        NSString * column = [NSString stringWithFormat:@"%d",index];
        _maxYDict[column] = @0;
    }
    [self.layoutArrtbuteArray removeAllObjects];
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    for (int index = 0; index < count; index++) {
        UICollectionViewLayoutAttributes * layoutAttributes = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0]];
        [self.layoutArrtbuteArray addObject:layoutAttributes];
    }
    return self.layoutArrtbuteArray;
}
@end

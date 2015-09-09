//
//  CustomCollectionView.m
//  WaterFlowMaster
//
//  Created by Duomai on 15/8/31.
//  Copyright (c) 2015年 zpf. All rights reserved.
//

#import "CustomCollectionView.h"
#import "WaterFlowLayout.h"
#import "CollectionCell.h"
#import "ListDataModel.h"
#import "UIImageView+WebCache.h"
@interface CustomCollectionView ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property(nonatomic,strong)NSMutableArray * listData;
@property(nonatomic,weak)UICollectionView * collectionView;
@end

@implementation CustomCollectionView

-(NSMutableArray*)listData{
    
    if (_listData == nil) {
        _listData = [NSMutableArray array];
    }
    return _listData;
}

static NSString * const CellID = @"CellID";

- (void)viewDidLoad {
    [super viewDidLoad];
    WaterFlowLayout  * flowLayout = [[WaterFlowLayout alloc] init];
    UICollectionView * collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height) collectionViewLayout:flowLayout];
    collectionView.alwaysBounceVertical = YES;
    collectionView.backgroundColor = [UIColor grayColor];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    [collectionView registerNib:[UINib nibWithNibName:@"CollectionCell" bundle:nil] forCellWithReuseIdentifier:CellID];
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
    
    NSString * filePath = [[NSBundle mainBundle] pathForResource:@"mogujie02" ofType:@"plist"];
    NSDictionary * dict = [NSDictionary dictionaryWithContentsOfFile:filePath];
    
    NSMutableArray * arr = dict[@"result"][@"list"];
    for (NSDictionary * dict in arr) {
        NSDictionary *showDict = dict[@"show"];
        ListDataModel * data = [[ListDataModel alloc] initWithDict:showDict];
        [self.listData addObject:data];
    }
    
    [self.collectionView reloadData];
    
}



-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.listData.count;
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CollectionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellID forIndexPath:indexPath];
    ListDataModel * data = self.listData[indexPath.row];
    [cell.imageView setImageWithURL:data.img];
    cell.subject.text = data.price;
    return cell;
}


@end

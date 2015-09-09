//
//  WaterFlowLayout.h
//  WaterFlowMaster
//
//  Created by Duomai on 15/8/31.
//  Copyright (c) 2015年 zpf. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WaterFlowLayout;
@protocol WaterFlowLayoutDelegate <NSObject>

-(CGFloat)waterFlowLayout:(WaterFlowLayout*)flowLayout heightForWith:(CGFloat)width atIndexPath:(NSIndexPath*)indexPath ;

@end

@interface WaterFlowLayout : UICollectionViewFlowLayout
@property(nonatomic,assign)CGFloat columnMargin;
@property(nonatomic,assign)CGFloat rowMargin;
@property(nonatomic,assign)NSInteger columnCount;
@property(nonatomic,weak)id <WaterFlowLayoutDelegate> delegate;
@end

//
//  WaterFlowView.h
//  WaterFlowMaster
//
//  Created by Duomai on 15/8/26.
//  Copyright (c) 2015年 zpf. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WaterFlowCell;
@class WaterFlowView;

#pragma mark WaterFlowViewDataSource
@protocol WaterFlowViewDataSource <NSObject>

@required
- (NSInteger)WaterFlowView:(WaterFlowView *)waterFlowView numberOfRowsInColumns:(NSInteger)columns;

- (WaterFlowCell *)WaterFlowView:(WaterFlowView *)waterFlowView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

@optional
- (NSInteger)numberOfColumnsInWaterFlowView:(WaterFlowView *)waterFlowView;              // Default is 1 if not implemented
@end


#pragma mark WaterFlowViewDelegate
@protocol WaterFlowViewDelegate <NSObject,UIScrollViewDelegate>

@optional
- (CGFloat)waterFlowView:(WaterFlowView *)waterFlowView heightForRowAtIndexPath:(NSIndexPath *)indexPath;


@end


@interface WaterFlowView : UIScrollView


@property(nonatomic,weak) id <WaterFlowViewDataSource> dataSouce;
@property(nonatomic,weak)id <WaterFlowViewDelegate> delegate;

@property(nonatomic,strong)NSMutableArray * cellFrameArray;

-(void)reloadData;//刷新数据
-(id) dequeueReusableCellWithIdentifier:(NSString*)identifier;

@end

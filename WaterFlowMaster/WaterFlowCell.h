//
//  WaterFlowCell.h
//  WaterFlowMaster
//
//  Created by Duomai on 15/8/26.
//  Copyright (c) 2015年 zpf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WaterFlowCell : UIView

@property(nonatomic,strong)UIImageView * imageView;
@property(nonatomic,strong)UILabel * titleLabel;
@property(nonatomic,copy)NSString * identifier;
@property(nonatomic,copy) void (^didTapBlock)();
-(instancetype)initWithReusableIdentifier:(NSString*)identifier;

@end

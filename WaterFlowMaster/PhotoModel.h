//
//  PhotoModel.h
//  WaterFlowMaster
//
//  Created by Duomai on 15/9/11.
//  Copyright (c) 2015年 zpf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface PhotoModel : NSObject

+(instancetype)photoWihtURL:(NSString*)imageURL index:(NSInteger)index srcFrame:(CGRect)srcFrame;

@property(nonatomic,copy)NSString * imageURL;
@property(nonatomic,assign)NSInteger index;
@property(nonatomic,assign)CGRect srcframe;

@property(nonatomic,strong)UIImage * image;

@end

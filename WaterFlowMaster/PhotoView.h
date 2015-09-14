//
//  PhotoView.h
//  WaterFlowMaster
//
//  Created by Duomai on 15/9/11.
//  Copyright (c) 2015年 zpf. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PhotoModel ;
@interface PhotoView : UIScrollView
@property(nonatomic,strong)UIImageView * imageView;
@property(nonatomic,strong)PhotoModel * photoModel;
@property(nonatomic,copy)void (^tapImageViewBlock)();
@end

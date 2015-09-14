//
//  PhotoModel.m
//  WaterFlowMaster
//
//  Created by Duomai on 15/9/11.
//  Copyright (c) 2015年 zpf. All rights reserved.
//

#import "PhotoModel.h"

@implementation PhotoModel
+(instancetype)photoWihtURL:(NSString*)imageURL index:(NSInteger)index srcFrame:(CGRect)srcFrame{

    PhotoModel * photoModel = [[PhotoModel alloc] init];
    
    photoModel.imageURL = imageURL;
    photoModel.index = index;
    photoModel.srcframe = srcFrame;
    
    return photoModel;
}
@end

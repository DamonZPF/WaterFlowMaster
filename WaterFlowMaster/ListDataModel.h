//
//  ListDataModel.h
//  WaterFlowMaster
//
//  Created by Duomai on 15/8/26.
//  Copyright (c) 2015年 zpf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface ListDataModel : NSObject
@property (strong, nonatomic) NSURL *img;
@property (assign, nonatomic) CGFloat w;
@property (assign, nonatomic) CGFloat h;
@property (strong, nonatomic) NSString *price;

// 增加大图URL
@property (strong, nonatomic) NSURL *largeImageUrl;

-(instancetype)initWithDict:(NSDictionary*)dictionary;
-(NSMutableArray*)dataWithArray:(NSArray*)dataArray;
@end

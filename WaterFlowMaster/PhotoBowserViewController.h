//
//  PhotoBowserViewController.h
//  WaterFlowMaster
//
//  Created by Duomai on 15/9/11.
//  Copyright (c) 2015年 zpf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoBowserViewController : UIViewController
@property(nonatomic,strong)NSArray * imageArray;
@property(nonatomic,assign)NSInteger currentIndex;

-(void)show;

@end

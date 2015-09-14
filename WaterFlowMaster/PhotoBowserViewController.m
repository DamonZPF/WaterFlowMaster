//
//  PhotoBowserViewController.m
//  WaterFlowMaster
//
//  Created by Duomai on 15/9/11.
//  Copyright (c) 2015年 zpf. All rights reserved.
//

#import "PhotoBowserViewController.h"
#import "PhotoView.h"
@interface PhotoBowserViewController ()

@property(nonatomic,weak)  UIScrollView * rootScrollView;

@end

@implementation PhotoBowserViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    //根scrollView
    [self setRootScrollView];
}


-(void)setRootScrollView{

    UIScrollView * rootScrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:rootScrollView];
    self.rootScrollView = rootScrollView;
    
}

-(void)show{
    [[UIApplication sharedApplication]setStatusBarHidden:YES];
    UIWindow * winodw = [UIApplication sharedApplication].keyWindow;
    [winodw addSubview:self.view];
    [winodw.rootViewController addChildViewController:self];
    
    [self setupPhotoView];
    
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
  
}

-(void)setupPhotoView{
    PhotoView * photoView = [[PhotoView alloc]initWithFrame:self.view.bounds];
    photoView.photoModel = self.imageArray[self.currentIndex];
    photoView.tapImageViewBlock = ^(){
        
        [[UIApplication sharedApplication]setStatusBarHidden:NO];
        [self.view removeFromSuperview];
        [self removeFromParentViewController];
    };
    [self.rootScrollView addSubview:photoView];
    
}

@end

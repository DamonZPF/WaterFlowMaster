//
//  WaterFlowViewController.m
//  WaterFlowMaster
//
//  Created by Duomai on 15/8/26.
//  Copyright (c) 2015年 zpf. All rights reserved.
//

#import "WaterFlowViewController.h"

@interface WaterFlowViewController ()<WaterFlowViewDataSource,WaterFlowViewDelegate>

@end

@implementation WaterFlowViewController

-(void)loadView{

    self.waterFlowView = [[WaterFlowView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    self.waterFlowView.autoresizingMask =  UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.waterFlowView.dataSouce = self;
    self.waterFlowView.delegate = self;
    self.waterFlowView.backgroundColor = [UIColor whiteColor];
    self.view = self.waterFlowView;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
   // [self.waterFlowView reloadData];
}


-(NSInteger)WaterFlowView:(WaterFlowView *)waterFlowView numberOfRowsInColumns:(NSInteger)columns{
    return 1;
}

-(WaterFlowCell*)WaterFlowView:(WaterFlowView *)waterFlowView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}



@end

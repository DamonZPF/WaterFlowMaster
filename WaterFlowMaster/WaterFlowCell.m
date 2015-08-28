//
//  WaterFlowCell.m
//  WaterFlowMaster
//
//  Created by Duomai on 15/8/26.
//  Copyright (c) 2015年 zpf. All rights reserved.
//

#import "WaterFlowCell.h"
#define KMarginW 5
#define KLableHeight 20
@interface WaterFlowCell ()

@end

@implementation WaterFlowCell

-(instancetype)initWithReusableIdentifier:(NSString*)identifier{
    self = [super init];
    
    if (self) {
        self.identifier = identifier;
        
    }
    return self;
}


-(UIImageView*)imageView{

    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] init];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        _imageView.userInteractionEnabled = YES;
    
        [self addSubview:_imageView];
        
        UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTap)];
        [_imageView addGestureRecognizer:tapGesture];
    }
    
    return _imageView;
}

-(void)didTap{
    if (self.didTapBlock) {
        self.didTapBlock();
    }
    
}


-(UILabel*)titleLabel{

    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        _titleLabel.textColor = [UIColor whiteColor];
        [self insertSubview:_titleLabel aboveSubview:_imageView];
    }
    return _titleLabel;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.imageView.frame = CGRectInset(self.bounds, KMarginW, KMarginW);
    self.titleLabel.frame= CGRectMake(KMarginW, self.imageView.frame.size.height - KLableHeight +  3, self.imageView.bounds.size.width, KLableHeight);
    
}


@end

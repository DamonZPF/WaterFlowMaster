//
//  PhotoView.m
//  WaterFlowMaster
//
//  Created by Duomai on 15/9/11.
//  Copyright (c) 2015年 zpf. All rights reserved.
//

#import "PhotoView.h"
#import "PhotoModel.h"
#import "UIImageView+WebCache.h"
@interface PhotoView()<UIScrollViewDelegate>

@property(nonatomic,assign)BOOL isdoubleTap;

@end

@implementation PhotoView

-(id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor blackColor];
        _imageView = [[UIImageView alloc] initWithFrame:frame];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        _imageView.userInteractionEnabled = YES;
        [self addSubview:_imageView];
        
  
        
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.minimumZoomScale = 1.0;
        self.maximumZoomScale = 2.0;
        self.delegate = self;
        
        UITapGestureRecognizer * singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage)];
        singleTap.numberOfTapsRequired = 1;
        [self addGestureRecognizer:singleTap];
        
        UITapGestureRecognizer * doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTapAction:)];
        doubleTap.numberOfTapsRequired = 2;
        [self addGestureRecognizer:doubleTap];
    }
    return self;
}

-(void)doubleTapAction:(UITapGestureRecognizer*)tap{
    self.isdoubleTap = YES;
    if (self.zoomScale == self.maximumZoomScale) {
        [self setZoomScale:self.minimumZoomScale animated:YES];
    }else{
        CGPoint point =  [tap locationInView:self];
        [self zoomToRect:CGRectMake(point.x, point.y, 1, 1) animated:YES];

    }
    
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{

    return self.imageView;
}

-(void)tapImage{
    
    self.isdoubleTap = NO;
    [self performSelector:@selector(hideView) withObject:self afterDelay:0.2];
    
    
}

-(void)hideView{
    if (self.isdoubleTap) {
        return;
    }
    [UIView animateWithDuration:0.5 animations:^{
        self.alpha = 0;
        [_imageView setFrame:self.photoModel.srcframe];
    } completion:^(BOOL finished) {
        if (self.tapImageViewBlock) {
            self.tapImageViewBlock();
        }
    }];

    
}

-(void)setPhotoModel:(PhotoModel *)photoModel{
    _photoModel = photoModel;
    
    __weak typeof(self) weakSelf = self;
    if (photoModel.image) {
        self.imageView.image = photoModel.image;
    }else{
        [self.imageView setImageWithURL:[NSURL URLWithString:photoModel.imageURL] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
            weakSelf.photoModel.image = image;
        }];
        
        [self addjustFrame];
    }
    
    
}

-(void)addjustFrame{

    // 1. 定义计算参考值
    CGFloat viewW = self.bounds.size.width;
    CGFloat viewH = self.bounds.size.height;
    
    CGFloat imageW = _imageView.image.size.width+100;
    CGFloat imageH = _imageView.image.size.height+100;
    
    // 2. 调整图像的思路
    // 1) 如果图像的宽高都分别小于视图的宽高，将图像设置在屏幕中心位置即可
    // 2) 如果图像的宽度小于屏幕宽度，高度大于屏幕高度
    //    不调整图像大小，让图像的顶端与视图顶端对齐，并且设置滚动区域，保证能够滚动查看图像内容
    // 3) 宽度和高度都超过屏幕宽高
    //    缩放图像的宽度，与屏幕宽度一致，高度按比例调整
    //      调整后的高度如果小于屏幕高度，图像居中
    //      调整后的高度如果大于屏幕高度，图像置顶
    
    // 2. 计算缩放比例
    CGFloat scale = viewW / imageW;
    // 如果scale > 1.0 说明图像宽度小于视图宽度，可以不用考虑图像宽度
    if (scale < 1.0) {
        // 计算图像新的高度和宽度
        imageH *= scale;
        imageW = viewW;
    }
    
    CGRect imageFrame = CGRectMake(0, 0, viewW, imageH);
    
    if (imageH < viewH) {
        imageFrame.origin.y = (viewH - imageH) / 2.0;
    } else {
        // 设置滚动区域
        [self setContentSize:CGSizeMake(viewW, imageH)];
    }
    
    [_imageView setFrame:self.photoModel.srcframe];
    [UIView animateWithDuration:0.3 animations:^{
        [_imageView setFrame:imageFrame];
    }];
    
    
}


@end

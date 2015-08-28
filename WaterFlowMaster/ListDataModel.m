//
//  ListDataModel.m
//  WaterFlowMaster
//
//  Created by Duomai on 15/8/26.
//  Copyright (c) 2015年 zpf. All rights reserved.
//

#import "ListDataModel.h"
#import <objc/runtime.h>
@implementation ListDataModel

-(instancetype)initWithDict:(NSDictionary*)dictionary{
    unsigned int outCount = 0;
    Class currentClass = [self class];
    while (currentClass) {
        objc_property_t *properties = class_copyPropertyList(currentClass, &outCount);
        for (int i = 0; i < outCount; i++) {
            objc_property_t property = properties[i];
            NSString *propertyNameString =[[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding] ;
            id value = [dictionary objectForKey:propertyNameString];
            if (value != nil) {
               [self setValue:value forKey:propertyNameString];
            }
        }
        Class superclass = [currentClass superclass];
        currentClass = superclass;
    }
    return self;
}

-(NSMutableArray*)dataWithArray:(NSArray*)dataArray{
    NSMutableArray * tempArray = [NSMutableArray array];
    for (NSDictionary * dict in dataArray) {
        [tempArray  addObject:[[[self class] alloc] initWithDict:dict]];
    }
    return tempArray;
  
}


-(NSString*)description{
    return [NSString stringWithFormat:@"%@,%f,%f,%@",self.img,self.w,self.h,self.price];
}

@end

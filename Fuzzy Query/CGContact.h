//
//  CGContact.h
//  Fuzzy Query
//
//  Created by Mille.Yin on 2016/6/18.
//  Copyright © 2016年 Mille.Yin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CGContact : NSObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *tel;

+ (instancetype)contactWithName:(NSString *)name tel:(NSString *)tel;


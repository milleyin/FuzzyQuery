//
//  CGContactTool.h
//  Fuzzy Query
//
//  Created by Mille.Yin on 2016/6/18.
//  Copyright © 2016年 Mille.Yin. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CGContact;
@interface CGContactTool : NSObject
+ (void)saveDataWithContact:(CGContact *)contact;

+ (NSArray *)contact;

+ (NSArray *)contactWithSql:(NSString *)sql;
@end

//
//  CGContact.m
//  Fuzzy Query
//
//  Created by Mille.Yin on 2016/6/18.
//  Copyright © 2016年 Mille.Yin. All rights reserved.
//

#import "CGContact.h"

@implementation CGContact

+ (instancetype)contactWithName:(NSString *)name tel:(NSString *)tel;
{
    CGContact *contact = [[self alloc] init];
    contact.name = name;
    contact.tel = tel;
    
    return contact;
}
@end
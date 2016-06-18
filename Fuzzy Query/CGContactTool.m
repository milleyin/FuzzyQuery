//
//  CGContactTool.m
//  Fuzzy Query
//
//  Created by Mille.Yin on 2016/6/18.
//  Copyright © 2016年 Mille.Yin. All rights reserved.
//

#import "CGContactTool.h"
#import "CGContact.h"
#import <sqlite3.h>
@implementation CGContactTool

static sqlite3 *_db;

+(void)initialize
{
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filePath = [cachePath stringByAppendingPathComponent:@"contact.sqlite"];

    if (sqlite3_open(filePath.UTF8String, &_db) == SQLITE_OK) {
        NSLog(@"success");
    }else{
        NSLog(@"Failure");
    }
    
    NSString *sql = @"create table if not exists t_contact (id integer primary key autoincrement, name text, tel text);";
    char *err;
    
    sqlite3_exec(_db, sql.UTF8String, NULL, NULL, &err);
    
    if (err) {
        NSLog(@"create table failure");
    }else{
        NSLog(@"create table success");
    }
}


+ (BOOL)execWithSql:(NSString *)sql
{
    BOOL flag;
    char *err;
    
    sqlite3_exec(_db, sql.UTF8String, NULL, NULL, &err);
    
    if (err) {
        flag = NO;
        NSLog(@"%s", err);
    }else{
        flag = YES;
        
    }
    return flag;
}



+(void)saveDataWithContact:(CGContact *)contact
{
    
    NSString *sql = [NSString stringWithFormat:@"insert into t_contact (name, tel) values ('%@','%@');",contact.name,contact.tel];
    
    BOOL flag = [self execWithSql:sql];
    
    if (flag) {
        NSLog(@"insert success");
    }else{
        NSLog(@"insert failure");
    }
}

+(NSArray *)contact
{
    return [self contactWithSql:@"select * from t_contact"];
}

+ (NSArray *)contactWithSql:(NSString *)sql
{
    NSMutableArray *contactArray = [NSMutableArray array];

    sqlite3_stmt *stmt;
    if (sqlite3_prepare_v2(_db, sql.UTF8String, -1, &stmt, NULL) == SQLITE_OK) {

        while (sqlite3_step(stmt) == SQLITE_ROW) {
            NSString *name = [NSString stringWithUTF8String:sqlite3_column_text(stmt, 1)];
            NSString *tel = [NSString stringWithUTF8String:sqlite3_column_text(stmt, 2)];
            CGContact *c = [CGContact contactWithName:name tel:tel];
            [contactArray addObject:c];
        }
        
    }
    return contactArray;
    
}
@end
//
//  DBManager.m
//  RPSqlite
//
//  Created by Student P_07 on 27/02/17.
//  Copyright © 2017 Rupali Pakale. All rights reserved.
//

#import "DBManager.h"
#import <sqlite3.h>
static sqlite3 *sqlite = nil;
static DBManager *sharedManager=nil;
static sqlite3_stmt *stm= nil;
@implementation DBManager

+(DBManager *)getInstance{
    if(sharedManager==nil)
    {
        
        sharedManager=[[DBManager alloc]init];
    }
    return sharedManager;
}

-(void)createDB{
    NSArray *array = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *strDocumentPath = [array objectAtIndex:0];
    strDBPath = [strDocumentPath stringByAppendingPathComponent:@"student.sqlite"];
    NSFileManager *file = [NSFileManager defaultManager];
    if ([file fileExistsAtPath:strDBPath] == NO) {
        const char *openquery = [strDBPath UTF8String];
        if (sqlite3_open(openquery, &sqlite) == SQLITE_OK) {
            NSString *strInsertQuery = @"create table if not exists student (id integer primary key autoincrement,name text,address text)";
            const char *creatQuery = [strInsertQuery UTF8String];
            char *error;
            if (sqlite3_exec(sqlite, creatQuery, NULL, NULL,&error) == SQLITE_OK) {
                NSLog(@"tbl create");
            }else{
                NSLog(@"%s",error);
            }
            sqlite3_close(sqlite);
        }
    }
    
}
-(void)insertDataIntoDB:(NSInteger)stu_id withname:(NSString *)name alongwithaddress:(NSString *)address{
    const char *db = [strDBPath UTF8String];
    if (sqlite3_open(db, &sqlite) == SQLITE_OK) {
        NSString *strInsert = [NSString stringWithFormat:@"insert or replace into student (name,address) values ('%@','%@')",name,address];
         const char *insertquery = [strInsert UTF8String];
        if (sqlite3_prepare_v2(sqlite, insertquery, -1, &stm, NULL) == SQLITE_OK) {
            if (sqlite3_step(stm) == SQLITE_DONE) {
                NSLog(@"done");
            }else{
              NSLog(@"not done");
            }
           
            
        }
        sqlite3_close(sqlite);
    }
}

-(NSArray *)FetchFromDB{
    NSMutableArray *arry = [[NSMutableArray alloc]init];
    const char *db = [strDBPath UTF8String];
    if (sqlite3_open(db, &sqlite) == SQLITE_OK) {
        NSString *str = @"select * from student";
        const char *query = [str UTF8String];
        if (sqlite3_prepare_v2(sqlite, query, -1, &stm, NULL) == SQLITE_OK) {
            while (sqlite3_step(stm) == SQLITE_ROW) {
                NSString *strname = [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text(stm, 1)];
                NSLog(@"%@",str);
                NSString *straddress = [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text(stm, 2)];
                NSLog(@"%@",str);
                int i = sqlite3_column_int(stm, 0);
                NSString *strid = [NSString stringWithFormat:@"%d",i];
                NSMutableDictionary * dict= [[NSMutableDictionary alloc]init];
                [dict setObject:strname forKey:@"name"];
                 [dict setObject:straddress forKey:@"address"];
                 [dict setObject:strid forKey:@"id"];
                [arry addObject:dict];
            }
        }
        sqlite3_close(sqlite);
    }
    return arry;
}

-(BOOL)deleteWithId:(NSString *)studentID
{
    const char *db = [strDBPath UTF8String];
    if (sqlite3_open(db, &sqlite) == SQLITE_OK) {
        NSString *strDelete = [NSString stringWithFormat:@"delete from student where id = '%@'",studentID];
        const char *insertquery = [strDelete UTF8String];
        if (sqlite3_prepare_v2(sqlite, insertquery, -1, &stm, NULL) == SQLITE_OK) {
            if (sqlite3_step(stm) == SQLITE_DONE) {
                return YES;
            }
            else
            {
                NSLog(@"not done");
                return NO;
                
            }
            
            
        }
        sqlite3_close(sqlite);
    }
    return NO;
}
-(BOOL)UpdateWithId:(NSString *)studentID andName:(NSString *)newName andAddress:(NSString *)newAddress
{
    const char *db = [strDBPath UTF8String];
    if (sqlite3_open(db, &sqlite) == SQLITE_OK) {
        NSString *strDelete = [NSString stringWithFormat:@"update student set name='%@',address='%@'  where id = '%@'",newName,newAddress,studentID];
        const char *insertquery = [strDelete UTF8String];
        if (sqlite3_prepare_v2(sqlite, insertquery, -1, &stm, NULL) == SQLITE_OK) {
            if (sqlite3_step(stm) == SQLITE_DONE) {
                return YES;
            }
            else
            {
                NSLog(@"not done");
                return NO;
                
            }
            
            
        }
        sqlite3_close(sqlite);
    }
    return NO;
}


@end

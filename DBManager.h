//
//  DBManager.h
//  RPSqlite
//
//  Created by Student P_07 on 27/02/17.
//  Copyright © 2017 Rupali Pakale. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBManager : NSObject{
    NSString *strDBPath;
}
+(DBManager *)getInstance;
@property(nonatomic,strong)NSArray *array;
-(void)createDB;
-(BOOL)insertDataIntoDB:(NSString *)name alongwithaddress:(NSString *)address;
-(NSArray *)FetchFromDB;
-(BOOL)deleteWithId:(NSString *)studentID;
-(BOOL)UpdateWithId:(NSString *)studentID andName:(NSString *)newName andAddress:(NSString *)newAddress;

@end

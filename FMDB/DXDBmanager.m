//
//  DXDBmanager.m
//  FMDB
//
//  Created by 徐继垚 on 15/6/5.
//  Copyright (c) 2015年 徐继垚. All rights reserved.
//

#import "DXDBmanager.h"

static DXDBmanager * manager = nil;
@implementation DXDBmanager
+ (DXDBmanager *)shareManager
{
    static dispatch_once_t onceTocken;
    dispatch_once(&onceTocken, ^{
        manager = [[DXDBmanager alloc]init];
    });
    
    return manager;
    
    
}
- (void)createDB
{
    
    NSString * path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    path = [path stringByAppendingPathComponent:@"fmdb.db"];
    NSLog(@"%@", path);
   self.db = [FMDatabase databaseWithPath:path];
    
    if (![self.db open]) {
        NSLog(@"bunengdakai");
        return;
    }
}
- (void)createTable
{
    
    [self.db executeUpdate:@"CREATE TABLE PersonList (Name text, Age integer, Sex integer, Phone text, Address text, Photo blob)"];
    
    

    
    
    
    
    
}
-(void)addFileToDBWithData:(NSData *)data
{
    
    [self.db executeUpdate:@"INSERT INTO PersonList (Name, Age, Sex, Phone, Address, Photo) VALUES (?,?,?,?,?,?)",@"王丽坤", [NSNumber numberWithInt:20], [NSNumber numberWithInt:0], @"091234567", @"Taiwan, R.O.C", data];
}
-(NSMutableArray*)searchFromDB
{
    FMResultSet *rs = [self.db executeQuery:@"select * from PersonList"];
    NSMutableArray * array = [NSMutableArray array];

    while ([rs next]) {
        Person * model = [[Person alloc]init];
       model.name = [rs stringForColumn:@"Name"];
        model.age = [rs intForColumn:@"age"];
   
        
        model.imagedata = [rs dataForColumn:@"Photo"];
    
        [array addObject:model];
    }
    
    [rs close];
    return array;
}
@end

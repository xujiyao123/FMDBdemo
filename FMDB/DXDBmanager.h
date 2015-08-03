//
//  DXDBmanager.h
//  FMDB
//
//  Created by 徐继垚 on 15/6/5.
//  Copyright (c) 2015年 徐继垚. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDatabase.h>
#import "Person.h"
@interface DXDBmanager : NSObject
@property(nonatomic ,retain) FMDatabase * db;
+ (DXDBmanager *)shareManager;

- (void)createDB;
- (void)createTable;

- (void)addFileToDBWithData:(NSData *)data;

- (NSMutableArray *)searchFromDB;
@end

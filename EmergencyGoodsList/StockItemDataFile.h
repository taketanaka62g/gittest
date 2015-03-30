//
//  StockItemDataFile.h
//  EmergencyGoodsList
//
//  Created by 田中 武則2 on 2014/01/18.
//  Copyright (c) 2014年 takenori tanaka. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StockItemDataFile : NSObject
{
    NSArray* _stockItems;
}

- (void)load;
- (BOOL)save;
- (NSMutableArray*)getStockItems;
- (void)setStockItems:(NSMutableArray*)newStockItems;

@end

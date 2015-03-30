//
//  AppDelegate.h
//  EmergencyGoodsList
//
//  Created by 田中 武則2 on 2013/12/03.
//  Copyright (c) 2013年 takenori tanaka. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StockItemDataFile.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) StockItemDataFile* _stockItems;
@end

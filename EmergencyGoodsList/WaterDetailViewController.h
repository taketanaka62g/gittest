//
//  WaterDetailViewController.h
//  EmergencyGoodsList
//
//  Created by 田中 武則2 on 2013/12/04.
//  Copyright (c) 2013年 takenori tanaka. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WaterDetailViewController : UITableViewController<UITableViewDataSource, UIPickerViewDelegate,UITextFieldDelegate>

@property(strong,nonatomic)NSMutableDictionary *dataDic;
@property(strong,nonatomic)NSArray *titles;
@property(strong,nonatomic)NSArray *bulks;

- (id)init;
- (IBAction)backTo:(UIBarButtonItem *)sender;

@end

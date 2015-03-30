//
//  StockItemDataFile.m
//  EmergencyGoodsList
//
//  Created by 田中 武則2 on 2014/01/18.
//  Copyright (c) 2014年 takenori tanaka. All rights reserved.
//

#import "StockItemDataFile.h"

@implementation StockItemDataFile
NSString*const EGStockItems = @"EGStockItems.plist";

- (NSString*)stockFilePath
{
    //  Sandboxのドキュメントディレクトリを指定する。
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *directoryPath = [paths lastObject];
    printf("[Document directory path]\n%s\n\n", [directoryPath fileSystemRepresentation]);    //  成績保存ファイルまでのフルパスを得るためにコンソールに出力させている。
    //  Sandboxのドキュメントディレクトリ直下にあるMBGameRecordsという名前のファイルへのファイルパスを作成。
    NSString* path = [directoryPath stringByAppendingPathComponent:EGStockItems];
    return path;
}

- (void)load
{
    //NSString* path = [NSFileManager defaultManager].currentDirectoryPath;
    //path = [path stringByAppendingPathComponent:EGStockItems];
    
    NSData* data = [NSData dataWithContentsOfFile:[self stockFilePath]];
    if (data != nil) {
        NSPropertyListFormat format = NSPropertyListXMLFormat_v1_0;
        NSError* error = nil;
        _stockItems = [NSPropertyListSerialization propertyListWithData:data
            options:NSPropertyListImmutable format:&format error:&error];
        if (_stockItems == nil) {
            NSLog(@"NSPropertyListSerialization：EGStoclIems読み込みエラー　%@", [error localizedDescription]);
        }
    }
}

- (BOOL)save
{
    NSError* error = nil;
    NSData* plistData = [NSPropertyListSerialization dataWithPropertyList:_stockItems
        format:NSPropertyListXMLFormat_v1_0 options:NSPropertyListImmutable error:&error];
    if (plistData == nil) {
        NSLog(@"NSPropertyListSerialization：書き出し失敗 %@", [error localizedDescription]);
        return NO;
    }
    BOOL rc = [plistData writeToFile:[self stockFilePath] atomically:YES];
    return rc;
}

- (NSArray*)getStockItems
{
    if (_stockItems == nil) {
        // 初期値設定
        //NSDictionary* water = @{@"code":@"Water",@"status":@"ON"};
        NSMutableDictionary *water = [NSMutableDictionary dictionary];
        [water setObject:@"Water" forKey:@"code"];
        [water setObject:@"OFF" forKey:@"status"];
        //NSDictionary* dietary = @{@"code":@"Dietary",@"status":@"OFF"};
        NSMutableDictionary *dietary = [NSMutableDictionary dictionary];
        [dietary setObject:@"Dietary" forKey:@"code"];
        [dietary setObject:@"OFF" forKey:@"status"];
        //NSDictionary* helmet = @{@"code":@"Helmet",@"status":@"OFF"};
        NSMutableDictionary *helmet = [NSMutableDictionary dictionary];
        [helmet setObject:@"Helmet" forKey:@"code"];
        [helmet setObject:@"OFF" forKey:@"status"];
        //NSDictionary* mask = @{@"code":@"Mask",@"status":@"OFF"};
        NSMutableDictionary *mask = [NSMutableDictionary dictionary];
        [mask setObject:@"Mask" forKey:@"code"];
        [mask setObject:@"OFF" forKey:@"status"];
        //NSDictionary* glasses = @{@"code":@"Glasses",@"status":@"OFF"};
        NSMutableDictionary *glasses = [NSMutableDictionary dictionary];
        [glasses setObject:@"Glasses" forKey:@"code"];
        [glasses setObject:@"OFF" forKey:@"status"];
        //NSDictionary* contactlens = @{@"code":@"ContactLens", @"status":@"OFF"};
        NSMutableDictionary *contactlens = [NSMutableDictionary dictionary];
        [contactlens setObject:@"ContactLens" forKey:@"code"];
        [contactlens setObject:@"OFF" forKey:@"status"];
        //NSDictionary* raingear = @{@"code":@"RainGear",@"status":@"OFF"};
        NSMutableDictionary *raingear = [NSMutableDictionary dictionary];
        [raingear setObject:@"RainGear" forKey:@"code"];
        [raingear setObject:@"OFF" forKey:@"status"];
        //NSDictionary* underwear = @{@"code":@"Underwear",@"status":@"OFF"};
        NSMutableDictionary *underwear = [NSMutableDictionary dictionary];
        [underwear setObject:@"Underwear" forKey:@"code"];
        [underwear setObject:@"OFF" forKey:@"status"];
        //NSDictionary* tissue = @{@"code":@"Tissue",@"status":@"ON"};
        NSMutableDictionary *tissue = [NSMutableDictionary dictionary];
        [tissue setObject:@"Tissue" forKey:@"code"];
        [tissue setObject:@"OFF" forKey:@"status"];
        //NSDictionary* sanitarygoods = @{@"code":@"SanitaryGoods",@"status":@"OFF"};
        NSMutableDictionary *sanitarygoods = [NSMutableDictionary dictionary];
        [sanitarygoods setObject:@"SanitaryGoods" forKey:@"code"];
        [sanitarygoods setObject:@"OFF" forKey:@"status"];
        //NSDictionary* nappy = @{@"code":@"Nappy",@"status":@"OFF"};
        NSMutableDictionary *nappy = [NSMutableDictionary dictionary];
        [nappy setObject:@"Nappy" forKey:@"code"];
        [nappy setObject:@"OFF" forKey:@"status"];
        //NSDictionary* radio = @{@"code":@"Radio",@"status":@"OFF"};
        NSMutableDictionary *radio = [NSMutableDictionary dictionary];
        [radio setObject:@"Radio" forKey:@"code"];
        [radio setObject:@"OFF" forKey:@"status"];
        //NSDictionary* flashlight = @{@"code":@"FlashLight",@"status":@"OFF"};
        NSMutableDictionary *flashlight = [NSMutableDictionary dictionary];
        [flashlight setObject:@"FlashLight" forKey:@"code"];
        [flashlight setObject:@"OFF" forKey:@"status"];
        //NSDictionary* drycell = @{@"code":@"DryCell",@"status":@"OFF"};
        NSMutableDictionary *drycell = [NSMutableDictionary dictionary];
        [drycell setObject:@"DryCell" forKey:@"code"];
        [drycell setObject:@"OFF" forKey:@"status"];
        //NSDictionary* butterycharger = @{@"code":@"ButteryCharger",@"status":@"OFF"};
        NSMutableDictionary *butterycharger = [NSMutableDictionary dictionary];
        [butterycharger setObject:@"ButteryCharger" forKey:@"code"];
        [butterycharger setObject:@"OFF" forKey:@"status"];
        //NSDictionary* plasticbag = @{@"code":@"PlasticBag",@"status":@"OFF"};
        NSMutableDictionary *plasticbag = [NSMutableDictionary dictionary];
        [plasticbag setObject:@"PlasticBag" forKey:@"code"];
        [plasticbag setObject:@"OFF" forKey:@"status"];
        //NSDictionary* sheet = @{@"code":@"Sheet",@"status":@"OFF"};
        NSMutableDictionary *sheet = [NSMutableDictionary dictionary];
        [sheet setObject:@"Sheet" forKey:@"code"];
        [sheet setObject:@"OFF" forKey:@"status"];
        //NSDictionary* rope = @{@"code":@"Rope",@"status":@"OFF"};
        NSMutableDictionary *rope = [NSMutableDictionary dictionary];
        [rope setObject:@"Rope" forKey:@"code"];
        [rope setObject:@"OFF" forKey:@"status"];
        //NSDictionary* gloves = @{@"code":@"Gloves",@"status":@"OFF"};
        NSMutableDictionary *gloves = [NSMutableDictionary dictionary];
        [gloves setObject:@"Gloves" forKey:@"code"];
        [gloves setObject:@"OFF" forKey:@"status"];
        //NSDictionary* officinaldrugs = @{@"code":@"OfficinalDrugs",@"status":@"OFF"};
        NSMutableDictionary *officinaldrugs = [NSMutableDictionary dictionary];
        [officinaldrugs setObject:@"OfficinalDrugs" forKey:@"code"];
        [officinaldrugs setObject:@"OFF" forKey:@"status"];
        //NSDictionary* rescuemedicaiton = @{@"code":@"RescueMedication",@"status":@"OFF"};
        NSMutableDictionary *rescuemedication = [NSMutableDictionary dictionary];
        [rescuemedication setObject:@"RescueMedication" forKey:@"code"];
        [rescuemedication setObject:@"OFF" forKey:@"status"];
        //NSDictionary* wettissue = @{@"code":@"WetTissue",@"status":@"OFF"};
        NSMutableDictionary *wettissue = [NSMutableDictionary dictionary];
        [wettissue setObject:@"WetTissue" forKey:@"code"];
        [wettissue setObject:@"OFF" forKey:@"status"];
        //NSDictionary* money = @{@"code":@"Money",@"status":@"OFF"};
        NSMutableDictionary *money = [NSMutableDictionary dictionary];
        [money setObject:@"Money" forKey:@"code"];
        [money setObject:@"OFF" forKey:@"status"];
        //NSDictionary* healthinsurancecard = @{@"code":@"HealthInsuranceCard",@"status":@"OFF"};
        NSMutableDictionary *healthinsurancecard = [NSMutableDictionary dictionary];
        [healthinsurancecard setObject:@"HealthInsuranceCard" forKey:@"code"];
        [healthinsurancecard setObject:@"OFF" forKey:@"status"];
        //NSDictionary* bankpassbook = @{@"code":@"BankPassbook",@"status":@"ON"};
        NSMutableDictionary *bankpassbook = [NSMutableDictionary dictionary];
        [bankpassbook setObject:@"BankPassbook" forKey:@"code"];
        [bankpassbook setObject:@"OFF" forKey:@"status"];
        
        //NSMutableDictionary *stockdummy = [NSMutableDictionary dictionary];
        //[stockdummy setObject:@"dummy" forKey:@"code"];
        //[stockdummy setObject:@"dummy" forKey:@"Title"];
        //[stockdummy setObject:@"dummy" forKey:@"Bulk"];
        //[stockdummy setObject:@"dummy" forKey:@"ExpirationDate"];
        //[stockdummy setObject:@"dummy" forKey:@"Reposotpry"];

//        _stockItems = [NSArray array];
        NSArray *check = @[water,dietary,helmet,mask,glasses,contactlens,raingear,underwear,tissue,sanitarygoods,nappy,radio,flashlight,drycell,butterycharger,plasticbag,sheet,rope,gloves,officinaldrugs,rescuemedication,wettissue,money,healthinsurancecard,bankpassbook];
        NSMutableArray * ma1 = [NSMutableArray array];
        NSMutableArray * ma2 = [NSMutableArray array];
        NSMutableArray * ma3 = [NSMutableArray array];
        NSMutableArray * ma4 = [NSMutableArray array];
        NSMutableArray *stock = [NSMutableArray arrayWithArray:@[@{@"Water":ma1,
                                                                   @"Food1":ma2,
                                                                   @"Food2":ma3,
                                                                   @"Food3":ma4
                                                                   }]];
  
        NSMutableDictionary *cl = [NSMutableDictionary dictionary];
        NSMutableDictionary *sl = [NSMutableDictionary dictionary];
        [cl setObject:check forKey:@"CheckList"];  // 非常持出品のチェックリスト
        [sl setObject:stock forKey:@"StockList"];  // 備蓄品のリスト
        _stockItems = @[cl,sl];
    }
    return _stockItems;
}

- (void)setStockItems:(NSArray *)newStockItems
{
    _stockItems = newStockItems;
}
@end

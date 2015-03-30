//
//  FirstViewController.m
//  EmergencyGoodsList
//
//  Created by 田中 武則2 on 2013/12/03.
//  Copyright (c) 2013年 takenori tanaka. All rights reserved.
//
#import "AppDelegate.h"
#import "FirstViewController.h"

@interface FirstViewController ()
{
    NSArray *tableDataList;
    NSString *p;
    NSArray* stockItems;
}

@end

@implementation FirstViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self loadItemListFile];
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    stockItems = [appDelegate._stockItems getStockItems];
    
}
-(void)loadItemListFile
{
    p = [[NSBundle mainBundle] pathForResource:@"List1" ofType:@"plist"];
    tableDataList = [NSArray arrayWithContentsOfFile:p];
    
    //NSSortDescriptor *sortDescString;
    //sortDescString = [[NSSortDescriptor alloc] initWithKey:@"code" ascending:YES];
    
    // NSSortDescriptorは配列に入れてNSArrayに渡す
    //NSArray *sortDescArray;
    //sortDescArray = [NSArray arrayWithObjects:sortDescString, nil];
    
    // ソートの実行
    //NSArray *sortArray;
    //tableDataList = [tableDataList sortedArrayUsingDescriptors:sortDescArray];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)prefersStatusBarHidden {
    return YES;
}
-(id)init{
	self = [super initWithStyle:UITableViewStyleGrouped];
	if (self) {self.title = @"非常持出品リスト";}
	return self;
}

//グループの数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return tableDataList.count;
}

//セクションあたりの行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSDictionary *sec = tableDataList[section];
    NSArray *sectionData = sec[@"data"];
    return sectionData.count;
}
//セクションタイトル
- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSDictionary *sec = tableDataList[section];
    return sec[@"header"];
}
//セクションフッター
- (NSString*)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    return @"";
}

//セクションあたりの行の高さ
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath {
    return 44.0f;
}
- (void)tapSwitch:(UISwitch *)sw
{
    NSMutableDictionary *dic0 = stockItems[0];
    NSArray *array = dic0[@"CheckList"];
    NSMutableDictionary *dic = array[sw.tag];
    [dic setObject:@"ON" forKey:@"status"];
    
}
//セルを生成する
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	int section = [indexPath section];
	UITableViewCell *cell;
    
    NSDictionary *sec = tableDataList[section];
    NSArray *sectionData = sec[@"data"];
    NSDictionary *cellData = sectionData[indexPath.row];

	NSString *CellIdentifier = @"Cell";
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    // スイッチを作成して、tableCellに載せる。
    NSMutableDictionary *dic0 = stockItems[0];
    NSArray *array = dic0[@"CheckList"];
    int index = [[array valueForKeyPath:@"code"] indexOfObject:cellData[@"code"]];
    NSMutableDictionary *dic = array[index];
    NSString *status = dic[@"status"];
    
    UISwitch *sw = [[UISwitch alloc] initWithFrame:CGRectZero];
    [sw addTarget:self action:@selector(tapSwitch:) forControlEvents:UIControlEventTouchUpInside];
    sw.tag = index;
    if ([status compare:@"ON"] == 0) {
        sw.on = true;
    }
    cell.accessoryView = sw;
    //cell.detailTextLabel.text = @"";
    cell.imageView.image = nil;

    cell.textLabel.text = cellData[@"item"];
    cell.detailTextLabel.text = cellData[@"detail"];
    NSString * img = cellData[@"image"];
    if ([img length] > 0)
        cell.imageView.image = [UIImage imageNamed:cellData[@"image"]];
    return cell;
}

//キーボードの消去
-(BOOL)textFieldShouldReturn:(UITextField*)textField{
	[textField resignFirstResponder];
	return YES;
}

//セル選択時の応答処理
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	//省略
}

@end

//
//  SecondViewController.m
//  EmergencyGoodsList
//
//  Created by 田中 武則2 on 2013/12/03.
//  Copyright (c) 2013年 takenori tanaka. All rights reserved.
//
#import "AppDelegate.h"

#import "SecondViewController.h"
#import "DetailViewController.h"
#import "ItemsListViewController.h"
#import "WaterDetailViewController.h"

@interface SecondViewController ()
{
    NSArray *tableDataList;
    NSString *p;
    NSMutableArray* stockItems;
}
@end

@implementation SecondViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self loadListFile];
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    stockItems = [appDelegate._stockItems getStockItems];

}
-(void)loadListFile
{
    p = [[NSBundle mainBundle] pathForResource:@"List2" ofType:@"plist"];
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
	if (self) {self.title = @"備蓄品リスト";}
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

//セルを生成する
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	int section = [indexPath section];
	UITableViewCell *cell;
	NSString *CellIdentifier = @"Cell";
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.detailTextLabel.text = @"";
    
    NSDictionary *sec = tableDataList[section];
    NSArray *sectionData = sec[@"data"];
    NSDictionary *cellData = sectionData[indexPath.row];
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
    if (indexPath.row == 0)
    {
        ItemsListViewController *listView = [self.storyboard instantiateViewControllerWithIdentifier:@"ItemsList"];
        listView.title = @"水のリスト";
        listView.listName = @"Water";
        [self.navigationController pushViewController:listView animated:YES];
    }
    else if (indexPath.row == 1)
    {
        ItemsListViewController *listView = [self.storyboard instantiateViewControllerWithIdentifier:@"ItemsList"];
        listView.title = @"食品(主食)のリスト";
        listView.listName = @"Food1";
        [self.navigationController pushViewController:listView animated:YES];
    }
    else if (indexPath.row == 2)
    {
        ItemsListViewController *listView = [self.storyboard instantiateViewControllerWithIdentifier:@"ItemsList"];
        listView.title = @"食品(副食)のリスト";
        listView.listName = @"Food2";
        [self.navigationController pushViewController:listView animated:YES];
    }
    else if (indexPath.row == 3)
    {
        ItemsListViewController *listView = [self.storyboard instantiateViewControllerWithIdentifier:@"ItemsList"];
        listView.title = @"食品(デザート)のリスト";
        listView.listName = @"Food3";
        [self.navigationController pushViewController:listView animated:YES];
    }
}
@end

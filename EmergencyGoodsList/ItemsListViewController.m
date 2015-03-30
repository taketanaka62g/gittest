//
//  ItemsListViewController.m
//  EmergencyGoodsList
//
//  Created by 田中 武則2 on 2014/01/17.
//  Copyright (c) 2014年 takenori tanaka. All rights reserved.
//

#import "AppDelegate.h"
#import "ItemsListViewController.h"
#import "WaterDetailViewController.h"
@interface ItemsListViewController ()
{
    NSMutableArray *objects;
    NSArray* stockItems;
}
@end

@implementation ItemsListViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //UIBarButtonItem *addButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    //self.navigationItem.rightBarButtonItem = addButton;

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    stockItems = [appDelegate._stockItems getStockItems];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSMutableArray*)dataArray
{
    NSMutableDictionary *dic0 = stockItems[1];
    NSArray *array = dic0[@"StockList"];
    NSMutableDictionary *water = array[0];
    return water[self.listName];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self dataArray].count;
}
//セクションあたりの行の高さ
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath {
    return 44.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    if (cell == nil) cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    NSArray *w = [self dataArray];
    NSMutableDictionary *dic = w[indexPath.row];

    cell.textLabel.text = dic[@"Title"];
    cell.detailTextLabel.text = dic[@"Bulk"];

    return cell;
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [[self dataArray] removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */
- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];
    if (editing) { // 現在編集モードです。
        UIBarButtonItem *addButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
        [self.navigationItem setLeftBarButtonItem:addButton animated:YES]; // 追加ボタンを表示します。
    } else { // 現在通常モードです。
        [self.navigationItem setLeftBarButtonItem:nil animated:YES]; // 追加ボタンを非表示にします。
    }
}

- (IBAction)backTo:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)insertNewObject:(id)sender
{
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    df.dateFormat = @"yyyy/MM/dd";
    
    // ログに日付を表示
    NSString *today = [df stringFromDate:[NSDate date]];
    // 初期データ生成
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:self.listName forKey:@"code"];
    if ([self.listName compare:@"Water"] == 0)
    {
        [dic setObject:@"ペットボトル" forKey:@"Title"];
        [dic setObject:@"500mℓ" forKey:@"Bulk"];
        [dic setObject:@"" forKey:@"Quantity"];
        [dic setObject:today forKey:@"ExpirationDate"];
        [dic setObject:@"" forKey:@"Repository"];
    }
    else if ([self.listName compare:@"Food1"] == 0)
    {
        [dic setObject:@"乾パン" forKey:@"Title"];
        [dic setObject:@"100g" forKey:@"Bulk"];
        [dic setObject:@"" forKey:@"Quantity"];
        [dic setObject:today forKey:@"ExpirationDate"];
        [dic setObject:@"" forKey:@"Repository"];
    }
    else if ([self.listName compare:@"Food2"] == 0)
    {
        [dic setObject:@"さば味噌煮缶" forKey:@"Title"];
        [dic setObject:@"150g" forKey:@"Bulk"];
        [dic setObject:@"" forKey:@"Quantity"];
        [dic setObject:today forKey:@"ExpirationDate"];
        [dic setObject:@"" forKey:@"Repository"];
    }
    else if ([self.listName compare:@"Food3"] == 0)
    {
        [dic setObject:@"みつ豆缶" forKey:@"Title"];
        [dic setObject:@"190g" forKey:@"Bulk"];
        [dic setObject:@"" forKey:@"Quantity"];
        [dic setObject:today forKey:@"ExpirationDate"];
        [dic setObject:@"" forKey:@"Repository"];
    }
    NSMutableArray *ary = [self dataArray];
    [ary insertObject:dic atIndex:0];

    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

//セル選択時の応答処理
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    WaterDetailViewController *wd = [self.storyboard instantiateViewControllerWithIdentifier:@"WaterDetailView"];
    if ([self.listName compare:@"Water"] == 0)
    {
        wd.title = @"詳細情報";
        wd.dataDic = [self dataArray][indexPath.row];
        wd.titles = @[@"ペットボトル",@"缶",@"その他"];
        wd.bulks = @[@"250mℓ",@"300mℓ",@"350mℓ",@"500mℓ",@"1ℓ",@"1.5ℓ",@"2ℓ",@"その他"];
        [self.navigationController pushViewController:wd animated:YES];
    }
    else if ([self.listName compare:@"Food1"] == 0)
    {
        wd.title = @"詳細情報";
        wd.dataDic = [self dataArray][indexPath.row];
        wd.titles = @[@"乾パン",@"白飯",@"赤飯",@"五目ご飯",@"とり飯",@"山菜ご飯",@"白粥",@"パン缶",@"クラッカー"];
        wd.bulks = @[@"100g",@"120g",@"150g",@"180g",@"190g",@"200g",@"220g",@"250g",@"280g",@"300g"];
        [self.navigationController pushViewController:wd animated:YES];
    }
    else if ([self.listName compare:@"Food2"] == 0)
    {
        wd.title = @"詳細情報";
        wd.dataDic = [self dataArray][indexPath.row];
        wd.titles = @[@"鯖味噌煮缶",@"さけ水煮",@"ポテトサラダ",@"まぐろフレーク",@"まめ昆布煮",@"牛肉大和煮",@"やきとり缶"];
        wd.bulks = @[@"100g",@"120g",@"150g",@"180g",@"190g",@"200g",@"220g",@"250g",@"280g",@"300g"];
        [self.navigationController pushViewController:wd animated:YES];
    }
}
- (void)viewWillAppear:(BOOL)animated
{
    [self.tableView reloadData];
}
@end

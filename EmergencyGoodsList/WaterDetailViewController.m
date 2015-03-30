//
//  WaterDetailViewController.m
//  EmergencyGoodsList
//
//  Created by 田中 武則2 on 2013/12/04.
//  Copyright (c) 2013年 takenori tanaka. All rights reserved.
//

#import "WaterDetailViewController.h"
#import "TextFieldTableCell.h"
#import "DatePickerTableCell.h"
#import "PickerTableCell.h"
@interface WaterDetailViewController ()

@end

@implementation WaterDetailViewController
@synthesize dataDic;

//TextFieldTableCell *nameCell;
TextFieldTableCell *quantityCell;
TextFieldTableCell *repositoryCell;
DatePickerTableCell * dateCell;
bool showDatePicker = false;
bool showTitlePicker = false;
bool showBulkPicker = false;

PickerTableCell *titlePicker;
PickerTableCell *bulkPicker;
PickerTableCell *qtyPicker;
NSString *expiration;
NSString *title;
//NSArray * titles;
NSString *bulk;
//NSArray *bulklist;

- (id)init
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        // ・・・・
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 数量入力用Cellの初期化
    if (quantityCell == nil) {
        quantityCell = [[TextFieldTableCell alloc] initWithFrame:CGRectZero];
    }
    quantityCell.textField.textAlignment = NSTextAlignmentRight;
    [quantityCell.textField setPlaceholder:@"数量"];
    // NSDictionaryからデータを取り出してセットする
    NSString *quantity = dataDic[@"Quantity"];
    if (quantity != nil && [quantity compare:@""] != 0) {
        quantityCell.textField.text = quantity;
    }
    // 保管場所の入力用Cellの初期化
    if (repositoryCell == nil) {
        repositoryCell = [[TextFieldTableCell alloc] initWithFrame:CGRectZero];
    }
    [repositoryCell.textField setPlaceholder:@"保管場所"];
    NSString *repository = dataDic[@"Repository"];
    if (repository != nil && [repository compare:@""] != 0) {
        repositoryCell.textField.text = repository;
    }
    // 消費期限用Cellの初期化
    if (dateCell == nil) {
        dateCell = [[DatePickerTableCell alloc] initWithFrame:CGRectZero];
    }
    [dateCell.picker setDate:[NSDate date]];
    [dateCell.picker addTarget:self action:@selector(datePicker_ValueChanged:)forControlEvents:UIControlEventValueChanged];
    
    NSString *exp = dataDic[@"ExpirationDate"];
    if (exp == nil || [exp compare:@""] == 0)
    {
        expiration = [self expirationDate:dateCell.picker];
    }
    else
    {
        expiration = exp;
    }
    // 名前用Cellの初期化
    if (titlePicker == nil) {
        titlePicker = [[PickerTableCell alloc] initWithFrame:CGRectZero];
    }
    [titlePicker.picker setTag:1];
    titlePicker.picker.delegate = self;
    //title = titles[ [titlePicker.picker selectedRowInComponent:0]];
    title = dataDic[@"Title"];
    // 容量用Cellの初期化
    if (bulkPicker == nil) {
        bulkPicker = [[PickerTableCell alloc] initWithFrame:CGRectZero];
    }
    [bulkPicker.picker setTag:2];
    bulkPicker.picker.delegate = self;
    //bulk = bulklist[ [bulkPicker.picker selectedRowInComponent:0]];
    bulk = dataDic[@"Bulk"];
    
    // 入力用キーボードに閉じるボタンを追加する
    UIView* accessoryView = [[UIView alloc] initWithFrame:CGRectMake(0,0,320,50)];
    accessoryView.backgroundColor = [UIColor lightGrayColor];
    
    // ボタンを作成する。
    UIButton* closeButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    closeButton.frame = CGRectMake(210,10,100,30);
    [closeButton setTitle:@"閉じる" forState:UIControlStateNormal];
    // ボタンを押したときによばれる動作を設定する。
    [closeButton addTarget:self action:@selector(closeKeyboard:) forControlEvents:UIControlEventTouchUpInside];
    // ボタンをViewに貼る
    [accessoryView addSubview:closeButton];
    repositoryCell.textField.delegate = self;
    repositoryCell.textField.inputAccessoryView = accessoryView;
    repositoryCell.textField.keyboardType = UIKeyboardTypeDefault;
    quantityCell.textField.delegate = self;
    quantityCell.textField.inputAccessoryView = accessoryView;
    quantityCell.textField.keyboardType = UIKeyboardTypeDecimalPad;
}
-(void)closeKeyboard:(id)sender{
    [repositoryCell.textField resignFirstResponder];
    [quantityCell.textField resignFirstResponder];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [dataDic setValue:title forKey:@"Title"];
    [dataDic setValue:bulk forKey:@"Bulk"];
    [dataDic setValue:quantityCell.textField.text forKey:@"Quantity"];
    [dataDic setValue:expiration forKey:@"ExpirationDate"];
    [dataDic setValue:repositoryCell.textField.text forKey:@"Repository"];
    
    [dateCell.picker removeTarget:self action:@selector(datePicker_ValueChanged:) forControlEvents:UIControlEventValueChanged];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    int count = 0;
    switch (section) {
        case 0:
            count = 5;
            break;
        case 1:
            count = 2;
            break;
        case 2:
            count = 1;
            break;
        default:
            break;
    }
    return count;
}

//行の高さ
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath {
    if (indexPath.section == 0 && indexPath.row == 1)
    {
        if (showTitlePicker) {
            return titlePicker.picker.frame.size.height;
        }
        else
        {
            return 0;
        }
    }
    else if (indexPath.section == 0 && indexPath.row == 3)
    {
        if (showBulkPicker) {
            return bulkPicker.picker.frame.size.height;
        }
        else
        {
            return 0;
        }
    }
    else if (indexPath.section == 0 && (indexPath.row == 0 || indexPath.row == 2 || indexPath.row == 4))
    {
        return 44.0f;
    }
    else if (indexPath.section == 1 && indexPath.row == 0)
    {
        return 44.0f;
    }
    else if (indexPath.section == 1 && indexPath.row == 1)
    {
        if (showDatePicker) {
            return dateCell.picker.frame.size.height;
        }
        else
        {
            return 0;
        }
    }
    else if (indexPath.section == 2 && indexPath.row == 0)
    {
        return 44.0f;
    }

    return 0;
}
//セクションタイトル
- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSString *title = @"";
    switch (section) {
        case 0:
            title = @"名前、容量、数量";
            break;
        case 1:
            title = @"消費期限";
            break;
        case 2:
            title = @"保管場所";
        default:
            break;
    }
    return title;
}
//セクションフッター
- (NSString*)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    return @"";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	int section = [indexPath section];
	UITableViewCell *cell;
    if (section == 0)
    {
        if (indexPath.row == 0 || indexPath.row == 2) {
            NSString *CellIdentifier = @"Cell";
            // Configure the cell...
            if (cell == nil) cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
            //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        switch (indexPath.row) {
            case 0: // 名前の表示
                if (title == nil) {
                    title = @"";
                }
                cell.textLabel.text = title;
                break;
            case 1: // 名前の選択用picker
                cell = titlePicker;
                break;
            case 2: // 容量の表示
                if (bulk == nil) {
                    bulk = @"";
                }
                cell.textLabel.text = bulk;
                break;
            case 3: // 容量の選択Picker
                cell = bulkPicker;
                break;
            case 4: // 数量の入力
                cell = quantityCell;
                break;
            default:
                break;
        }
    }
    else if (section == 1)
    {
        if (indexPath.row == 1) {
            cell = dateCell;    // 消費期限日付の選択
        }
        else
        {
            // 消費期限の表示
            NSString *CellIdentifier = @"Cell";
            // Configure the cell...
            if (cell == nil) cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            if (expiration == nil) {
                expiration = @"";
            }
            cell.textLabel.text = expiration;
            //UIButton *btn = [[UIButton alloc] initWithFrame:CGRectZero];
            //btn.titleLabel.text = @"カレンダーに追加";
            UISwitch *sw = [[UISwitch alloc]initWithFrame:CGRectZero];
            
            cell.accessoryView = sw;
            
        }
    }
    else if (section == 2)
    {
        cell = repositoryCell;  // 保管場所の入力用
    }
    return cell;
}
//セル選択時の応答処理
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 0)
    {
        if (showTitlePicker)
        {
            showTitlePicker = false;
        }
        else
        {
            showTitlePicker = true;
        }
        [tableView reloadData];
    }
    else if (indexPath.section == 0 && indexPath.row == 2)
    {
        if (showBulkPicker)
        {
            showBulkPicker = false;
        }
        else
        {
            showBulkPicker = true;
        }
        [tableView reloadData];
    }
    else if (indexPath.section == 1 && indexPath.row == 0)
    {
        if (showDatePicker)
        {
            showDatePicker = false;
        }
        else
        {
            showDatePicker = true;
        }
        [tableView reloadData];
    }
}


//日付ピッカーの値が変更されたとき
- (void)datePicker_ValueChanged:(id)sender
{
    UIDatePicker *datePicker = sender;
    
    expiration = [self expirationDate:datePicker];
    [self.tableView reloadData];
}

- (NSString*)expirationDate:(UIDatePicker*)datePicker
{
    // 日付の表示形式を設定
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    df.dateFormat = @"yyyy/MM/dd";
    
    // ログに日付を表示
    return [df stringFromDate:datePicker.date];
}

//以下はPickerViewのDelegate
//区切りの数（コンポーネント）
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

//コンポーネントの行数を返す
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
        switch (component) {
            case 0:
                if (pickerView.tag == 1) {
                    return self.titles.count;
                }
                else
                {
                    return self.bulks.count;
                }
                break;
            default:
                return 0;
                break;
        }
    return 0;
}
- (UIView *)pickerView:(UIPickerView *)pickerView
            viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UILabel *retval = (id)view;
    if (!retval) {
        retval= [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [pickerView rowSizeForComponent:component].width, [pickerView rowSizeForComponent:component].height)];
    }
    if (pickerView.tag == 1) {
        retval.text = [self.titles objectAtIndex:row];
    }
    else
    {
        retval.text = [self.bulks objectAtIndex:row];
    }
    // フォントサイズを設定する
    if ([retval.text length] > 20) {
        retval.font = [UIFont systemFontOfSize:10];
    }
    else if ([retval.text length] > 16) {
        retval.font = [UIFont systemFontOfSize:12];
    }
    else if ([retval.text length] > 12) {
        retval.font = [UIFont systemFontOfSize:16];
    }
    else {
        retval.font = [UIFont systemFontOfSize:20];
    }
    
    return retval;
}
// Pickerに表示する文字列を返す
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    switch (component) {
        case 0:
            if (pickerView.tag == 1) {
                return [self.titles objectAtIndex:row];
            }
            else
            {
                return [self.bulks objectAtIndex:row];
            }
            break;
        default:
            break;
    }
    return @"";
}

//選択完了時に呼ばれる
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (pickerView.tag == 1) {
        title = [self.titles objectAtIndex:row];
    }
    else
    {
        bulk = [self.bulks objectAtIndex:row];
    }
    [self.tableView reloadData];
}

- (IBAction)backTo:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end

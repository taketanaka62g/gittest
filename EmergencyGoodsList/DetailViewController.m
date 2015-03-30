//
//  DetailViewController.m
//  EmergencyGoodsList
//
//  Created by 田中 武則2 on 2013/12/04.
//  Copyright (c) 2013年 takenori tanaka. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController
{
    UIToolbar *toolbar;
    UIView  *view;
    //UIButton *button;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        view = [[UIView alloc] initWithFrame:CGRectMake(0,0,320,589)];
        view.backgroundColor = [UIColor whiteColor];
        toolbar = [ [ UIToolbar alloc ] initWithFrame:CGRectMake( 0, 0, 320, 44 ) ];
        toolbar.barStyle = UIBarStyleDefault;
        UIBarButtonItem * btn1 = [ [ UIBarButtonItem alloc ] initWithTitle:@"戻る" style:UIBarButtonItemStyleBordered target:self action:@selector( onTapTest: ) ];
        // ボタン配列をツールバーに設定する
        toolbar.items = [ NSArray arrayWithObjects:btn1, nil ];
    }
    return self;
}
- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [view addSubview:toolbar];
    [self.view addSubview:view];
}
- ( void )onTapTest:( id )inSender
{
	// ボタンを押された時の処理をここに追加
    [self dismissViewControllerAnimated:YES completion:nil];
	return;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

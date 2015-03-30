//
//  PickerTableCell.m
//  EmergencyGoodsList
//
//  Created by 田中 武則2 on 2014/01/21.
//  Copyright (c) 2014年 takenori tanaka. All rights reserved.
//

#import "PickerTableCell.h"

@implementation PickerTableCell
@synthesize picker;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code

    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithFrame:frame reuseIdentifier:reuseIdentifier]) {
        // Initialization code
        self.picker = [[UIPickerView alloc] initWithFrame:frame];
        // テキストフィールドをテーブルビューセルに追加
        [self addSubview:self.picker];
    }
    return self;
}

- (void)layoutSubviews {
    // CGRectInset : 中央を固定し、オフセットでdx,dyを指定する
    // この場合もとのサイズよりも小さくなる
    self.picker.frame = CGRectInset(self.contentView.bounds, 20, 0);
}



@end

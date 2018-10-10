//
//  CodeInputView.m
//  LoadingView
//
//  Created by coolerting on 2018/8/8.
//  Copyright © 2018年 coolerting. All rights reserved.
//

#import "CodeInputView.h"
#import "CodeCollectionViewCell.h"
#import "CodeModel.h"

@interface CodeInputView()<UICollectionViewDelegate,UICollectionViewDataSource,UITextFieldDelegate>
@property(nonatomic,strong) UITextField *textField;
@property(nonatomic,strong) NSMutableArray *codeArray;
@property(nonatomic,strong) UICollectionView *collectionView;
@property(nonatomic,assign) CGFloat count;
@property(nonatomic,assign) NSInteger space;
@property(nonatomic,assign) CGFloat margin;
@end

@implementation CodeInputView

- (instancetype)initWithFrame:(CGRect)frame Space:(CGFloat)space Margin:(CGFloat)margin Count:(NSInteger)count
{
    self = [super initWithFrame:frame];
    if (self) {

        CGFloat height = (frame.size.width - margin * (count - 1) - 2 * space) / count;
        if (frame.size.height < height + margin * 2) {
            height = frame.size.height - margin * 2;
            space = (frame.size.width - height * count - margin * (count - 1)) / 2;
        }
        
        _count = count;
        _margin = margin;
        _space = space;
        
        self.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, height + 2 * margin);
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.itemSize = CGSizeMake(height, height);
        layout.sectionInset = UIEdgeInsetsMake(margin, space, margin, space);
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = margin;
        
        UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:layout];
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.backgroundColor = UIColor.whiteColor;
        [collectionView registerClass:[CodeCollectionViewCell class] forCellWithReuseIdentifier:@"codeCell"];
        [self addSubview:collectionView];
        _collectionView = collectionView;
        
        UITextField *textField = [[UITextField alloc]initWithFrame:CGRectZero];
        textField.keyboardType = UIKeyboardTypeNumberPad;
        [textField addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventEditingChanged];
        [self addSubview:textField];
        _textField = textField;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHiden:) name:UIKeyboardWillHideNotification object:nil];
        
        _codeArray = [NSMutableArray array];
        for (int i = 0; i < count; i ++) {
            CodeModel *model = [CodeModel mj_objectWithKeyValues:@{@"number":@"",
                                                                   @"isSelected":@(NO)
                                                                   }];
            [_codeArray addObject:model];
        }
    }
    return self;
}

- (void)keyboardWillBeHiden:(NSNotification *)noti
{
    for (CodeModel *model in _codeArray) {
        model.isSelected = NO;
    }
    [_collectionView reloadData];
}

- (void)valueChanged:(UITextField *)textField
{
    if (textField.text.length != 0) {
        NSString *lastCharacter = [textField.text substringWithRange:NSMakeRange(textField.text.length - 1, 1)];
        BOOL isNumber = [self isPureInt:lastCharacter];
        if (!isNumber) {
            textField.text = [textField.text substringToIndex:textField.text.length - 1];
            return;
        }
    }
    
    if (textField.text.length <= _count) {
        for (CodeModel *subModel in _codeArray) {
            subModel.number = @"";
            subModel.isSelected = NO;
        }
        for (int i = 0; i < textField.text.length; i++) {
            CodeModel *model = _codeArray[i];
            model.number = [textField.text substringWithRange:NSMakeRange(i, 1)];
            model.isSelected = NO;
        }
        [self reloadData];
    }
    else
    {
        textField.text = [textField.text substringToIndex:_count];
    }
    
    _numberText = textField.text;
    
    if (_numberText.length >= _count) {
        [self resignFirstResponder];
        if ([_delegate respondsToSelector:@selector(finishEnterCode:)]) {
            [_delegate finishEnterCode:_numberText];
        }
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _codeArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CodeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"codeCell" forIndexPath:indexPath];
    switch (_inputType) {
        case inputTypeNormal:
            cell.type = cellTypeNormal;
            break;
        case inputTypeSecurity:
            cell.type = cellTypeSecurity;
        default:
            break;
    }
    cell.model = _codeArray[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [_textField becomeFirstResponder];
    [self reloadData];
}

- (void)reloadData
{
    for (CodeModel *model in _codeArray) {
        if ([model.number isEqualToString:@""]) {
            model.isSelected = YES;
            break;
        }
    }
    [_collectionView reloadData];
}

- (BOOL)resignFirstResponder
{
    if (_numberText.length < _count) {
        return NO;
    }
    [_textField resignFirstResponder];
    return YES;
}

- (BOOL)isPureInt:(NSString *)string
{
    NSScanner *scan = [NSScanner scannerWithString:string];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}
@end

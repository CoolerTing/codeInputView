//
//  CodeCollectionViewCell.m
//  LoadingView
//
//  Created by coolerting on 2018/8/8.
//  Copyright © 2018年 coolerting. All rights reserved.
//

#import "CodeCollectionViewCell.h"

@interface CodeCollectionViewCell()
@property(nonatomic,strong) UILabel *codeLabel;
@property(nonatomic,strong) UIView *lineView;
@property(nonatomic,strong) UIView *securityPoint;
@property(nonatomic,strong) CABasicAnimation *animation;
@end

@implementation CodeCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UILabel *codeLabel = [[UILabel alloc]initWithFrame:self.contentView.bounds];
        codeLabel.textColor = UIColor.blackColor;
        codeLabel.textAlignment = NSTextAlignmentCenter;
        codeLabel.adjustsFontSizeToFitWidth = YES;
        codeLabel.layer.backgroundColor = UIColor.whiteColor.CGColor;
        codeLabel.layer.cornerRadius = frame.size.width / 10;
        codeLabel.layer.borderWidth = 1 / [UIScreen mainScreen].scale;
        codeLabel.layer.borderColor = UIColor.lightGrayColor.CGColor;
        [self.contentView addSubview:codeLabel];
        _codeLabel = codeLabel;
        
        UIView *securityPoint = [[UIView alloc]init];
        securityPoint.layer.backgroundColor = UIColor.darkGrayColor.CGColor;
        securityPoint.layer.cornerRadius = frame.size.width / 6;
        [self.contentView addSubview:securityPoint];
        _securityPoint = securityPoint;
        [securityPoint mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(CGPointZero);
            make.height.width.mas_equalTo(frame.size.width / 3);
        }];
        
        UIView *lineView = [[UIView alloc]init];
        lineView.layer.backgroundColor = UIColor.lightGrayColor.CGColor;
        lineView.layer.cornerRadius = 2 / [UIScreen mainScreen].scale;
        [self.contentView addSubview:lineView];
        _lineView = lineView;
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(CGPointZero);
            make.height.mas_equalTo(frame.size.height * 2 / 4);
            make.width.mas_equalTo(4 / [UIScreen mainScreen].scale);
        }];
        
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
        animation.duration = 0.5;
        animation.fromValue = @0;
        animation.toValue = @1;
        animation.repeatCount = MAXFLOAT;
        animation.autoreverses = YES;
        _animation = animation;
    }
    return self;
}

- (void)setModel:(CodeModel *)model
{
    _model = model;
    if (_type == cellTypeNormal) {
        _codeLabel.text = model.number;
        _securityPoint.hidden = YES;
    }
    else
    {
        if (![model.number isEqualToString:@""]) {
            _securityPoint.hidden = NO;
        }
        else
        {
            _securityPoint.hidden = YES;
        }
    }
    
    if (model.isSelected) {
        _lineView.hidden = NO;
        [_lineView.layer addAnimation:_animation forKey:@"animation"];
    }
    else
    {
        _lineView.hidden = YES;
        [_lineView.layer removeAllAnimations];
    }
}
@end

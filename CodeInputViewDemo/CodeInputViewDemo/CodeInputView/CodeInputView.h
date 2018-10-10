//
//  CodeInputView.h
//  LoadingView
//
//  Created by coolerting on 2018/8/8.
//  Copyright © 2018年 coolerting. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CodeInputViewDelegate <NSObject>

@optional
- (void)finishEnterCode:(NSString *)number;

@end

typedef NS_ENUM(NSUInteger, inputType) {
    inputTypeNormal = 0,
    inputTypeSecurity,
};

@interface CodeInputView : UIView

@property(nonatomic,assign) inputType inputType;
@property(nonatomic,copy,readonly) NSString *numberText;
@property (nonatomic,weak) id<CodeInputViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame Space:(CGFloat)space Margin:(CGFloat)margin Count:(NSInteger)count;
@end

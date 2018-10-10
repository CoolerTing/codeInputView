//
//  CodeCollectionViewCell.h
//  LoadingView
//
//  Created by coolerting on 2018/8/8.
//  Copyright © 2018年 coolerting. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CodeModel.h"

typedef NS_ENUM(NSUInteger, cellType) {
    cellTypeNormal = 0,
    cellTypeSecurity,
};

@interface CodeCollectionViewCell : UICollectionViewCell
@property(nonatomic,assign) cellType type;
@property(nonatomic,strong) CodeModel *model;
@end

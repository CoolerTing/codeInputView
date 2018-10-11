# codeInputView
类似支付密码输入框，可明文显示，可密文显示。
## 安装
将CodeInputView文件夹拖入项目中

PS：由于采用masonry布局，也使用了MJExtension，请保证项目中有masonry和MJExtension。
## 说明
项目中需要该功能，于是自己动手做了一个。

类似支付密码输入框，简单易用。

自动适配输入框大小。

输入完成自动收起键盘。

可根据需求修改代码。
## 示例
![downView](https://github.com/CoolerTing/codeInputView/blob/master/codeInputView.gif)
## 使用

```objective-c
#import "CodeInputView.h"
```
并遵循```CodeInputViewDelegate```
创建对象并设置代理
```objective-c
CodeInputView *view = [[CodeInputView alloc]initWithFrame:CGRectMake(0, 100, IPHONE_WIDTH, 60) Space:40 Margin:10 Count:6];
view.inputType = inputTypeSecurity;
view.delegate = self;
[self.view addSubview:view];
```
### delegate
```objective-c
- (void)finishEnterCode:(NSString *)number;
```
可选代理，在输入完成时触发代理

```objective-c
- (void)finishEnterCode:(NSString *)number
{
    NSLog(@"%@",number);
}
```

## 参数
* frame：控件的frame
* space：控件的头尾距父视图的间距
* margin：每一个输入框的间距
* count：输入框的个数

### 枚举
设置对象inputType
```objective-c
typedef NS_ENUM(NSUInteger, inputType) {
    inputTypeNormal = 0,//明文显示
    inputTypeSecurity,//密文显示
};
```

//
//  JHButton.h
//  JHButton
//
//  Created by iOS on 2018/3/3.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, JHImageButtonType){
    
    /**
     *  按钮图片居左 文案居右 可以影响父布局的大小
     */
    JHImageButtonTypeLeft = 0,
    
    /**
     *  按钮图片居右 文案居左 可以影响父布局的大小
     */
    JHImageButtonTypeRight,
    
    /**
     *  按钮图片居上 文案居下 可以影响父布局的大小
     */
    JHImageButtonTypeTop,
    
    /**
     *  按钮图片居下 文案居上 可以影响父布局的大小
     */
    JHImageButtonTypeBottom,
};

typedef NS_ENUM(NSInteger,JHButtonState) {
    /**
     *  按钮状态 正常
     */
    JHButtonStateNormal = 0,
    
    /**
     *  按钮状态 高亮
     */
    JHButtonStateHighLight,
    /**
     *  按钮状态 选中
     */
    JHButtonStateSelected,
    
    /**
     *  按钮状态 不可用
     */
    JHButtonStateDisable,
};

/**
 *  默认间距
 */
static CGFloat const JHImageButtonDefaultMargin = 8;

/**
 *  默认未设置间距 自适应距离
 */
static CGFloat const JHImageButtonDefaultUnSetMargin = -1001;

@interface JHButton : UIControl
/**
 *  文本
 */
@property (nonatomic,strong) NSString * text;

/**
 *  图片
 */
@property (nonatomic,strong) UIImage * image;

/**
 *  背景图片
 */
@property (nonatomic,strong) UIImage * backgroundImage;


/**
 *  展示文本的Label 可以用来自定义一些属性
 */
@property (nonatomic,strong) UILabel * contentLabel;

/**
 *  展示图片的ImageView 用来自定义部分属性
 */
@property (nonatomic,strong) UIImageView * imageView;


/**
 *  展示背景图片的ImageView 用来自定义部分属性
 */
@property (nonatomic,strong) UIImageView * backgroundImageView;

/**
 *  是否需要旋转
 */
@property (nonatomic,assign) BOOL isNeedRotation;


/**
 *  当前按钮状态
 */
@property (nonatomic,assign,readonly) JHButtonState currentState;


/**
 *  设置按钮背景颜色 可以为nil
 *
 *  @param normalColor    正常颜色
 *  @param highLightColor 高亮颜色
 */
- (void)setNormolBackgroundColor:(UIColor *)normalColor
               AndHighLightColor:(UIColor *)highLightColor;

/**
 *  设置按钮背景颜色 可以为nil
 *
 *  @param normalColor    正常颜色
 *  @param highLightColor 高亮颜色
 *  @param selectedColor  选中颜色
 *  @param disableColor   不可用颜色
 */
- (void)setNormolBackgroundColor:(UIColor *)normalColor
               AndHighLightColor:(UIColor *)highLightColor
                AndSelectedColor:(UIColor *)selectedColor
                 AndDisableColor:(UIColor *)disableColor;

/**
 *  设置按钮图片 可以为nil
 *
 *  @param normalImage    正常图片
 *  @param highLightImage 高亮图片
 */
- (void)setNormolImage:(UIImage *)normalImage
     AndHighLightImage:(UIImage *)highLightImage;

/**
 *  设置按钮图片 可以为nil
 *
 *  @param normalImage    正常图片
 *  @param highLightImage 高亮图片
 *  @param selectedImage  选中图片
 *  @param disableImage   不可用图片
 */
- (void)setNormolImage:(UIImage *)normalImage
     AndHighLightImage:(UIImage *)highLightImage
      AndSelectedImage:(UIImage *)selectedImage
       AndDisableImage:(UIImage *)disableImage;

/**
 *  设置按钮文本点击颜色 可以为nil
 *
 *  @param normalTextColor    正常文本颜色
 *  @param highLightTextColor 高亮文本颜色
 */
- (void)setNormolTextColor:(UIColor *)normalTextColor
     AndHighLightTextColor:(UIColor *)highLightTextColor;

/**
 *  设置按钮文本点击颜色 可以为nil
 *
 *  @param normalTextColor    正常文本颜色
 *  @param highLightTextColor 高亮文本颜色
 *  @param selectedTextColor  高亮文本颜色
 *  @param disableTextColor   不可用文本颜色
 */
- (void)setNormolTextColor:(UIColor *)normalTextColor
     AndHighLightTextColor:(UIColor *)highLightTextColor
      AndSelectedTextColor:(UIColor *)selectedTextColor
       AndDisableTextColor:(UIColor *)disableTextColor;

/**
 *  设置按钮边框颜色
 *
 *  @param normalLayColor      正常边框颜色
 *  @param highLightLayerColor 高亮边框颜色
 */
- (void)setNormolLayerColor:(UIColor *)normalLayColor
     AndhighLightLayerColor:(UIColor *)highLightLayerColor;

/**
 *  设置按钮边框颜色
 *
 *  @param normalLayColor      正常边框颜色
 *  @param highLightLayerColor 高亮边框颜色
 *  @param selectedLayerColor   选中边框颜色
 *  @param disableLayerColor   不可用边框颜色
 */
- (void)setNormolLayerColor:(UIColor *)normalLayColor
     AndHighLightLayerColor:(UIColor *)highLightLayerColor
      AndSelectedLayerColor:(UIColor *)selectedLayerColor
       AndDisableLayerColor:(UIColor *)disableLayerColor;


/**
 *  设置背景图片
 *
 *  @param normalBackgroundImage    正常背景图片
 *  @param highLightBackgroundImage 高亮背景图片
 */
- (void)setNormalBackgroundImage:(UIImage *)normalBackgroundImage
     AndHighLightBackgroundImage:(UIImage *)highLightBackgroundImage;

/**
 *  设置背景图片
 *
 *  @param normalBackgroundImage    正常背景图片
 *  @param highLightBackgroundImage 高亮背景图片
 *  @param selectedBackgroundImage  选中背景图片
 *  @param disableBackgroundImage   不可用背景图片
 */
- (void)setNormalBackgroundImage:(UIImage *)normalBackgroundImage
     AndHighLightBackgroundImage:(UIImage *)highLightBackgroundImage
      AndSelectedBackgroundImage:(UIImage *)selectedBackgroundImage
       AndDisableBackgroundImage:(UIImage *)disableBackgroundImage;


/**
 *  初始化
 *
 *  @param type 按钮生产类型 具体看JHImageButtonType注释
 *  @param arr  一个NSNumber的数组，用来标示 图片和文本之间的间距 默认 从左到右，从上到下，默认取数组的前三个值 （且当数组 有且仅有1个值时，表示图片和文本之间的间距）如果自适应距离 请设置 JHImageButtonDefaultUnSetMargin
 *
 *  @return JHImageButtonType
 */
- (instancetype)initWithType:(JHImageButtonType)type
                AndMarginArr:(NSArray *)arr;
@end

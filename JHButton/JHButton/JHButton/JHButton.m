//
//  JHButton.m
//  JHButton
//
//  Created by iOS on 2018/3/3.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import "JHButton.h"
@interface JHButton()
/**
 *  间距
 */
@property (nonatomic,strong) NSArray *marginArr;
/**
 *  背景颜色
 */
@property (nonatomic,strong) UIColor *normalColor;
@property (nonatomic,strong) UIColor *highLightColor;
@property (nonatomic,strong) UIColor *selectedColor;
@property (nonatomic,strong) UIColor *disableColor;

/**
 *  图片
 */
@property (nonatomic,strong) UIImage *normalImage;
@property (nonatomic,strong) UIImage *highLightImage;
@property (nonatomic,strong) UIImage *selectedImage;
@property (nonatomic,strong) UIImage *disableImage;

/**
 *  文本颜色
 */
@property (nonatomic,strong) UIColor *normalTextColor;
@property (nonatomic,strong) UIColor *highLightTextColor;
@property (nonatomic,strong) UIColor *selectedTextColor;
@property (nonatomic,strong) UIColor *disableTextColor;

/**
 *  layer颜色
 */
@property (nonatomic,strong) UIColor *normalLayerColor;
@property (nonatomic,strong) UIColor *highLightLayerColor;
@property (nonatomic,strong) UIColor *selectedLayerColor;
@property (nonatomic,strong) UIColor *disableLayerColor;

/**
 *  背景图片
 */
@property (nonatomic,strong) UIImage *normalBackgroundImage;
@property (nonatomic,strong) UIImage *highLightBackgroundImage;
@property (nonatomic,strong) UIImage *selectedBackgroundImage;
@property (nonatomic,strong) UIImage *disableBackgroundImage;

/**
 *  间距
 */
@property (nonatomic,assign) CGFloat marginTopOrLeft;
@property (nonatomic,assign) CGFloat marginBottomOrRight;
@property (nonatomic,assign) CGFloat marginMiddle;

/**
 *  填充
 */
@property (nonatomic,strong) UIView * topOrLeftView;
@property (nonatomic,strong) UIView * bottomOrRightView;

/**
 *  按钮类型
 */
@property (nonatomic,assign) JHImageButtonType type;


@end

@implementation JHButton

/**
 *  初始化
 *
 *  @param type 按钮生产类型 具体看JHImageButtonType注释
 *  @param arr  一个NSNumber的数组，用来标示 图片和文本之间的间距 默认 从左到右，从上到下，默认取数组的前三个值
 *
 *  @return JHImageButtonType
 */
- (instancetype)initWithType:(JHImageButtonType)type AndMarginArr:(NSArray *)arr{
    self = [super init];
    if (self) {
        _marginArr = arr;
        _type = type;
        [self setRootSubView];
    }
    return self;
}

/**
 *  基础布局
 */
- (void)setRootSubView{
    
    _backgroundImageView = [[UIImageView alloc] init];
    _backgroundImageView.image = _image;
    [self addSubview:_backgroundImageView];
    
    _topOrLeftView = [[UIView alloc] init];
    _topOrLeftView.userInteractionEnabled = NO;
    [self addSubview:_topOrLeftView];
    
    _bottomOrRightView = [[UIView alloc] init];
    _bottomOrRightView.userInteractionEnabled = NO;
    [self addSubview:_bottomOrRightView];
    
    _contentLabel = [[UILabel alloc] init];
    _contentLabel.textColor = [UIColor blackColor];
    _contentLabel.textAlignment = NSTextAlignmentCenter;
    _contentLabel.font = [UIFont systemFontOfSize:15];
    _contentLabel.text = _text;
    [self addSubview:_contentLabel];
    
    _imageView = [[UIImageView alloc] init];
    _imageView.image = _image;
    [self addSubview:_imageView];
    
    
    /**
     *  根据传递的数组 来生成3个间距
     */
    switch (_marginArr.count) {
        case 0:
        {
            _marginMiddle = JHImageButtonDefaultMargin;
            _marginTopOrLeft = JHImageButtonDefaultUnSetMargin;
            _marginBottomOrRight = JHImageButtonDefaultUnSetMargin;
            break;
        }
        case 1:
        {
            _marginMiddle = [_marginArr[0] floatValue];
            _marginTopOrLeft = JHImageButtonDefaultUnSetMargin;
            _marginBottomOrRight = JHImageButtonDefaultUnSetMargin;
            break;
        }
        case 2:
        {
            _marginTopOrLeft = [_marginArr[0] floatValue];
            _marginMiddle = [_marginArr[1] floatValue];
            _marginBottomOrRight = JHImageButtonDefaultUnSetMargin;
            break;
        }
        default:
            _marginTopOrLeft = [_marginArr[0] floatValue];
            _marginMiddle = [_marginArr[1] floatValue];
            _marginBottomOrRight = [_marginArr[2] floatValue];
            break;
    }
    
    [self updateFrame];
}

/**
 *  设置图片居左，文本居右约束，影响父布局
 */
- (void)setLeft{
    [_topOrLeftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.mas_bottom);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.imageView.mas_left);
        if (self.marginTopOrLeft != JHImageButtonDefaultUnSetMargin) {
            make.width.equalTo(@(self.marginTopOrLeft));
        }
        else if (self.marginTopOrLeft == self.marginBottomOrRight){
            make.width.equalTo(self.bottomOrRightView.mas_width);
        }
    }];
    
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.right.equalTo(self.contentLabel.mas_left).offset(-self.marginMiddle);
    }];
    
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.right.equalTo(self.bottomOrRightView.mas_left);
        make.width.priorityLow();
        make.width.lessThanOrEqualTo(self.mas_width);
        
    }];
    
    [_bottomOrRightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.mas_bottom);
        make.right.equalTo(self.mas_right);
        if (self.marginBottomOrRight != JHImageButtonDefaultUnSetMargin) {
            make.width.equalTo(@(self.marginBottomOrRight));
        }
    }];
    
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.greaterThanOrEqualTo(self.imageView.mas_height);
        make.height.greaterThanOrEqualTo(self.contentLabel.mas_height);
    }];
}

/**
 *  设置图片居右，文本居左约束，影响父布局
 */
- (void)setRight{
    
    [_topOrLeftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.mas_bottom);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.contentLabel.mas_left);
        if (self.marginTopOrLeft != JHImageButtonDefaultUnSetMargin) {
            make.width.equalTo(@(self.marginTopOrLeft));
        }
        else if (self.marginTopOrLeft == _marginBottomOrRight){
            make.width.equalTo(self.bottomOrRightView.mas_width);
        }
    }];
    
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.right.equalTo(self.imageView.mas_left).offset(-self.marginMiddle);
        make.width.priorityLow();
        make.width.lessThanOrEqualTo(self.mas_width);
    }];
    
    
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.right.equalTo(self.bottomOrRightView.mas_left);
        
    }];
    
    [_bottomOrRightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.mas_bottom);
        make.right.equalTo(self.mas_right);
        if (self.marginBottomOrRight != JHImageButtonDefaultUnSetMargin) {
            make.width.equalTo(@(self.marginBottomOrRight));
        }
    }];
    
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.greaterThanOrEqualTo(self.imageView.mas_height);
        make.height.greaterThanOrEqualTo(self.contentLabel.mas_height);
    }];
}

/**
 *  设置图片居上，文本居下约束，影响父布局
 */
- (void)setTop{
    
    
    [_topOrLeftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.imageView.mas_top);
        if (self.marginTopOrLeft != JHImageButtonDefaultUnSetMargin) {
            make.height.equalTo(@(self.marginTopOrLeft));
        }
        else if (self.marginTopOrLeft == _marginBottomOrRight){
            make.height.equalTo(self.bottomOrRightView.mas_height);
        }
    }];
    
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.bottom.equalTo(self.contentLabel.mas_top).offset(-self.marginMiddle);
    }];
    
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.bottom.equalTo(self.bottomOrRightView.mas_top);
        make.height.priorityLow();
        make.height.lessThanOrEqualTo(self.mas_height);
    }];
    
    [_bottomOrRightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.mas_bottom);
        if (self.marginBottomOrRight != JHImageButtonDefaultUnSetMargin) {
            make.height.equalTo(@(self.marginBottomOrRight));
        }
    }];
    
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.greaterThanOrEqualTo(self.imageView.mas_width);
        make.width.greaterThanOrEqualTo(self.contentLabel.mas_width);
    }];
    
}

/**
 *  设置图片居下，文本居上约束，影响父布局
 */
- (void)setBottom{
    
    
    [_topOrLeftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(_contentLabel.mas_top);
        if (self.marginTopOrLeft != JHImageButtonDefaultUnSetMargin) {
            make.height.equalTo(@(self.marginTopOrLeft));
        }
        else if (self.marginTopOrLeft == _marginBottomOrRight){
            make.height.equalTo(self.bottomOrRightView.mas_height);
        }
    }];
    
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.bottom.equalTo(self.imageView.mas_top).offset(-self.marginMiddle);
        make.height.priorityLow();
        make.height.lessThanOrEqualTo(self.mas_height);
    }];
    
    
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.bottom.equalTo(self.bottomOrRightView.mas_top);
        
    }];
    
    [_bottomOrRightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.mas_bottom);
        if (self.marginBottomOrRight != JHImageButtonDefaultUnSetMargin) {
            make.height.equalTo(@(self.marginBottomOrRight));
        }
    }];
    
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.greaterThanOrEqualTo(self.imageView.mas_width);
        make.width.greaterThanOrEqualTo(self.contentLabel.mas_width);
    }];
}

/**
 *  根据类型来更新约束
 */
- (void)updateFrame{
    switch (_type) {
        case JHImageButtonTypeLeft:
        {
            [self setLeft];
            break;
        }
        case JHImageButtonTypeRight:
        {
            [self setRight];
            break;
        }
        case JHImageButtonTypeTop:
        {
            [self setTop];
            break;
        }
        case JHImageButtonTypeBottom:
        {
            [self setBottom];
            break;
        }
        default:
            break;
    }
    
    [_backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.mas_bottom);
    }];
}

#pragma mark Touch事件监听

/**
 *  开始Touch 设置高亮
 *
 *  @param touch ....
 *  @param event ....
 *
 *  @return 是否接受Touch事件
 */
- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    [self setHighLight];
    return YES;
}

/**
 *  持续Touch 设置高亮
 *
 *  @param touch ...
 *  @param event ...
 *
 *  @return 是否接受持续点击事件
 */
- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    [self setHighLight];
    return YES;
}

/**
 *  取消Touch 取消高亮，恢复正常
 *
 *  @param event ...
 */
- (void)cancelTrackingWithEvent:(UIEvent *)event{
    [self setNormal];
}

/**
 *  结束Touch 取消高亮，恢复正常
 *
 *  @param touch ...
 *  @param event ...
 */
- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    [self setNormal];
}

#pragma mark 事件

/**
 *  设置按钮背景颜色 可以为nil
 *
 *  @param normalColor    正常颜色
 *  @param highLightColor 高亮颜色
 */
- (void)setNormolBackgroundColor:(UIColor *)normalColor
               AndHighLightColor:(UIColor *)highLightColor{
    [self setNormolBackgroundColor:normalColor
                 AndHighLightColor:highLightColor
                  AndSelectedColor:nil
                   AndDisableColor:nil];
}

/**
 *  设置按钮背景颜色 可以为nil
 *
 *  @param normalColor    正常颜色
 *  @param highLightColor 高亮颜色
 *  @param disableColor   不可用颜色
 */
- (void)setNormolBackgroundColor:(UIColor *)normalColor
               AndHighLightColor:(UIColor *)highLightColor
                AndSelectedColor:(UIColor *)selectedColor
                 AndDisableColor:(UIColor *)disableColor{
    _normalColor = normalColor;
    _highLightColor = highLightColor;
    _disableColor = disableColor;
    _selectedColor = selectedColor;
    self.backgroundColor = normalColor;
}
/**
 *  设置按钮图片 可以为nil
 *
 *  @param normalImage    正常图片
 *  @param highLightImage 高亮图片
 */
- (void)setNormolImage:(UIImage *)normalImage
     AndHighLightImage:(UIImage *)highLightImage{
    [self setNormolImage:normalImage
       AndHighLightImage:highLightImage
        AndSelectedImage:nil
         AndDisableImage:nil];
}

/**
 *  设置按钮图片 可以为nil
 *
 *  @param normalImage    正常图片
 *  @param highLightImage 高亮图片
 *  @param disableImage   不可用图片
 */

- (void)setNormolImage:(UIImage *)normalImage
     AndHighLightImage:(UIImage *)highLightImage
      AndSelectedImage:(UIImage *)selectedImage
       AndDisableImage:(UIImage *)disableImage{
    _normalImage = normalImage;
    _highLightImage = highLightImage;
    _disableImage = disableImage;
    _selectedImage = selectedImage;
    if (_currentState == JHButtonStateDisable) {
        self.image = disableImage;
    }else if(_currentState == JHButtonStateNormal){
        self.image = normalImage;
    }else if(_currentState == JHButtonStateSelected){
        self.image = selectedImage;
    }else if(_currentState == JHButtonStateHighLight){
        self.image = highLightImage;
    }
}
/**
 *  设置按钮文本点击颜色 可以为nil
 *
 *  @param normalTextColor    正常文本颜色
 *  @param highLightTextColor 高亮文本颜色
 */
- (void)setNormolTextColor:(UIColor *)normalTextColor
     AndHighLightTextColor:(UIColor *)highLightTextColor{
    [self setNormolTextColor:normalTextColor
       AndHighLightTextColor:highLightTextColor
        AndSelectedTextColor:nil
         AndDisableTextColor:nil];
}

/**
 *  设置按钮文本点击颜色 可以为nil
 *
 *  @param normalTextColor    正常文本颜色
 *  @param highLightTextColor 高亮文本颜色
 *  @param disableTextColor   不可用文本颜色
 */

- (void)setNormolTextColor:(UIColor *)normalTextColor
     AndHighLightTextColor:(UIColor *)highLightTextColor
      AndSelectedTextColor:(UIColor *)selectedTextColor
       AndDisableTextColor:(UIColor *)disableTextColor{
    _normalTextColor = normalTextColor;
    _highLightTextColor = highLightTextColor;
    _disableTextColor = disableTextColor;
    _selectedTextColor = selectedTextColor;
    if (_currentState == JHButtonStateDisable) {
        _contentLabel.textColor = disableTextColor;
    }else if(_currentState == JHButtonStateNormal){
        _contentLabel.textColor = normalTextColor;
    }else if(_currentState == JHButtonStateSelected){
        _contentLabel.textColor = selectedTextColor;
    }else if(_currentState == JHButtonStateHighLight){
        _contentLabel.textColor = highLightTextColor;
    }
}
/**
 *  设置按钮边框颜色
 *
 *  @param normalLayColor      正常边框颜色
 *  @param highLightLayerColor 高亮边框颜色
 */
- (void)setNormolLayerColor:(UIColor *)normalLayColor
     AndhighLightLayerColor:(UIColor *)highLightLayerColor{
    [self setNormolLayerColor:normalLayColor
       AndHighLightLayerColor:highLightLayerColor
        AndSelectedLayerColor:nil
         AndDisableLayerColor:nil];
}

/**
 *  设置按钮边框颜色
 *
 *  @param normalLayColor      正常边框颜色
 *  @param highLightLayerColor 高亮边框颜色
 *  @param disableLayerColor   不可用边框颜色
 */

- (void)setNormolLayerColor:(UIColor *)normalLayColor
     AndHighLightLayerColor:(UIColor *)highLightLayerColor
      AndSelectedLayerColor:(UIColor *)selectedLayerColor
       AndDisableLayerColor:(UIColor *)disableLayerColor{
    _normalLayerColor = normalLayColor;
    _highLightLayerColor = highLightLayerColor;
    _disableLayerColor = disableLayerColor;
    _selectedLayerColor = selectedLayerColor;
    if (_currentState == JHButtonStateDisable) {
        self.layer.borderColor = _disableLayerColor.CGColor;
    }else if(_currentState == JHButtonStateNormal){
        self.layer.borderColor = _normalLayerColor.CGColor;
    }else if(_currentState == JHButtonStateSelected){
        self.layer.borderColor = _selectedLayerColor.CGColor;
    }else if(_currentState == JHButtonStateHighLight){
        self.layer.borderColor = _highLightLayerColor.CGColor;
    }
}

/**
 *  设置背景图片
 *
 *  @param normalBackgroundImage    正常背景图片
 *  @param highLightBackgroundImage 高亮背景图片
 */
- (void)setNormalBackgroundImage:(UIImage *)normalBackgroundImage
     AndHighLightBackgroundImage:(UIImage *)highLightBackgroundImage{
    [self setNormalBackgroundImage:normalBackgroundImage
       AndHighLightBackgroundImage:highLightBackgroundImage
        AndSelectedBackgroundImage:nil
         AndDisableBackgroundImage:nil];
}

/**
 *  设置背景图片
 *
 *  @param normalBackgroundImage    正常背景图片
 *  @param highLightBackgroundImage 高亮背景图片
 *  @param disableBackgroundImage   不可用背景图片
 */

- (void)setNormalBackgroundImage:(UIImage *)normalBackgroundImage
     AndHighLightBackgroundImage:(UIImage *)highLightBackgroundImage
      AndSelectedBackgroundImage:(UIImage *)selectedBackgroundImage
       AndDisableBackgroundImage:(UIImage *)disableBackgroundImage{
    _normalBackgroundImage = normalBackgroundImage;
    _highLightBackgroundImage = highLightBackgroundImage;
    _disableBackgroundImage = disableBackgroundImage;
    _selectedBackgroundImage = selectedBackgroundImage;
    if (_currentState == JHButtonStateDisable) {
        self.backgroundImage = disableBackgroundImage;
    }else if(_currentState == JHButtonStateNormal){
        self.backgroundImage = normalBackgroundImage;
    }else if(_currentState == JHButtonStateSelected){
        self.backgroundImage = selectedBackgroundImage;
    }else if(_currentState == JHButtonStateHighLight){
        self.backgroundImage = highLightBackgroundImage;
    }
}
/**
 *  设置文本
 *
 *  @param text 文本
 */
- (void)setText:(NSString *)text{
    _contentLabel.text = text;
    _text = text;
}

/**
 *  设置展示图片
 *
 *  @param image 图片
 */
- (void)setImage:(UIImage *)image{
    _imageView.image = image;
    _image = image;
}


/**
 *  设置背景图片
 */
- (void)setBackgroundImage:(UIImage *)backgroundImage{
    _backgroundImageView.image = backgroundImage;
    _backgroundImage = backgroundImage;
}

/**
 *  设置是否需要转向
 *
 *  @param isNeedRotation ...
 */
- (void)setIsNeedRotation:(BOOL)isNeedRotation{
    _isNeedRotation = isNeedRotation;
    if(_isNeedRotation){
        [UIView animateWithDuration:0.3 animations:^{
            self.imageView.transform = CGAffineTransformMakeRotation(M_PI - 0.01);
        } completion:^(BOOL finished) {
            
        }];
    }else{
        [UIView animateWithDuration:0.3 animations:^{
            self.imageView.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            
        }];
    }
}


/**
 *  设置正常 所有的恢复正常操作应该在本方法中完成
 */
- (void)setNormal{
    
    if (_currentState == JHButtonStateNormal) {
        return;
    }
    _currentState = JHButtonStateNormal;
    if (_normalColor) {
        self.backgroundColor = _normalColor;
    }
    if (_normalImage) {
        _imageView.image = _normalImage;
    }
    if (_normalTextColor) {
        _contentLabel.textColor = _normalTextColor;
    }
    
    if (_normalLayerColor) {
        self.layer.borderColor = _normalLayerColor.CGColor;
    }
    
    if (_normalBackgroundImage) {
        self.backgroundImageView.image = _normalBackgroundImage;
    }
    
    self.alpha = 1.0;
}

/**
 *   设置高亮 所有的高亮操作应该在本方法中完成
 */
- (void)setHighLight{
    
    if (_currentState == JHButtonStateHighLight) {
        return;
    }
    _currentState = JHButtonStateHighLight;
    if (_highLightColor) {
        self.backgroundColor = _highLightColor;
    }
    if (_highLightImage) {
        _imageView.image = _highLightImage;
    }
    if (_highLightTextColor) {
        _contentLabel.textColor = _highLightTextColor;
    }
    if (_highLightLayerColor) {
        self.layer.borderColor = _highLightLayerColor.CGColor;
    }
    
    if (_highLightBackgroundImage) {
        self.backgroundImageView.image = _highLightBackgroundImage;
    }
}

-(void)setSelected{
    if (_currentState == JHButtonStateSelected) {
        return;
    }
    _currentState = JHButtonStateSelected;
    if (_selectedColor) {
        self.backgroundColor = _selectedColor;
    }
    if (_selectedImage) {
        _imageView.image = _selectedImage;
    }
    if (_selectedTextColor) {
        _contentLabel.textColor = _selectedTextColor;
    }
    if (_selectedLayerColor) {
        self.layer.borderColor = _selectedLayerColor.CGColor;
    }
    
    if (_selectedBackgroundImage) {
        self.backgroundImageView.image = _selectedBackgroundImage;
    }
}
/**
 *  设置不可以状态 所有的不可用操作应该在本方法中完成
 */
- (void)setDisable{
    if (_currentState == JHButtonStateDisable) {
        return;
    }
    _currentState = JHButtonStateDisable;
    if (_disableColor) {
        self.backgroundColor = _disableColor;
    }
    if (_disableImage) {
        _imageView.image = _disableImage;
    }
    if (_disableTextColor) {
        _contentLabel.textColor = _disableTextColor;
    }
    if (_disableLayerColor) {
        self.layer.borderColor = _disableLayerColor.CGColor;
    }
    
    if (_disableBackgroundImage) {
        self.backgroundImageView.image = _disableBackgroundImage;
    }
    
    if (!_disableColor && !_disableImage && !_disableTextColor && !_disableLayerColor && !_disableBackgroundImage) {
        self.alpha = 0.6;
    }
    
}

/**
 *  设置不可用
 *
 *  @param enabled 颜色透明度变化
 */
- (void)setEnabled:(BOOL)enabled{
    if (self.enabled == enabled) {
        return;
    }
    [super setEnabled:enabled];
    if (enabled) {
        [self setNormal];
    }else{
        [self setDisable];
    }
    
}
-(void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    if (selected) {
        [self setSelected];
    }else{
        [self setNormal];
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
}
@end

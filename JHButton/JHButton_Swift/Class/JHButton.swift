//
//  JHButton.swift
//  JHButton_Swift
//
//  Created by iOS on 2020/1/14.
//  Copyright © 2020 iOS. All rights reserved.
//

import UIKit
import SnapKit

public enum JHImageButtonType {
        ///按钮图片居左 文案居右 可以影响父布局的大小
        case imageButtonTypeLeft
        ///按钮图片居右 文案居左 可以影响父布局的大小
        case imageButtonTypeRight
        ///按钮图片居上 文案居下 可以影响父布局的大小
        case imageButtonTypeTop
        ///按钮图片居下 文案居上 可以影响父布局的大小
        case imageButtonTypeBottom
}

public enum JHButtonState {
    ///按钮状态 正常
    case buttonStateNormal
    ///按钮状态 高亮
    case buttonStateHighLight
    ///按钮状态 选中
    case buttonStateSelected
    ///按钮状态 不可用
    case buttonStateDisable
}


class JHButton: UIControl {

    ///按钮的闭包回调
    public typealias ActionBlock = (_ sender: JHButton) -> Void
    ///title字符串
    public var title : String?{
        didSet{
            self.titleLabel.text = title
        }
    }
    ///图片
    public var image : UIImage?{
        didSet{
            self.imageView.image = image
        }
    }
    ///背景图片
    public var backImage : UIImage?{
        didSet{
            self.backImageView.image = backImage
        }
    }
    ///内容文字视图
    public var titleLabel = UILabel()
    ///图片视图
    public var imageView = UIImageView()
    ///背景图片视图
    public var backImageView = UIImageView()
    ///是否反转
    public var isNeedRotation : Bool = false{
        didSet{
            if isNeedRotation{
                UIView.animate(withDuration: 0.3) {
                    self.imageView.transform = CGAffineTransform.identity.rotated(by: CGFloat(Double.pi*180))
                }
            }else{
              UIView.animate(withDuration: 0.3) {
                self.imageView.transform = CGAffineTransform.identity
                }
            }
        }
    }
    ///是否可用
    public override var isEnabled: Bool{
        didSet{
            if isEnabled {
                setNormal()
            }else{
                setDisable()
            }
        }
    }
    ///是否选中
    public override var isSelected: Bool{
        didSet{
            if isSelected{
                setSelected()
            }else{
                setNormal()
            }
        }
    }
    ///当前按钮状态
    public var currentState : JHButtonState = .buttonStateNormal
    
    //MARK: -- 以下内部参数
    ///默认间距
    static let imageButtonDefaultMargin : Float = 0
    static let imageButtonDefaultUnsetMargin : Float = -1001
    /**
     *  间距
     */
    private var marginArr : [Float]!
    /**
     *  背景颜色
     */
    private var normalColor : UIColor?
    private var highLightColor : UIColor?
    private var selectedColor : UIColor?
    private var disableColor : UIColor?
    /**
     *  图片
     */
    private var normalImage : UIImage?
    private var highLightImage : UIImage?
    private var selectedImage : UIImage?
    private var disableImage : UIImage?
    /**
     *  文本颜色
     */
    private var normalTitleColor : UIColor?
    private var highLightTitleColor : UIColor?
    private var selectedTitleColor : UIColor?
    private var disableTitleColor : UIColor?
    /**
     *  layer颜色
     */
    private var normalLayerColor : UIColor?
    private var highLightLayerColor : UIColor?
    private var selectedLayerColor : UIColor?
    private var disableLayerColor : UIColor?
    /**
     *  背景图片
     */
    private var normalBackImage : UIImage?
    private var highLightBackImage : UIImage?
    private var selectedBackImage : UIImage?
    private var disableBackImage : UIImage?
    /**
     *  间距
     */
    private var marginTopOrLeft : Float = 0.0
    private var marginBottomOrRight : Float = 0.0
    private var marginMiddle : Float = 0.0
    /**
     *  填充
     */
    private var topOrLeftView = UIView()
    private var bottomOrRightView = UIView()
    /**
     *  按钮类型
     */
    private var type : JHImageButtonType = .imageButtonTypeLeft
    
    private var actionBlock : ActionBlock?
}

extension JHButton{
    
    /// 创建按钮
    /// - Parameters:
    ///   - type: 图文混排类型
    ///   - marginArr: 从左到右或者从上到下的间距数组
    public convenience init(_ type : JHImageButtonType = .imageButtonTypeLeft, marginArr : [Float]? = [5]) {
        self.init()
        self.marginArr = marginArr
        self.type = type
        
        setRootSubView()
    }
    ///触发点击
    public func handleControlEvent(_ event : UIControl.Event , action : @escaping ActionBlock) {
        addTarget(self, action: #selector(callActionBlock), for: event)
        self.actionBlock = action
    }
    ///点击闭包
    @objc
    func callActionBlock(_ sender: JHButton) {
        guard let action = self.actionBlock else {
            return
        }
        action(sender)
    }
    //MARK:--布局
    func setRootSubView() {
        
        self.backImageView.image = self.image
        self.addSubview(self.backImageView)
        
        self.topOrLeftView.isUserInteractionEnabled = false
        self.addSubview(self.topOrLeftView)
        
        self.bottomOrRightView.isUserInteractionEnabled = false
        self.addSubview(self.bottomOrRightView)
        
        self.titleLabel.textColor = .black
        self.titleLabel.textAlignment = .center
        self.titleLabel.font = UIFont.systemFont(ofSize: 15)
        self.titleLabel.text = self.title
        self.addSubview(self.titleLabel)
        
        self.imageView.setContentCompressionResistancePriority(.required, for: .horizontal)
        self.imageView.image = self.image
        self.addSubview(self.imageView)
        
        switch self.marginArr.count {
        case 0:
            self.marginMiddle = JHButton.imageButtonDefaultMargin
            self.marginTopOrLeft = JHButton.imageButtonDefaultUnsetMargin
            self.marginBottomOrRight = JHButton.imageButtonDefaultUnsetMargin
        case 1:
            self.marginMiddle = self.marginArr[0]
            self.marginTopOrLeft = JHButton.imageButtonDefaultUnsetMargin
            self.marginBottomOrRight = JHButton.imageButtonDefaultUnsetMargin
        case 2:
            self.marginTopOrLeft = self.marginArr[0]
            self.marginMiddle = self.marginArr[1]
            self.marginBottomOrRight = JHButton.imageButtonDefaultUnsetMargin
        default:
            self.marginTopOrLeft = self.marginArr[0]
            self.marginMiddle = self.marginArr[1]
            self.marginBottomOrRight = self.marginArr[2]
        }
        
        updateLayout()
    }
    
    func updateLayout() {
        
        switch self.type {
        case .imageButtonTypeTop:
            setTop()
        case .imageButtonTypeLeft:
            setLeft()
        case .imageButtonTypeBottom:
            setBottom()
        case .imageButtonTypeRight:
            setRight()
        }
        self.backImageView.snp.makeConstraints { (make) in
            make.top.left.bottom.right.equalToSuperview()
        }
    }
    
    func setTop() {
        
        self.topOrLeftView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.bottom.equalTo(self.imageView.snp.top)
            if self.marginTopOrLeft != JHButton.imageButtonDefaultUnsetMargin{
                make.height.equalTo(self.marginTopOrLeft)
            }
            if self.marginTopOrLeft == self.marginBottomOrRight{
                make.height.equalTo(self.bottomOrRightView.snp.height)
            }
        }
        
        self.imageView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.bottom.equalTo(self.titleLabel.snp.top).offset(-self.marginMiddle)
        }
        
        self.titleLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(self.bottomOrRightView.snp.top)
            make.height.lessThanOrEqualToSuperview()
        }
        
        self.bottomOrRightView.snp.makeConstraints { (make) in
            make.left.bottom.right.equalToSuperview()
            if self.marginBottomOrRight != JHButton.imageButtonDefaultUnsetMargin{
                make.height.equalTo(self.marginBottomOrRight)
            }
        }
        
        self.snp.makeConstraints { (make) in
            make.width.greaterThanOrEqualTo(self.imageView.snp.width)
            make.width.greaterThanOrEqualTo(self.titleLabel.snp.width)
        }

    }
    
    func setLeft() {
        
        self.topOrLeftView.snp.makeConstraints { (make) in
            make.top.left.bottom.equalToSuperview()
            make.right.equalTo(self.imageView.snp.left)
            if self.marginTopOrLeft != JHButton.imageButtonDefaultUnsetMargin{
                make.width.equalTo(self.marginTopOrLeft)
            }
            if self.marginTopOrLeft == self.marginBottomOrRight{
                make.width.equalTo(self.bottomOrRightView.snp.width)
            }
        }
        
        self.imageView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalTo(self.titleLabel.snp.left).offset(-self.marginMiddle)
        }
        
        self.titleLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalTo(self.bottomOrRightView.snp.left)
            make.width.lessThanOrEqualToSuperview()
        }
        
        self.bottomOrRightView.snp.makeConstraints { (make) in
            make.top.bottom.right.equalToSuperview()
            if self.marginBottomOrRight != JHButton.imageButtonDefaultUnsetMargin{
                make.width.equalTo(self.marginBottomOrRight)
            }
        }
        
        self.snp.makeConstraints { (make) in
            make.height.greaterThanOrEqualTo(self.imageView.snp.height)
            make.height.greaterThanOrEqualTo(self.titleLabel.snp.height)
        }
    }
    
    func setBottom() {
        
        self.topOrLeftView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.bottom.equalTo(self.titleLabel.snp.top)
            if self.marginTopOrLeft != JHButton.imageButtonDefaultUnsetMargin{
                make.height.equalTo(self.marginTopOrLeft)
            }
            if self.marginTopOrLeft == self.marginBottomOrRight{
                make.height.equalTo(self.bottomOrRightView.snp.height)
            }
        }
        
        self.titleLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(self.imageView.snp.top).offset(-self.marginMiddle)
            make.height.lessThanOrEqualToSuperview()
        }
        
        self.imageView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.bottom.equalTo(self.bottomOrRightView.snp.top)
        }
        
        self.bottomOrRightView.snp.makeConstraints { (make) in
            make.left.bottom.right.equalToSuperview()
            if self.marginBottomOrRight != JHButton.imageButtonDefaultUnsetMargin{
                make.height.equalTo(self.marginBottomOrRight)
            }
        }
        
        self.snp.makeConstraints { (make) in
            make.width.greaterThanOrEqualTo(self.imageView.snp.width)
            make.width.greaterThanOrEqualTo(self.titleLabel.snp.width)
        }

    }
    
    func setRight() {
        
        self.topOrLeftView.snp.makeConstraints { (make) in
            make.top.left.bottom.equalToSuperview()
            make.right.equalTo(self.titleLabel.snp.left)
            if self.marginTopOrLeft != JHButton.imageButtonDefaultUnsetMargin{
                make.width.equalTo(self.marginTopOrLeft)
            }
            if self.marginTopOrLeft == self.marginBottomOrRight{
                make.width.equalTo(self.bottomOrRightView.snp.width)
            }
        }
        
        self.titleLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalTo(self.imageView.snp.left).offset(-self.marginMiddle)
            make.width.lessThanOrEqualToSuperview()
        }
        
        self.imageView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalTo(self.bottomOrRightView.snp.left)
        }
        
        self.bottomOrRightView.snp.makeConstraints { (make) in
            make.top.bottom.right.equalToSuperview()
            if self.marginBottomOrRight != JHButton.imageButtonDefaultUnsetMargin{
                make.width.equalTo(self.marginBottomOrRight)
            }
        }
        
        self.snp.makeConstraints { (make) in
            make.height.greaterThanOrEqualTo(self.imageView.snp.height)
            make.height.greaterThanOrEqualTo(self.titleLabel.snp.height)
        }
        
    }
    
    //MARK: --样式设置
    
    /// 设置背景颜色
    /// - Parameters:
    ///   - normalColor: 普通状态
    ///   - highLightColor: 点击状态
    ///   - selectedColor: 选中状态
    ///   - disableColor: 不可用状态
    public func setBackColor(normalColor : UIColor,
                             highLightColor : UIColor? = .clear,
                             selectedColor : UIColor? = .clear,
                             disableColor  : UIColor? = .clear ){
        self.normalColor = normalColor
        self.highLightColor = highLightColor
        self.selectedColor = selectedColor
        self.disableColor = disableColor
        switch self.currentState {
        case .buttonStateNormal:
            self.backgroundColor = normalColor
        case .buttonStateHighLight:
            self.backgroundColor = highLightColor
        case .buttonStateSelected:
            self.backgroundColor = selectedColor
        case .buttonStateDisable:
            self.backgroundColor = disableColor
        }
    }
    
    /// 设置图片
    /// - Parameters:
    ///   - normalImage: 普通状态
    ///   - highLightImage: 点击状态
    ///   - selectedImage: 选中状态
    ///   - disableImage: 不可用状态
    public func setImage(normalImage : UIImage,
                         highLightImage : UIImage? = nil,
                         selectedImage : UIImage? = nil,
                         disableImage  : UIImage? = nil ){
        self.normalImage = normalImage
        self.highLightImage = highLightImage
        self.selectedImage = selectedImage
        self.disableImage = disableImage
        switch self.currentState {
        case .buttonStateNormal:
            self.image = normalImage
        case .buttonStateHighLight:
            self.image = highLightImage
        case .buttonStateSelected:
            self.image = selectedImage
        case .buttonStateDisable:
            self.image = disableImage
        }
    }
    
    /// 设置标题字体颜色
    /// - Parameters:
    ///   - normalTitleColor: 普通状态
    ///   - highLightTitleColor: 点击状态
    ///   - selectedTitleColor: 选中状态
    ///   - disableTitleColor: 不可用状态
    public func setTitleColor(normalTitleColor : UIColor,
                              highLightTitleColor : UIColor? = .clear,
                              selectedTitleColor : UIColor? = .clear,
                              disableTitleColor  : UIColor? = .clear ){
        self.normalTitleColor = normalTitleColor
        self.highLightTitleColor = highLightTitleColor
        self.selectedTitleColor = selectedTitleColor
        self.disableTitleColor = disableTitleColor
        switch self.currentState {
        case .buttonStateNormal:
            self.titleLabel.textColor = normalTitleColor
        case .buttonStateHighLight:
            self.titleLabel.textColor = highLightTitleColor
        case .buttonStateSelected:
            self.titleLabel.textColor = selectedTitleColor
        case .buttonStateDisable:
            self.titleLabel.textColor = disableTitleColor
        }
    }
    
    /// 设置边框颜色
    /// - Parameters:
    ///   - normalLayerColor: 普通状态
    ///   - highLightLayerColor: 点击状态
    ///   - selectedLayerColor: 选中状态
    ///   - disableLayerColor: 不可用状态
    public func setLayerColor(normalLayerColor : UIColor,
                              highLightLayerColor : UIColor? = .clear,
                              selectedLayerColor : UIColor? = .clear,
                              disableLayerColor  : UIColor? = .clear ){
        self.normalLayerColor = normalLayerColor
        self.highLightLayerColor = highLightLayerColor
        self.selectedLayerColor = selectedLayerColor
        self.disableLayerColor = disableLayerColor
        switch self.currentState {
        case .buttonStateNormal:
            self.layer.borderColor = normalLayerColor.cgColor
        case .buttonStateHighLight:
            self.layer.borderColor = highLightLayerColor?.cgColor
        case .buttonStateSelected:
            self.layer.borderColor = selectedLayerColor?.cgColor
        case .buttonStateDisable:
            self.layer.borderColor = disableLayerColor?.cgColor
        }
    }
    
    /// 设置背景图片
    /// - Parameters:
    ///   - normalBackImage: 普通状态
    ///   - highLightBackImage: 点击状态
    ///   - selectedBackImage: 选中状态
    ///   - disableBackImage: 不可用状态
    public func setBackImage(normalBackImage : UIImage,
                         highLightBackImage : UIImage? = nil,
                         selectedBackImage : UIImage? = nil,
                         disableBackImage  : UIImage? = nil ){
        self.normalBackImage = normalBackImage
        self.highLightBackImage = highLightBackImage
        self.selectedBackImage = selectedBackImage
        self.disableBackImage = disableBackImage
        switch self.currentState {
        case .buttonStateNormal:
            self.backImage = normalBackImage
        case .buttonStateHighLight:
            self.backImage = highLightBackImage
        case .buttonStateSelected:
            self.backImage = selectedBackImage
        case .buttonStateDisable:
            self.backImage = disableBackImage
        }
    }
    
    //MARK: --状态设置
    func setNormal() {
        guard self.currentState != .buttonStateNormal else { return }
        
        self.currentState = .buttonStateNormal
        
        if self.normalColor != nil{
            self.backgroundColor = self.normalColor
        }
        if self.normalImage != nil{
            self.imageView.image = self.normalImage
        }
        if self.normalTitleColor != nil{
            self.titleLabel.textColor = self.normalTitleColor
        }
        
        if self.normalLayerColor != nil{
            self.layer.borderColor = self.normalLayerColor?.cgColor;
        }
        
        if self.normalBackImage != nil{
            self.backImageView.image = self.normalBackImage;
        }
    }
    
    func setHighLight() {
        guard self.currentState != .buttonStateHighLight else { return }
        
        self.currentState = .buttonStateHighLight
        
        if self.highLightColor != nil{
            self.backgroundColor = self.highLightColor
        }
        if self.highLightImage != nil{
            self.imageView.image = self.highLightImage
        }
        if self.highLightTitleColor != nil{
            self.titleLabel.textColor = self.highLightTitleColor
        }
        
        if self.highLightLayerColor != nil{
            self.layer.borderColor = self.highLightLayerColor?.cgColor;
        }
        
        if self.highLightBackImage != nil{
            self.backImageView.image = self.highLightBackImage;
        }
    }
    
    func setSelected() {
        guard self.currentState != .buttonStateSelected else { return }
        
        self.currentState = .buttonStateSelected
        
        if self.selectedColor != nil{
            self.backgroundColor = self.selectedColor
        }
        if self.selectedImage != nil{
            self.imageView.image = self.selectedImage
        }
        if self.selectedTitleColor != nil{
            self.titleLabel.textColor = self.selectedTitleColor
        }
        
        if self.selectedLayerColor != nil{
            self.layer.borderColor = self.selectedLayerColor?.cgColor;
        }
        
        if self.selectedBackImage != nil{
            self.backImageView.image = self.selectedBackImage;
        }
    }
    
    func setDisable() {
        guard self.currentState != .buttonStateDisable else { return }
        
        self.currentState = .buttonStateDisable
        
        if self.disableColor != nil{
            self.backgroundColor = self.disableColor
        }
        if self.disableImage != nil{
            self.imageView.image = self.disableImage
        }
        if self.disableTitleColor != nil{
            self.titleLabel.textColor = self.disableTitleColor
        }
        
        if self.disableLayerColor != nil{
            self.layer.borderColor = self.disableLayerColor?.cgColor;
        }
        
        if self.disableBackImage != nil{
            self.backImageView.image = self.disableBackImage;
        }
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
    }
    
    //MARK: --Touch事件监听
    override open func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        setHighLight()
        return true
    }
    
    override open func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        setHighLight()
        return true
    }
    
    override open func cancelTracking(with event: UIEvent?) {
        setNormal()
    }
    
    override open func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        setNormal()
    }
}

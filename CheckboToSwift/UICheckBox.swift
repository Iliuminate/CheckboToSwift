//
//  UICheckBox.swift
//  CheckboToSwift
//
//  Created by Carlos Diaz on 5/11/20.
//

import UIKit

protocol UICheckBoxDelegate: class {
    func selected(state: Bool)
}

class UICheckBox: UIControl {
    
    // MARK: - Public properties -
    var borderStyle: BorderStyle = .roundedSquare(radius: 2.75)
    var borderWidth: CGFloat = 3.15
    var checkBackgroundColor: UIColor = UIColor( red: 40/255, green: 127/255, blue: 238/255, alpha: 1.0)
    var checkedBorderColor: UIColor = UIColor( red: 40/255, green: 127/255, blue: 238/255, alpha: 1.0)
    var checkmarkColor: UIColor = .white
    var checkmarkSize: CGFloat = 0.5
    var increasedTouchRadius: CGFloat = 3
    var style: Style = .tick
    var uncheckBackgroundColor: UIColor = .white
    var uncheckedBorderColor: UIColor = UIColor( red: 128/255, green: 128/255, blue: 128/255, alpha: 1.0)
    var useHapticFeedback: Bool = true
    
    weak var delegate: UICheckBoxDelegate?
    
    var isChecked: Bool = false {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    // MARK: - Private properties -
    private var feedbackGenerator: UIImpactFeedbackGenerator?
    
    // MARK: - Lifecycle -
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpView()
    }
    
    init(frame: CGRect, style: Style, borderStyle: BorderStyle) {
        super.init(frame: frame)
        self.style = style
        self.borderStyle = borderStyle
    }
    
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        feedbackGenerator = UIImpactFeedbackGenerator(style: .light)
        feedbackGenerator?.prepare()
    }
    
    open override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        isChecked = !isChecked
        self.sendActions(for: .valueChanged)
        if useHapticFeedback {
            feedbackGenerator?.impactOccurred()
            feedbackGenerator = nil
            delegate?.selected(state: isChecked)
        }
    }
    
    open override func draw(_ rect: CGRect) {
        let newRect = rect.insetBy(dx: borderWidth / 2, dy: borderWidth / 2)
        guard let context = UIGraphicsGetCurrentContext() else { return }
        context.setStrokeColor(self.isChecked ? checkedBorderColor.cgColor : uncheckedBorderColor.cgColor)
        context.setFillColor(self.isChecked ? checkBackgroundColor.cgColor : uncheckBackgroundColor.cgColor)
        context.setLineWidth(borderWidth)
        
        var shapePath: UIBezierPath!
        switch self.borderStyle {
        case .square:
            shapePath = UIBezierPath(rect: newRect)
        case .roundedSquare(let radius):
            shapePath = UIBezierPath(roundedRect: newRect, cornerRadius: radius)
        case .rounded:
            shapePath = UIBezierPath.init(ovalIn: newRect)
        }
        
        context.addPath(shapePath.cgPath)
        if isChecked {
            context.fillPath()
        } else {
            context.strokePath()
        }
        
        if isChecked {
            switch self.style {
            case .square:
                self.drawInnerSquare(frame: newRect)
            case .circle:
                self.drawCircle(frame: newRect)
            case .cross:
                self.drawCross(frame: newRect)
            case .tick:
                self.drawCheckMark(frame: newRect)
            }
        }
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        self.setNeedsDisplay()
    }
    
    open override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.setNeedsDisplay()
    }
    
    //To increase the hit frame for this component
    //Usaully check boxes are small in our app's UI, so we need more touchable area for its interaction
    open override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let relativeFrame = self.bounds
        let hitTestEdgeInsets = UIEdgeInsets(top: -increasedTouchRadius,
                                             left: -increasedTouchRadius,
                                             bottom: -increasedTouchRadius,
                                             right: -increasedTouchRadius)
        let hitFrame = relativeFrame.inset(by: hitTestEdgeInsets)
        return hitFrame.contains(point)
    }
    
    // MARK: - Private methods -
    private func setUpView() {
        self.backgroundColor = .clear
    }
    
    private func drawCheckMark(frame: CGRect) {
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: frame.minX + 0.26000 * frame.width, y: frame.minY + 0.50000 * frame.height))
        bezierPath.addCurve(to: CGPoint(x: frame.minX + 0.42000 * frame.width, y: frame.minY + 0.62000 * frame.height),
                            controlPoint1: CGPoint(x: frame.minX + 0.38000 * frame.width, y: frame.minY + 0.60000 * frame.height),
                            controlPoint2: CGPoint(x: frame.minX + 0.42000 * frame.width, y: frame.minY + 0.62000 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.70000 * frame.width, y: frame.minY + 0.24000 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.78000 * frame.width, y: frame.minY + 0.30000 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.44000 * frame.width, y: frame.minY + 0.76000 * frame.height))
        bezierPath.addCurve(to: CGPoint(x: frame.minX + 0.20000 * frame.width, y: frame.minY + 0.58000 * frame.height),
                            controlPoint1: CGPoint(x: frame.minX + 0.44000 * frame.width, y: frame.minY + 0.76000 * frame.height),
                            controlPoint2: CGPoint(x: frame.minX + 0.26000 * frame.width, y: frame.minY + 0.62000 * frame.height))
        checkmarkColor.setFill()
        bezierPath.fill()
    }
    
    private func drawCircle(frame: CGRect) {
        let ovalPath = UIBezierPath(ovalIn: CGRect(x: frame.minX + floor(frame.width * 0.22000 + 0.5),
                                                   y: frame.minY + floor(frame.height * 0.22000 + 0.5),
                                                   width: floor(frame.width * 0.76000 + 0.5) - floor(frame.width * 0.22000 + 0.5),
                                                   height: floor(frame.height * 0.78000 + 0.5) - floor(frame.height * 0.22000 + 0.5)))
        checkmarkColor.setFill()
        ovalPath.fill()
    }
    
    private func drawInnerSquare(frame: CGRect) {
        let padding = self.bounds.width * 0.3
        let innerRect = frame.inset(by: .init(top: padding, left: padding, bottom: padding, right: padding))
        let rectanglePath = UIBezierPath.init(roundedRect: innerRect, cornerRadius: 3)
        checkmarkColor.setFill()
        rectanglePath.fill()
    }
    
    private func drawCross(frame: CGRect) {
        let context = UIGraphicsGetCurrentContext()!
        let group: CGRect = CGRect(x: frame.minX + floor((frame.width - 17.37) * 0.49035 + 0.5),
                                   y: frame.minY + floor((frame.height - 23.02) * 0.51819 - 0.48) + 0.98,
                                   width: 17.37,
                                   height: 23.02)
        
        // Rectangle Drawing
        context.saveGState()
        context.translateBy(x: group.minX + 14.91, y: group.minY)
        context.rotate(by: 35 * CGFloat.pi/180)
        
        let rectanglePath = UIBezierPath(rect: CGRect(x: 0, y: 0, width: 3, height: 26))
        checkmarkColor.setFill()
        rectanglePath.fill()
        
        context.restoreGState()
        
        // Rectangle 2 Drawing
        context.saveGState()
        context.translateBy(x: group.minX, y: group.minY + 1.72)
        context.rotate(by: -35 * CGFloat.pi/180)
        
        let rectangle2Path = UIBezierPath(rect: CGRect(x: 0, y: 0, width: 3, height: 26))
        checkmarkColor.setFill()
        rectangle2Path.fill()
        
        context.restoreGState()
    }
}

extension UICheckBox {
    
    public enum Style {
        case square
        case circle
        case cross
        case tick
    }
    
    public enum BorderStyle {
        case square
        case roundedSquare(radius: CGFloat)
        case rounded
    }
}

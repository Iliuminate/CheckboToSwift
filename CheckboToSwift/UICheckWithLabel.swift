//
//  UICheckWithLabel.swift
//  CheckboToSwift
//
//  Created by Carlos Diaz on 6/11/20.
//

import UIKit

class UICheckBoxWithLabel: UIView {
    
    // MARK: - Private properties -
    private let checkBoxSize: CGSize = CGSize(width: 30, height: 30)
    
    // MARK: - Public properties -
    let label = UILabel()
    let checkBox = UICheckBox()
    weak var delegate: UICheckBoxDelegate?
    
    // MARK: - Lifecycle -
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
        configureStyles()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpView()
        configureStyles()
    }
    
    // MARK: - Private methods -
    private func setUpView() {
        backgroundColor = .white
        self.addSubview(label)
        self.addSubview(checkBox)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        checkBox.translatesAutoresizingMaskIntoConstraints = false
        
        var internalConstraints: [NSLayoutConstraint] = []
        internalConstraints.append(checkBox.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8))
        internalConstraints.append(checkBox.topAnchor.constraint(equalTo: self.topAnchor, constant: 8))
        internalConstraints.append(checkBox.heightAnchor.constraint(equalToConstant: checkBoxSize.height))
        internalConstraints.append(checkBox.widthAnchor.constraint(equalToConstant: checkBoxSize.width))
        internalConstraints.append(label.topAnchor.constraint(equalTo: self.topAnchor, constant: 8))
        internalConstraints.append(label.leadingAnchor.constraint(equalTo: checkBox.trailingAnchor, constant: 4))
        internalConstraints.append(label.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8))
        internalConstraints.append(label.bottomAnchor.constraint(lessThanOrEqualTo: self.bottomAnchor, constant: -8))
        NSLayoutConstraint.activate(internalConstraints)
    }
    
    private func configureStyles() {
        label.numberOfLines = 0
    }
    
    // MARK: - Public methods -
    func configureView(text: String, font: UIFont?) {
        label.text = text
        if let font = font {
            label.font = font
        }
    }
}

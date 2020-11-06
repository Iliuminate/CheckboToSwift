//
//  ViewController.swift
//  CheckboToSwift
//
//  Created by Carlos Diaz on 5/11/20.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addCheckbox1()
        addCheckbox2()
        addCheckBoxWithLabel()
    }

    func addCheckbox1() {
        let rect = CGRect(x: 90, y: 90, width: 30, height: 30)
        let check = UICheckBox(frame: rect)
        check.delegate = self
        view.addSubview(check)
    }
    
    func addCheckbox2() {
        let check = UICheckBox()
        check.delegate = self
        view.addSubview(check)
        
        check.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            check.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 180),
            check.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30),
            check.heightAnchor.constraint(equalToConstant: 60),
            check.widthAnchor.constraint(equalToConstant: 110)
        ]
        NSLayoutConstraint.activate(constraints)

    }
    
    func addCheckBoxWithLabel() {
        let component = UICheckBoxWithLabel()
        component.backgroundColor = .yellow
        component.label.backgroundColor = .cyan
        component.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(component)
        
        component.configureView(text: "Este es un mensaje de prueba para el checkBox", font: nil)
        NSLayoutConstraint.activate([
            component.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            component.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            component.widthAnchor.constraint(equalToConstant: 210),
            component.heightAnchor.constraint(equalToConstant: 190)
        ])
        
    }

}

extension ViewController: UICheckBoxDelegate {
    func selected(state: Bool) {
        print("STATE: \(state)")
    }
}


//
//  ViewController.swift
//  Calculator
//
//  Created by Chung Nguyen on 6/7/22.
//

import UIKit


class ViewController: UIViewController {

    @IBOutlet var tokenTextField: UITextField!
    @IBOutlet var evalTextField: UITextField!
    
    
    @IBOutlet var FuncButtons: [UIButton]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tokenTextField.borderStyle = .none
        evalTextField.borderStyle = .none
        
        for button in FuncButtons {
            button.layer.cornerRadius = 5
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor.black.cgColor
            button.addTarget(self, action: #selector(buttonDidTapped(_:)),
                             for: UIControl.Event.touchUpInside)
        }
    }
    
    @IBAction func buttonDidTapped(_ sender: UIButton) {
        guard let text = sender.titleLabel?.text else { return }
        var curText = tokenTextField.text ?? ""
        let curEval = evalTextField.text ?? ""
        
        if text == "AC" {
            tokenTextField.text = ""
            evalTextField.text = ""
            return
        } else if text == "=" {
            guard !curEval.isEmpty, curEval != "Error" else { return }
            evalTextField.text = ""
            tokenTextField.text = curEval
        } else if text == "<" {
            if curText.count > 0 {
                curText.removeLast()
                tokenTextField.text = curText
            }
        } else {
            tokenTextField.text = curText + text
        }
        
        curText = tokenTextField.text ?? ""
        evalTextField.text = (try? Calculator.shared.calculate(curText)) ?? "Error"
    }
}


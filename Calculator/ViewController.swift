//
//  ViewController.swift
//  Calculator
//
//  Created by Karolina Kafel on 11/12/15.
//  Copyright © 2015 Karolina Kafel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var display: UILabel!
    
    var userIsTyping = false
    
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsTyping {
            display.text = display.text! + digit
        } else {
            display.text = digit
            userIsTyping = true
        }
    }
    
    @IBAction func floatingPoint() {
        if userIsTyping {
            if !display.text!.containsString(".") {
                display.text = display.text! + "."
            }
        } else {
            display.text = "0."
            userIsTyping = true
        }
    }
    
    @IBAction func pi() {
        if userIsTyping {
            enter()
        }
        display.text = M_PI.description
        enter()
    }
    
    @IBAction func operate(sender: UIButton) {
        let operation = sender.currentTitle!
        if userIsTyping {
            enter()
        }
        
        switch operation {
            case "×"  : performOperation { $0 * $1 }
            case "÷"  : performOperation { $1 / $0 }
            case "+"  : performOperation { $0 + $1 }
            case "−"  : performOperation { $1 - $0 }
            case "√"  : performOperation { sqrt($0)}
            case "sin": performOperation { sin($0) }
            case "cos": performOperation { cos($0) }
            default: break
        }
    }
    
    private func performOperation(operation: (Double, Double) -> (Double)) {
        if operandStack.count >= 2 {
            displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
            enter()
        }
    }

    private func performOperation(operation: Double -> Double) {
        if operandStack.count >= 1 {
            displayValue = operation(operandStack.removeLast())
            enter()
        }
    }
    
    var operandStack = Array<Double>()
    
    @IBAction func enter() {
        userIsTyping = false
        operandStack.append(displayValue)
        print("operandStack = \(operandStack)")
    }
    
    var displayValue: Double {
        get {
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set {
            display.text = "\(newValue)"
        }
    }
}


import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    @IBOutlet weak var history: UILabel!

    var userIsTypingNumber = false
    var brain = CalculatorBrain()

    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        append(digit)
    }

    @IBAction func floatingPoint(sender: UIButton) {
        if !display.text!.containsString(".") {
            if (!userIsTypingNumber){
                append("0.")
            } else {
                append(".")
            }
        } else {
            showError("Wrong value")
        }
    }

    
    @IBAction func appendPi(sender: UIButton) {
        enter()
        append("\(M_PI)")
        enter()
    }
    
    func showError(error: String) {
        history.text = error
    }

    func append(sign: String) {
        history.text = ""
        if userIsTypingNumber {
            display.text = display.text! + sign
        } else {
            display.text = sign
            userIsTypingNumber = true
        }
    }

    @IBAction func operate(sender: UIButton) {
        if userIsTypingNumber {
            enter()
        }
        if let operation = sender.currentTitle {
            if let result = brain.performOperation(operation) {
                displayValue = result
            } else {
                showError("Unknown operation")
                displayValue = 0
            }
        }
    }

    @IBAction func clear() {
        brain.clear()
        displayValue = 0
        historyValue = ""
    }

    @IBAction func enter() {
        userIsTypingNumber = false
        if let result = brain.pushOperand(displayValue) {
            displayValue = result
        } else {
            // better solution would be make displayValue optional
            displayValue = 0
        }
    }

    var displayValue: Double {
        get {
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set {
            display.text = "\(newValue)"
        }
    }

    var historyValue: String {
        get {
            return history.text!
        }
        set {
            history.text = newValue
        }
    }
}


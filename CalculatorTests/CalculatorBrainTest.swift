import XCTest

@testable import Calculator

class CalculatorBrainTest: XCTestCase {

    let brain = CalculatorBrain()
    
    func testCanEvaluateOperands() {
        XCTAssertEqual(brain.pushOperand(2), 2);
    }
    
    func testCanAdd() {
        brain.pushOperand(2.2)
        brain.pushOperand(3.2)
        XCTAssertEqual(brain.performOperation("+"), 5.4)
    }
    
    func testCanSubtract() {
        brain.pushOperand(2.2)
        brain.pushOperand(3.2)
        XCTAssertEqual(brain.performOperation("−"), -1)
    }
    
    func testCanMultiply() {
        brain.pushOperand(2)
        brain.pushOperand(3.4)
        XCTAssertEqual(brain.performOperation("×"), 6.8)
    }
    
    func testCanDivide() {
        brain.pushOperand(4)
        brain.pushOperand(2)
        XCTAssertEqual(brain.performOperation("÷"), 2)
    }
    
    func testCanSqrt() {
        brain.pushOperand(4)
        XCTAssertEqual(brain.performOperation("√"), 2)
    }
    
    func testCanClearBrain() {
        brain.pushOperand(4)
        XCTAssertNil(brain.clear())
    }
}

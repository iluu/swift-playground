import Foundation

class CalculatorBrain {

    private enum Op: CustomStringConvertible {
        case Operand(Double)
        case UnaryOperation(String, Double -> Double)
        case BinaryOperation(String, (Double, Double) -> Double)

        // part of CustomStringConvertible protocol contract
        var description: String {
            get {
                switch self {
                case .Operand(let operand):return "\(operand)"
                case .UnaryOperation(let symbol, _):return symbol
                case .BinaryOperation(let symbol, _):return symbol
                }
            }
        }
    }

    private var opStack = [Op]()
    private var knownOps = [String: Op]()

    init() {
        // function inside function, yup possible
        func learnOp(op: Op){
            knownOps[op.description] = op;
        }

        learnOp(Op.BinaryOperation("×", *))
        learnOp(Op.BinaryOperation("÷"){ $1 / $0 })
        learnOp(Op.BinaryOperation("+", +))
        learnOp(Op.BinaryOperation("−"){ $1 - $0 })
        learnOp(Op.UnaryOperation("√", sqrt))
    }

    // structs are passed by value and read-only (arrays, dictionaries, ints)
    // classes are passed by reference
    private func evaluate(ops: [Op]) -> (result:Double?, remainingOps:[Op]) {
        if !ops.isEmpty {
            var remainingOps = ops // copied as its a struct
            let op = remainingOps.removeLast()

            switch op {
            case .Operand(let operand):
                return (operand, remainingOps)
            case .UnaryOperation(_, let operation):
                let operantEval = evaluate(remainingOps)
                if let operant = operantEval.result {
                    return (operation(operant), operantEval.remainingOps)
                }
            case .BinaryOperation(_, let operation):
                let op1Eval = evaluate(remainingOps)
                if let operant1 = op1Eval.result {
                    let op2Eval = evaluate(op1Eval.remainingOps)
                    if let operant2 = op2Eval.result {
                        return (operation(operant1, operant2), op2Eval.remainingOps)
                    }
                }
            }
        }
        return (nil, ops)
    }

    func clear() -> Double? {
        opStack.removeAll()
        return evaluate()
    }

    // returning optional
    func evaluate() -> Double? {
        let (result, remainder) = evaluate(opStack)
        print("\(opStack) = \(result) with \(remainder) left over")
        return result
    }

    func pushOperand(operand: Double) -> Double? {
        opStack.append(Op.Operand(operand))
        return evaluate()
    }

    func performOperation(symbol: String) -> Double? {
        // returns optional, which may or may not be there
        if let operation = knownOps[symbol] {
            opStack.append(operation)
        }
        return evaluate()
    }
}
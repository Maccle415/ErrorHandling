import UIKit

enum TestErrors: Error {
    case errorOne
    case errorTwo
    case errorThree
    case errorFour
    case errorFive
}

struct TestErrorHolder {
    static func testError() throws {
        throw TestErrors.errorFour
    }
}

class RegularError {
    private var recordedError: String = ""
    
    public func errorTestFunc() {
        do {
            try TestErrorHolder.testError()
        } catch TestErrors.errorOne {
            recordedError = "Main error"
        } catch TestErrors.errorTwo {
            recordedError = "Main error"
        } catch TestErrors.errorThree {
            recordedError = "Main error"
        } catch TestErrors.errorFour {
            recordedError = "Non main error"
        } catch TestErrors.errorFive {
            recordedError = "Main error"
        } catch {
            recordedError = "Other error"
        }
        
        print(recordedError)
    }
}

class SwitchError {
    private var recordedError: String = ""
    
    public func errorTestFunc() {
        do {
            try TestErrorHolder.testError()
        } catch {
            guard let testError = error as? TestErrors else {
                recordedError = "Main error"
                return
            }
            
            switch testError {
            case .errorFour:
                recordedError = "Non main error"
            default:
                recordedError = "Main error"
            }
        }
        
        print(recordedError)
    }
}

let regularError = RegularError()
regularError.errorTestFunc()

let switchError = SwitchError()
switchError.errorTestFunc()

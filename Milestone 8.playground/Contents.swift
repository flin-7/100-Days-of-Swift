import UIKit
import Foundation

extension UIView {
    func bounceOut(duration: TimeInterval) {
        UIView.animate(withDuration: duration, animations: { [unowned self] in
            self.transform = CGAffineTransform(scaleX: 0.0001, y: 0.0001)
        }) { _ in
            self.transform = .identity
        }
    }
}

extension Int {
    func times(_ closure: () -> Void) {
        guard self > 0 else {
            print("Number must be positive")
            return
        }
        
        for _ in 0..<self {
            closure()
        }
    }
    
    func times2(_ str: String) {
        guard self > 0 else {
            print("Number must be positive")
            return
        }
        
        for _ in 0..<self {
            print(str)
        }
    }
}

let int1: Int = 5
let int2: Int = -5

int1.times {
    print("Hello")
}

int2.times {
    print("Hello")
}

int1.times2("Hello2")
int2.times2("Hello2")

extension Array where Element: Comparable {
    mutating func remove(item: Element) {
        if let location = self.firstIndex(of: item) {
            self.remove(at: location)
        }
    }
}

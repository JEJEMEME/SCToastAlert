import XCTest
@testable import SCToastAlert

final class SCToastAlertTests: XCTestCase {
    func testExample() throws {
    }
    
    func test() {
        if #available(iOS 13.0, *) {
            var toast = ToastAlert()
            toast.show(title: "Hello World", type: .white())
        } else {
            // Fallback on earlier versions
        }
        
    }
}

import XCTest
@testable import UnitTestDismissTutorial

class UnitTestDismissTutorialTests: XCTestCase {

    func test_HomeViewController_DismissDetailsViewController_LogManagerCalled() throws {
        let dismissExpectation = XCTestExpectation(description: "Should Dismiss DetailsViewController")
        let logManager = LogManagerSpy()
        
        let detailsViewControllerFactoryMock = DetailViewControllerFactoryMock { dismissRunCount in
            XCTAssertEqual(1, logManager.logRunCount)
            XCTAssertEqual(1, dismissRunCount)
            dismissExpectation.fulfill()
        }
        
        let sut = HomeViewController(logManager: logManager, detailsViewControllerFactory: detailsViewControllerFactoryMock)
        
        sut.loadViewIfNeeded()
        
        wait(for: [dismissExpectation], timeout: 10)
    }
}

extension UnitTestDismissTutorialTests {
    
    final class LogManagerSpy: LoggingManager {
        var logRunCount = 0
        func log(text: String) {
            logRunCount += 1
        }
    }
    
    final class DetailViewControllerFactoryMock: DetailsViewControllerFactory {
        let detailsViewController = DetailsViewControllerMock()
        
        init(expectation: @escaping (Int)->()) {
            detailsViewController.expectation = expectation
        }
        
        func create() -> DetailsViewController {
            return detailsViewController
        }
    }
    
    final class DetailsViewControllerMock: DetailsViewController {
        var dismissRunCount = 0
        var isAnimated = false
        var expectation: ((Int)->())?
        
        override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
            dismissRunCount += 1
            isAnimated = flag
            completion?()
            expectation?(dismissRunCount)
        }
    }
}

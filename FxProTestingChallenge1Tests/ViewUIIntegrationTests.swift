import UIKit
import XCTest

final class ViewUIIntegrationTests: XCTestCase {
    func test1() {
        // given the view controller
        
        //when view loads and data is loaded
        
        //then label should display test string
    }
    
    func test3() {
        // given the view controller
        
        //when view loads and loading fails
        
        //then label should display received error
    }
    
    func test2() {
        // given the view controller
        
        //when view loads and loading starts
        
        //then label should display Loading...
        
        //when loading stops
        
        //label should display Loaded (choose success/failure case - does not matter)
    }
}

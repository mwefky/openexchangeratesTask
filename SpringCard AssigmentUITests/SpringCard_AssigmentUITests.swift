//
//  SpringCard_AssigmentUITests.swift
//  SpringCard AssigmentUITests
//
//  Created by Mina Wefky on 27/02/2022.
//

import XCTest
import SpringCard_Assigment
@testable import SpringCard_Assigment
class SpringCard_AssigmentUITests: XCTestCase {

    var mockviewController: CurrenciesListViewController!

      override func setUpWithError() throws {
          continueAfterFailure = false
          self.mockviewController = CurrenciesListViewController()
          self.mockviewController.loadView()
          self.mockviewController.viewDidLoad()
      }

      override func tearDownWithError() throws {
      }

      func testExample() throws {
          let app = XCUIApplication()
          app.launch()
      }

      func testHasATableView() {
          XCTAssertNotNil(mockviewController.CurrenciesTableView)
      }
      
      func testTableViewHasDelegate() {
          XCTAssertNotNil(mockviewController.CurrenciesTableView.delegate)
      }
      
      func testTableViewConfromsToTableViewDelegateProtocol() {
             XCTAssertTrue(mockviewController.conforms(to: UITableViewDelegate.self))
      }
      
      func testTableViewHasDataSource() {
          XCTAssertNotNil(mockviewController.CurrenciesTableView.dataSource)
      }
      
      func testTableViewConformsToTableViewDataSourceProtocol() {
          XCTAssertTrue(mockviewController.conforms(to: UITableViewDataSource.self))
          XCTAssertTrue(mockviewController.responds(to: #selector(mockviewController.tableView(_:numberOfRowsInSection:))))
          XCTAssertTrue(mockviewController.responds(to: #selector(mockviewController.tableView(_:cellForRowAt:))))
      }
      
      func testTableViewCellHasReuseIdentifier() {
             let cell = mockviewController.tableView(mockviewController.CurrenciesTableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? CurrencyRateTableViewCell
             let actualReuseIdentifer = cell?.reuseIdentifier
             let expectedReuseIdentifier = "CurrencyRateTableViewCell"
             XCTAssertEqual(actualReuseIdentifer, expectedReuseIdentifier)
      }
      
      func testLaunchPerformance() throws {
          if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
              // This measures how long it takes to launch your application.
              measure(metrics: [XCTApplicationLaunchMetric()]) {
                  XCUIApplication().launch()
              }
          }
      }
}

//
//  TravisTestTests.swift
//  TravisTestTests
//
//  Created by Michael Updegraff on 12/23/15.
//  Copyright © 2015 Michael Updegraff. All rights reserved.
//

import XCTest
@testable import TravisTest

class TravisTestTests: XCTestCase {
    
  let dict: [String: AnyObject] = ["title": "Title Test", "eyebrow": "Eyebrow Test", "date": ""]
  
  var event = Event?()
  
  func testEventValues() {
    
    event = Event(dictionary: dict)
    
    let name = event!.name
    let expectedName = "Title Test"
    XCTAssertEqual(expectedName, name!, "the value should be Title Test")
    
    let eyebrow = event!.eyebrow
    let expectedEyebrow = "Eyebrow Test"
    XCTAssertEqual(expectedEyebrow, eyebrow!, "the value should be Title Test")
    
  }
  
  func testAsynchronousURLConnection() {
    
    let URL = NSURL(string: "https://upworks.io/api/events/event_listing.events.json")!
    let expectation = expectationWithDescription("GET \(URL)")
    
    let session = NSURLSession.sharedSession()
    let task = session.dataTaskWithURL(URL) { data, response, error in
      XCTAssertNotNil(data, "data should not be nil")
      XCTAssertNil(error, "error should be nil")
      
      if let HTTPResponse = response as? NSHTTPURLResponse,
        responseURL = HTTPResponse.URL,
        MIMEType = HTTPResponse.MIMEType
      {
        XCTAssertEqual(responseURL.absoluteString, URL.absoluteString, "HTTP response URL should be equal to original URL")
        XCTAssertEqual(HTTPResponse.statusCode, 200, "HTTP response status code should be 200")
        XCTAssertEqual(MIMEType, "application/json", "HTTP response content type should be application/json")
      } else {
        XCTFail("Response was not NSHTTPURLResponse")
      }
      
      expectation.fulfill()
    }
    
    task.resume()
    
    waitForExpectationsWithTimeout(task.originalRequest!.timeoutInterval) { error in
      if let error = error {
        print("Error: \(error.localizedDescription)")
      }
      task.cancel()
    }
  }
  
}

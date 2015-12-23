//
//  EventClient.swift
//  TravisTest
//
//  Created by Michael Updegraff on 12/23/15.
//  Copyright © 2015 Michael Updegraff. All rights reserved.
//

import Foundation
typealias ServerResponseCallback = (events: Array<Event>?, error: NSError?) -> Void

class EventClient {
  
  static let errorDomain = "EventClientErrorDomain"
  
  static let baseURLString = "https://upworks.io"
  
  static let eventsPath = "/api/events/event_listing.events.json"
  
  class func eventslist(callback: ServerResponseCallback) {
    
    let URLString = baseURLString + eventsPath
    let URL = NSURL(string: URLString)
    
    if URL == nil {
      let error = NSError(domain: errorDomain, code: 0, userInfo: [NSLocalizedDescriptionKey : "Unable to create URL"])
      callback(events: nil, error: error)
    }
    
    let request = NSMutableURLRequest(URL: URL!)
    
    let session = NSURLSession.sharedSession()
    
    request.HTTPMethod = "GET"
    
    let task = session.dataTaskWithRequest(request) { data, response, error in
      
      guard data != nil else {
        // replace with logging call
        print("no data found: \(error)")
        callback(events: nil, error:error)
        return
      }
      
      do {
        
        if let json = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? Dictionary<String, AnyObject> {
          
          dispatch_async(dispatch_get_main_queue()) {
            
            var eventArray = Array<Event>()
            
            let currentEventsArray = (json as NSDictionary).valueForKey("currentEvents") as? Array<Dictionary<String, AnyObject>>
            
            let pastEventsArray = (json as NSDictionary).valueForKey("pastEvents") as? Array<Dictionary<String, AnyObject>>
            
            if let constArrayCurrent = currentEventsArray {
              
              for value in constArrayCurrent {
                
                let event = Event(dictionary: value)
                
                eventArray.append(event)
                
              }
              
            }
            
            if let constArrayPast = pastEventsArray {
              
              for value in constArrayPast {
                
                let event = Event(dictionary: value)
                
                eventArray.append(event)
                
              }
              
            }
            
            callback(events: eventArray, error:nil)
            
          }
          
        } else {
          
          dispatch_async(dispatch_get_main_queue()) {
            
            // replace with logging call
            
            print("Error could not parse JSON")
            
            callback(events: nil, error:error)
            
          }
          
        }
        
      } catch let parseError {
        
        dispatch_async(dispatch_get_main_queue()) {
          
          // replace with logging call
          
          print("Error could not parse JSON: '\(parseError)'")
        }
        
      }
      
    }
    
    task.resume()
    
  }
  
}

//
//  Event.swift
//  TravisTest
//
//  Created by Michael Updegraff on 12/23/15.
//  Copyright © 2015 Michael Updegraff. All rights reserved.
//
import Foundation

class Event {
  
  var name: String? = ""
  
  var eyebrow: String? = ""
  
  var dateYYYY: String? = ""
  
  var dateMM: String? = ""
  
  var dateDD: String? = ""
  
  var dateDOW: String? = ""
  
  init(dictionary: Dictionary<String, AnyObject>) {
    
    self.name = dictionary["title"] as? String
    
    self.eyebrow = dictionary["eyebrow"] as? String
    
    let logistics = dictionary["date"] as? Dictionary<String, AnyObject>
    if let constLogistics = logistics {
      
      self.dateYYYY = constLogistics["year"] as? String
      
      self.dateMM = constLogistics["month"] as? String
      
      self.dateDD = constLogistics["date"] as? String
      
      self.dateDOW = constLogistics["day"] as? String
    }
  }
  
}

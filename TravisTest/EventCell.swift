//
//  EventCell.swift
//  TravisTest
//
//  Created by Michael Updegraff on 12/23/15.
//  Copyright © 2015 Michael Updegraff. All rights reserved.
//

import UIKit

class EventCell: UITableViewCell {
  
  var task: NSURLSessionDataTask?
  
  @IBOutlet weak var nameLabel: UILabel?
  @IBOutlet weak var eyebrowLabel: UILabel?
  
  var event: Event? {
    didSet {
      
      if let constEvent = event {
        
        self.nameLabel?.text = constEvent.name
        
        self.eyebrowLabel?.text = constEvent.eyebrow
        
      }
    }
  }
  
  deinit {
    self.task?.cancel()
    self.task = nil
  }
  
  override func prepareForReuse() {
    self.nameLabel?.text = ""
    self.task?.cancel()
    self.task = nil
  }
  
}
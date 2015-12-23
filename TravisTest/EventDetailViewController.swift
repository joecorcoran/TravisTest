//
//  EventDetailViewController.swift
//  TravisTest
//
//  Created by Michael Updegraff on 12/23/15.
//  Copyright © 2015 Michael Updegraff. All rights reserved.
//

import UIKit

class EventDetailViewController: UIViewController {
  
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var eyebrowLabel: UILabel!
  
  var event =  Event?()
  
  var contextData = NSMutableDictionary()
  
  override func viewDidLoad() {
    
    super.viewDidLoad()
    
    self.setupView()
    
  }
  
  func setupView() {
    
    self.title = "Event Detail"
    
    if let constEvent = event {
      
      self.nameLabel?.text = constEvent.name
      
      self.eyebrowLabel?.text = constEvent.eyebrow
      
      self.contextData["EventName"] = constEvent.name
      
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
}


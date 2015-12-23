//
//  EventsViewController.swift
//  TravisTest
//
//  Created by Michael Updegraff on 12/23/15.
//  Copyright © 2015 Michael Updegraff. All rights reserved.
//

import UIKit

class EventsViewController: UIViewController, UITableViewDataSource {
  
  @IBOutlet var tableView: UITableView?
  
  var items: Array<Event> = []
  
  var contextData = NSMutableDictionary()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.title = "Travis Events"
    
    self.setupTableView()
    
    self.refreshItems()
    
  }
  
  // MARK: Setup
  
  func setupTableView() {
    let nib = UINib(nibName: "EventCell", bundle: nil)
    self.tableView?.registerNib(nib, forCellReuseIdentifier: NSStringFromClass(EventCell.self))
    self.tableView?.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.items.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCellWithIdentifier(NSStringFromClass(EventCell.self)) as! EventCell
    
    let event = self.items[indexPath.row]
    cell.event = event
    
    return cell
  }
  
  func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
    
    let eventDetailViewController = EventDetailViewController(nibName: "EventDetailViewController", bundle: nil)
    
    eventDetailViewController.event = self.items[indexPath.row]
    
    self.navigationController?.pushViewController(eventDetailViewController, animated: true)
    
  }
  
  func refreshItems() {
    
    EventClient.eventslist { (events, error) -> Void in
      
      if events != nil {
        
        self.items = events!
        
        self.tableView?.reloadData()
        
        self.contextData["EventsDisplayedCount"] = self.items.count
                
      }
      else {
        // TODO: Update user
        // TODO: Report error in analytics
        
      }
    }
  }
  
}


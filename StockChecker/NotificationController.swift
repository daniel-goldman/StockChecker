//
//  NotificationController.swift
//  StockChecker
//
//  Created by Daniel on 2/6/17.
//  Copyright © 2017 Daniel. All rights reserved.
//

import UIKit
import UserNotifications

class NotificationController {
    
    let identifier = "StockNotification"
    let center = UNUserNotificationCenter.current()
    let content = UNMutableNotificationContent()
    var request: UNNotificationRequest?
    var trigger: UNTimeIntervalNotificationTrigger?
    
    init() {
        
    }
    
    func requestAuth() {
        
        // Request user permission for notifications
        center.requestAuthorization(options:[.alert, .sound]) { (granted, error) in
            // Enable or disable features based on authorization.
            print("callback")
            //self.setDefaults()
        }
    }
    
    func setDefaults() {
        
        content.title = NSString.localizedUserNotificationString(forKey: "Title", arguments: nil)
        content.body = NSString.localizedUserNotificationString(forKey: "Body", arguments: nil)
        content.sound = UNNotificationSound.default()
        
        trigger = UNTimeIntervalNotificationTrigger(timeInterval: 0.1, repeats: false)
        
        // Instantiate the request object.
        request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
    }
    
    func setTitle(_ title: String) {
        
        content.title = title
        request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
    }
    
    func setBody(_ body: String) {
        
        content.body = body
        request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
    }
    
    func fire() {
        
        self.center.add(request!, withCompletionHandler: nil)
    }
}

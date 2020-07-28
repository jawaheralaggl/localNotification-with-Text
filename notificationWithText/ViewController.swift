//
//  ViewController.swift
//  notificationWithText
//
//  Created by Jawaher Alagel on 7/24/20.
//  Copyright © 2020 Jawaher Alaggl. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nc = NotificationCenter.default
        
        nc.addObserver(self, selector: #selector(updateLabelContent), name: Notification.Name("textToview"), object: nil)
    }
    
    
    
    @IBOutlet weak var messageLabel: UILabel!
    @IBAction func setButton(_ sender: Any) {
        
        let center = UNUserNotificationCenter.current()
        let content = UNMutableNotificationContent()
        content.title = "You have New Message!"
        content.body = "Check Now"
        content.sound = .default
        
        
        // Set text action to take input
        let categoryIdentifier = "message.action"
        let reply = UNTextInputNotificationAction(identifier: "reply.action", title: "Reply", options: [], textInputButtonTitle: "Send", textInputPlaceholder: "type...")
        let cancel = UNNotificationAction(identifier: "cancel.action", title: "Cancel", options: [])
        
        let category = UNNotificationCategory(identifier: categoryIdentifier, actions: [reply, cancel], intentIdentifiers: [], options: [])
        UNUserNotificationCenter.current().setNotificationCategories([category])
        
        content.categoryIdentifier = categoryIdentifier
        
        
        
        let notiDate = Calendar.current.dateComponents([.day, .month, .year, .hour, .minute, .second], from: Date().addingTimeInterval(10))
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: notiDate, repeats: true)
        let request = UNNotificationRequest(identifier: "reminder", content: content, trigger: trigger)
        center.add(request) { (error) in
            if error != nil {
                print("error:\(error?.localizedDescription ?? "Error Local Notification" )")
                
            }
        }
        
    }
    
    
    @objc func updateLabelContent() {
        if UserDefaults.standard.value(forKey: "reply.action") != nil {
            messageLabel.text = UserDefaults.standard.value(forKey: "reply.action") as? String ?? ""
            UserDefaults.standard.removeObject(forKey: "reply.action")
        }
    }
    
    
}


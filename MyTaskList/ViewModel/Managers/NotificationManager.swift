//
//  NotificationManager.swift
//  MyTaskList
//
//  Created by Tony Chen on 27/5/2023.
//

import Foundation
import UserNotifications
import UIKit

struct Configure {
    static var selectedNotificationId: String = ""
}

class NotificationManager {
    private let notificationCenter = UNUserNotificationCenter.current()
    var notificationId = UUID().uuidString

    // Add to View controller
    func notificationPermission(vc: UIViewController) {
        notificationCenter.requestAuthorization(options: [.alert, .badge, .sound]) { (permissionGranted, error) in
            DispatchQueue.main.async {
                if !permissionGranted {
                    //print("Permission Denied")
                }
            }
        }
    }
    
    // MARK: Notification schedule add to button action
    func dispatchNotification(title: String,body: String, date: Date) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default
        let fromDate = date.addingTimeInterval(10)

        let dateComp = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: fromDate)

        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComp, repeats: false)

        let request = UNNotificationRequest(identifier: notificationId,
                                            content: content,
                                            trigger: trigger)
        self.notificationCenter.add(request) { (error) in
            if error != nil {
                print("Error:" + error.debugDescription)
                return
            }
        }
    }
    
    func deletePendingNotification(notificationId: String) {
        notificationCenter.getPendingNotificationRequests(completionHandler: { requests in
            for request in requests {
                let identifiers = [request.identifier]
                if identifiers.contains(notificationId) {
                    self.notificationCenter.removePendingNotificationRequests(withIdentifiers: identifiers)
                }
            }
        })
    }
    
    // MARK: Get notification identifier list
    func notificationList() {
        UNUserNotificationCenter.current().getPendingNotificationRequests { notificationRequests in
            for request in notificationRequests {
                let identifier = request.identifier
//                let content = request.content
//                let trigger = request.trigger

                // Process each pending notification as needed
                print("Identifier: \(identifier)")
//                print("Content: \(content)")
//                print("Trigger: \(trigger)")
            }
        }
    }
}

//
//  AlertManager.swift
//  MyTaskList
//
//  Created by Tony Chen on 5/6/2023.
//

import Foundation
import UIKit

struct Alert {
    
    // MARK: Open Setting app scren
    /// Open setting screen
    private func openSettings() {
        if let url = URL.init(string: UIApplication.openSettingsURLString) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    /// Open app notification setting screen
    private func openNotificationSetting() {
        guard let setttingsURL = URL(string: UIApplication.openSettingsURLString)
        else
        {
            return
        }
        
        if UIApplication.shared.canOpenURL(setttingsURL)
        {
            UIApplication.shared.open(setttingsURL) { (_) in}
        }
    }
    
    // MARK: Alert functions
    /// Enable notfication alert
    private static func showEnableNotificationAlert(on vc: UIViewController,
                                                    with title: String,
                                                    message: String)
    {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        let settingAction = UIAlertAction(title: Theme.ButtonLabel.settingButton,
                                          style: .cancel,
                                          handler: { action in
            let alert = Alert()
            alert.openNotificationSetting()
            
        })
        let dismissAction = UIAlertAction(title: Theme.ButtonLabel.dismissbutton,
                                          style: .default)
        
        alert.addAction(settingAction)
        alert.addAction(dismissAction)
        vc.present(alert, animated: true)
    }
    
    /// Confirmation alert when user delete task
    static func deleteTaskAlert(on vc: UIViewController,
                                        with title: String,
                                        message: String,
                                        onSelectTask: @escaping () -> Void)
    {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)

        let deleteAction = UIAlertAction(title: Theme.ButtonLabel.deleteButton,
                                         style: .destructive,
                                         handler: { action in
            onSelectTask()
        })
        let dismissAction = UIAlertAction(title: Theme.ButtonLabel.dismissbutton,
                                          style: .default)
        
        alert.addAction(deleteAction)
        alert.addAction(dismissAction)
        vc.present(alert, animated: true)
    }
    
    /// Discard changes alert
    static func discardChangeAlert(on vc: UIViewController,
                                   with title: String,
                                   message: String,
                                   onAction: @escaping () -> Void)
    {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        let keepEditAction = UIAlertAction(title: Theme.ButtonLabel.keepEditButton,
                                           style: .cancel)
        let discardAction = UIAlertAction(title: Theme.ButtonLabel.discardChangesbutton,
                                          style: .destructive, handler: { action in
            
            onAction()
    })
        alert.addAction(keepEditAction)
        alert.addAction(discardAction)
        vc.present(alert, animated: true)
    }
    
    /// Dismiss open edit task controller
    static func disableEditTaskAlert(on vc: UIViewController,
                                     with title: String,
                                     message: String) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        let dismissButton = UIAlertAction(title: Theme.ButtonLabel.dismissbutton,
                                          style: .default)
        alert.addAction(dismissButton)
        vc.present(alert, animated: true)
    }
    
    
    // MARK: Display enable notification alert when notification is denied or notDetermined
    static func showNotificationDenyAlert(on vc: UIViewController) {
        showEnableNotificationAlert(on: vc,
                                    with: Theme.Text.enableNotificationTitle,
                                    message: Theme.Text.enableNotificationBody)
    }
    
    // MARK: Display discard change alert when user updated from and press close button
    static func showDiscardChangeAlert(on vc: UIViewController) {
        discardChangeAlert(on: vc,
                           with: Theme.Text.discardChangeAlertTitle,
                           message: Theme.Text.discardChangeAlertBody) {
            vc.dismiss(animated: true)
        }
    }
    
    static func showDisableEditTaskAlert(on vc: UIViewController) {
        disableEditTaskAlert(on: vc, with: Theme.Text.cantEditTaskTitle,
                             message: Theme.Text.cantEditTaskBody)
    }
    
}

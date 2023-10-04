//
//  TaskTableView.swift
//  MyTaskList
//
//  Created by Tony Chen on 17/5/2023.
//

import Foundation
import UIKit

extension ViewTaskController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        91
    }
    
    /// Tap on task row to view selected task
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let text = realmManager.taskData[indexPath.row]
        let taskNotificationId = realmManager.taskData[indexPath.row].notificationId ?? ""
        selectedNotificationId = taskNotificationId
        
        let rootViewSelectTaskScreen = ViewSelectTaskScreen()
        rootViewSelectTaskScreen.task = text
        
        // Save task and back to view task screen
        rootViewSelectTaskScreen.saveComplitionHandler = { [weak self] in
            self?.realmManager.readData()
            self?.tableView.reloadData()
        }
        
        // Delete task and back to view task screen
        rootViewSelectTaskScreen.deleteComplitionHandler = { [weak self] in
            self?.realmManager.readData()
            self?.tableView.reloadData()
        }
        
        let viewSelectTaskScreen = UINavigationController(rootViewController: rootViewSelectTaskScreen)
        present(viewSelectTaskScreen, animated: true)
    }
}

extension ViewTaskController: UITableViewDataSource {
    /// Display number of sections
      func numberOfSections(in tableView: UITableView) -> Int {
          return 2
      }
    
    /// Display number of rows for each section
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            switch section {
            case 0:
                return realmManager.taskData.count
            case 1:
                return 0
            default:
                return 0
            }
        }
    
    /// Display section header
     func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
         switch section {
         case 0:
             return Theme.Text.toDoListSectionTitle
         case 1:
             return Theme.Text.completedSectionTitle
         default:
             return Theme.Text.emptyText
         }
     }
    
    /// Display cell content for each row task
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TaskCell.taskCellIdentifier, for: indexPath) as? TaskCell else {
            return UITableViewCell()
        }
        let task = realmManager.taskData[indexPath.row]
        if let dateValue = task.reminderMeDate {
            cell.displayReminderMeDate(date: dateValue)
        }
        
        cell.configureCell(taskTitle: task.title)
        cell.configureFlag(showImage: task.flag)
        return cell
    }
    
    /// Swipe cell to delete task
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let task = realmManager.taskData[indexPath.row]
        selectedNotificationId = task.notificationId ?? ""
        /// Delete task action
        let deleteAction = UIContextualAction(style: .destructive, title: Theme.ButtonLabel.deleteButton) { [weak self] (action, view, completionHandler) in
            self?.realmManager.deleteData(at: indexPath)
            self?.notificationManager.deletePendingNotification(notificationId: selectedNotificationId)
            tableView.deselectRow(at: indexPath, animated: true)
            self?.realmManager.readData()
            tableView.reloadData()
            completionHandler(true)
        }
        
        /// Add & remove flag action
        let flagTitle = task.flag ? Theme.Text.unflagLabel : Theme.Text.flagLabel
        let flagAction = UIContextualAction(style: .normal, title: flagTitle) { [weak self] (action, view, completionHandler) in
            let cell = tableView.cellForRow(at: indexPath) as! TaskCell
            let flag = task.flag ? false : true
            self?.realmManager.updateFlagData(id: task.id, flag: flag)
            cell.configureFlag(showImage: task.flag)
            tableView.reloadData()
            completionHandler(true)
        }
        
        deleteAction.image = UIImage(systemName: Theme.images.trash)
        let flag = UIImage(systemName: Theme.images.flag)
        let unflag = UIImage(systemName: Theme.images.unflag)
        let flagImage = task.flag ? unflag : flag
        flagAction.image = flagImage
        flagAction.backgroundColor = Theme.Colours.orange
        return UISwipeActionsConfiguration(actions: [deleteAction, flagAction])
    }
}

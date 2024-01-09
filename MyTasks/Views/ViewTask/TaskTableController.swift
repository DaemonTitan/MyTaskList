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
        110
    }
    
    /// Tap on task row to view selected task
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        /// Task  List section
        case 0:
            tableView.deselectRow(at: indexPath, animated: true)
            let text = realmManager.taskData[indexPath.row]
            let taskNotificationId = realmManager.taskData[indexPath.row].notificationId ?? ""
            Configure.selectedNotificationId = taskNotificationId
            
            let rootViewSelectTaskScreen = ViewSelectTaskScreen()
            rootViewSelectTaskScreen.task = text
            
            // Save task and back to view task screen
            rootViewSelectTaskScreen.saveComplitionHandler = { [weak self] in
                self?.realmManager.viewOpenedTask()
                self?.realmManager.viewCompletedTask()
                self?.tableView.reloadData()
            }
            
            // Delete task and back to view task screen
            rootViewSelectTaskScreen.deleteComplitionHandler = { [weak self] in
                self?.realmManager.viewOpenedTask()
                self?.realmManager.viewCompletedTask()
                self?.tableView.reloadData()
            }
            
            let viewSelectTaskScreen = UINavigationController(rootViewController: rootViewSelectTaskScreen)
            present(viewSelectTaskScreen, animated: true)

        /// Completed section
        case 1:
            tableView.deselectRow(at: indexPath, animated: true)
            Alert.showDisableEditTaskAlert(on: self)
            
        default:
            fatalError("Section not exists")
        }
    }
}

extension ViewTaskController: UITableViewDataSource {
    /// Display number of sections
      func numberOfSections(in tableView: UITableView) -> Int {
          return 2
      }
    
    /// Display number of rows for each section
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            if realmManager.taskData.count == 0 && realmManager.completeTaskData.count == 0 {
                taskTableViewModel.noRecordsFoundSetup(view: view, tableView: tableView)
            } else {
                taskTableViewModel.restoreTableView()
                switch section {
                /// Task List section
                case 0:
                    return realmManager.taskData.count
                /// Completed section
                case 1:
                    return realmManager.completeTaskData.count
                default:
                    return 0
                }
            }
            return 0
        }
    
    /// Display section header
     func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
         switch section {
         /// Task List section
         case 0:
             if realmManager.taskData.count > 0 {
                 return Theme.Text.taskListSectionTitle
             } else {
                 return Theme.Text.emptyText
             }
         /// Completed section
         case 1:
             if realmManager.completeTaskData.count > 0 {
                 return Theme.Text.completedSectionTitle
             } else {
                 return Theme.Text.emptyText
             }
         default:
             return Theme.Text.emptyText
         }
     }
    
    /// Display cell content for each row task
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TaskCell.taskCellIdentifier, for: indexPath) as? TaskCell else {
            return UITableViewCell()
        }

        switch indexPath.section {
        /// Task List section
        case 0:
            // MARK: Configure To - Do section
            let task = realmManager.taskData[indexPath.row]
            if let dateValue = task.reminderMeDate {
                cell.displayReminderMeDate(date: dateValue)
            }
            cell.configureTaskTitle(taskTitle: task.title)
            cell.configurePriority(priority: task.priority)
            cell.configureFlag(showImage: task.flag)
            cell.configureCompleteButton(imageName: Theme.Images.buttonSquare,
                                         size: 25.0,
                                         color: Theme.Colours.lightGray,
                                         state: .normal)
            
            cell.buttonTapCallBack = { [weak self] in
                guard let self = self else {return}
                /// Delete notification from Pending notification list
                self.notificationManager.deletePendingNotification(notificationId: task.notificationId ?? "")
                /// Update task status to complete and write closed date
                self.realmManager.completeTask(id: task.id,
                                               taskStatus: true,
                                               flag: false,
                                               datePickerIsOn: false,
                                               closeDate: Date(),
                                               reminderMeDate: nil,
                                               notifyId: "")
                
                //MARK: Move task from Task Data Array to Complete Task Data Array
                /// Remove selected data from Task Data Array
                let selectedTaskData = self.realmManager.taskData.remove(at: indexPath.row)
                /// Delete selected row from table view
                self.tableView.deleteRows(at: [indexPath], with: .fade)
                /// Append removed row to Completed section
                self.realmManager.completeTaskData.append(selectedTaskData)
                self.tableView.reloadData()
            }
        
        /// Completed section
        case 1:
            // MARK: Configure Completed section
            let task = realmManager.completeTaskData[indexPath.row]
            cell.completedTaskTitle(taskTitle: task.title)
            cell.configureFlag(showImage: false)
            cell.configureCompleteButton(imageName: Theme.Images.buttonSqureCheckmark,
                                         size: 25.0,
                                         color: Theme.Colours.green,
                                         state: .normal)
            
            
            cell.buttonTapCallBack = { [weak self] in
                guard let self = self else {return}
                /// Update task status to reopen task and write closed date to nil
                //self.realmManager.completeTask(id: task.id, taskStatus: false, closeDate: nil, notifyId: "")
                self.realmManager.reopenTask(id: task.id, taskStatus: false, closeDate: nil)
                
                //MARK: Move task from Complete Task Data Array to Task Data Array
                /// Remove selected data from Completed Data Array
                let selectedCompleteTask = self.realmManager.completeTaskData.remove(at: indexPath.row)
                /// Delete selected row from table view
                self.tableView.deleteRows(at: [indexPath], with: .fade)
                /// Append removed row to To-do section
                self.realmManager.taskData.append(selectedCompleteTask)
                self.tableView.reloadData()
            }
            
        default:
            fatalError("No sections")
        }
        return cell
    }
    
    /// Swipe cell to delete task
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        switch indexPath.section {
        /// Task List section
        case 0:
            let task = realmManager.taskData[indexPath.row]
            Configure.selectedNotificationId = task.notificationId ?? ""
            /// Delete task action
            let deleteAction = UIContextualAction(style: .destructive, title: Theme.ButtonLabel.deleteButton) { [weak self] (action, view, completionHandler) in
                self?.realmManager.deleteTaskData(at: indexPath)
                self?.notificationManager.deletePendingNotification(notificationId: Configure.selectedNotificationId)
                tableView.deselectRow(at: indexPath, animated: true)
                self?.realmManager.viewOpenedTask()
                self?.realmManager.viewCompletedTask()
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
            
            deleteAction.image = UIImage(systemName: Theme.Images.trash)
            let flag = UIImage(systemName: Theme.Images.flagFill)
            let unflag = UIImage(systemName: Theme.Images.unflag)
            let flagImage = task.flag ? unflag : flag
            flagAction.image = flagImage
            flagAction.backgroundColor = Theme.Colours.orange
            return UISwipeActionsConfiguration(actions: [deleteAction, flagAction])
            
        /// Completed section
        case 1:
            let completedtask = realmManager.completeTaskData[indexPath.row]
            Configure.selectedNotificationId = completedtask.notificationId ?? ""
            /// Delete task action
            let deleteAction = UIContextualAction(style: .destructive, title: Theme.ButtonLabel.deleteButton) { [weak self] (action, view, completionHandler) in
                self?.realmManager.deleteCompleteTaskData(at: indexPath)
                self?.notificationManager.deletePendingNotification(notificationId: Configure.selectedNotificationId)
                tableView.deselectRow(at: indexPath, animated: true)
                self?.realmManager.viewOpenedTask()
                self?.realmManager.viewCompletedTask()
                tableView.reloadData()
                completionHandler(true)
            }
            
            deleteAction.image = UIImage(systemName: Theme.Images.trash)
            return UISwipeActionsConfiguration(actions: [deleteAction])
            
        default:
            fatalError("No sections")
        }
    }
}

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
        switch indexPath.section {
        case 0:
            tableView.deselectRow(at: indexPath, animated: true)
            let text = realmManager.taskData[indexPath.row]
            let taskNotificationId = realmManager.taskData[indexPath.row].notificationId ?? ""
            selectedNotificationId = taskNotificationId
            
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
                taskTableViewModel.restore()
                switch section {
                case 0:
                    return realmManager.taskData.count
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
         case 0:
             if realmManager.taskData.count > 0 {
                 return Theme.Text.toDoListSectionTitle
             } else {
                 return Theme.Text.emptyText
             }
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
        case 0:
            // MARK: Configure To - Do section
            let task = realmManager.taskData[indexPath.row]
            if let dateValue = task.reminderMeDate {
                cell.displayReminderMeDate(date: dateValue)
            }
            cell.configureCell(taskTitle: task.title)
            cell.configureFlag(showImage: task.flag)
            cell.configureCompleteButton(imageName: "square",
                                         size: 25.0,
                                         color: Theme.Colours.lightGray,
                                         state: .normal)
            
            cell.buttonTapCallBack = { [weak self] in
                guard let self = self else {return}
                /// Update task status to complete and write closed date
                self.realmManager.completeTask(id: task.id, taskStatus: true, closeDate: Date())
                
                //MARK: Move task from Task Data Array to Complete Task Data Array
                /// Remove selected data from Task Data Array
                let selectedTaskData = self.realmManager.taskData.remove(at: indexPath.row)
                /// Delete selected row from table view
                self.tableView.deleteRows(at: [indexPath], with: .fade)
                /// Append removed row to Completed section
                self.realmManager.completeTaskData.append(selectedTaskData)
                self.tableView.reloadData()
                
                //let insertCompleteTaskIndexPath = IndexPath(row: self.realmManager.completeTaskData.count - 1 , section: 1)
//                if self.realmManager.completeTaskData.count == 0 {
//                    self.tableView.insertRows(at: [IndexPath(row: 0, section: 1)], with: .fade)
//                } else {
//                    self.tableView.insertRows(at: [insertCompleteTaskIndexPath], with: .fade)
//                }
                //self.tableView.insertRows(at: [insertCompleteTaskIndexPath], with: .fade)
            }
            
        case 1:
            // MARK: Configure Completed section
            let task = realmManager.completeTaskData[indexPath.row]
            cell.configureCell(taskTitle: task.title)
            cell.configureFlag(showImage: false)
            
            cell.configureCompleteButton(imageName: "checkmark.square.fill",
                                         size: 25.0,
                                         color: Theme.Colours.green,
                                         state: .normal)
            
            
            cell.buttonTapCallBack = { [weak self] in
                guard let self = self else {return}
                /// Update task status to Uncomplete and write closed date to nil
                self.realmManager.completeTask(id: task.id, taskStatus: false, closeDate: nil)
                //MARK: Move task from Complete Task Data Array to Task Data Array
                /// Remove selected data from Completed Data Array
                let selectedCompleteTask = self.realmManager.completeTaskData.remove(at: indexPath.row)
                /// Delete selected row from table view
                self.tableView.deleteRows(at: [indexPath], with: .fade)
                /// Append removed row to To-do section
                self.realmManager.taskData.append(selectedCompleteTask)
                self.tableView.reloadData()
                
//                let insertTaskIndexPath = IndexPath(row: self.realmManager.taskData.count - 1, section: 0)
//                self.tableView.insertRows(at: [insertTaskIndexPath], with: .fade)
            }
            
        default:
            fatalError("No sections")
        }
        
        return cell
    }
    
    /// Swipe cell to delete task
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let task = realmManager.taskData[indexPath.row]
        selectedNotificationId = task.notificationId ?? ""
        
        switch indexPath.section {
        case 0:
            /// Delete task action
            let deleteAction = UIContextualAction(style: .destructive, title: Theme.ButtonLabel.deleteButton) { [weak self] (action, view, completionHandler) in
                self?.realmManager.deleteData(at: indexPath)
                self?.notificationManager.deletePendingNotification(notificationId: selectedNotificationId)
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
            
            deleteAction.image = UIImage(systemName: Theme.images.trash)
            let flag = UIImage(systemName: Theme.images.flag)
            let unflag = UIImage(systemName: Theme.images.unflag)
            let flagImage = task.flag ? unflag : flag
            flagAction.image = flagImage
            flagAction.backgroundColor = Theme.Colours.orange
            return UISwipeActionsConfiguration(actions: [deleteAction, flagAction])
            
        case 1:
            /// Delete task action
            let deleteAction = UIContextualAction(style: .destructive, title: Theme.ButtonLabel.deleteButton) { [weak self] (action, view, completionHandler) in
                self?.realmManager.deleteData(at: indexPath)
                self?.notificationManager.deletePendingNotification(notificationId: selectedNotificationId)
                tableView.deselectRow(at: indexPath, animated: true)
                self?.realmManager.viewOpenedTask()
                self?.realmManager.viewCompletedTask()
                tableView.reloadData()
                completionHandler(true)
            }
            
            deleteAction.image = UIImage(systemName: Theme.images.trash)
            return UISwipeActionsConfiguration(actions: [deleteAction])
            
        default:
            fatalError("No sections")
        }
    }
}

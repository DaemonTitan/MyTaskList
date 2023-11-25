//
//  RealmManager.swift
//  MyTaskList
//
//  Created by Tony Chen on 16/5/2023.
//

import Foundation
import RealmSwift

class RealmManager {
    var taskData = [TaskListItem]()
    var completeTaskData = [TaskListItem]()

    // MARK: Use for upgrade schema
    func openRealm() {
        do {
            let config = Realm.Configuration(schemaVersion: 1)
            Realm.Configuration.defaultConfiguration = config
            _ = try Realm()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    /// Check current schema version
    func checkSchema() {
        let configCheck = Realm.Configuration();
        do {
             let fileUrlIs = try schemaVersionAtURL(configCheck.fileURL!)
            print("schema version \(fileUrlIs)")
        } catch  {
            print(error)
        }
    }
    
    /// Display realm file location
    func findRealmFile() {
        do {
            let realm = try Realm()
            print(Realm.Configuration.defaultConfiguration.fileURL)
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    // MARK: Fetch data from Realm
    func readData() {
        do {
            let realm = try Realm()
            let results = realm.objects(TaskListItem.self).map({ $0 })
            taskData = results.sorted(by: { $0.dateCreated > $1.dateCreated } )
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    // MARK: Data filter base on task status
    func taskFilter(status: Bool) {
        do {
            let realm = try Realm()
            let completedTask = realm.objects(TaskListItem.self).where {
                $0.taskStatus == status
            }
            taskData = completedTask.sorted(by: {$0.dateCreated > $1.dateCreated})
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    // MARK: View all opened tasks
    func viewOpenedTask() {
        do {
            let realm = try Realm()
            let completedTask = realm.objects(TaskListItem.self).where {
                $0.taskStatus == false
            }
            taskData = completedTask.sorted(by: {$0.dateCreated > $1.dateCreated})
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    // MARK: View all completed tasks
    func viewCompletedTask() {
        do {
            let realm = try Realm()
            let completedTask = realm.objects(TaskListItem.self).where {
                $0.taskStatus == true
            }
            completeTaskData = completedTask.sorted(by: {$0.dateCreated > $1.dateCreated})
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    // MARK: Save data to Realm
    func writeData(title: String, note: String, flag: Bool, datePickerIsOn: Bool, reminderMeDate: Date? = nil, notifyId: String) {
        let taskObject = TaskListItem(value: [
            "title": title,
            "note": note,
            "flag": flag,
            "datePickerIsOn": datePickerIsOn,
            "reminderMeDate": reminderMeDate,
            "taskStatus": false,
            "notificationId": notifyId
        ])
        
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(taskObject)
            }
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    // MARK: Delete data from table view on Realm
    func deleteData(at indexPath: IndexPath) {
        do {
            let taskDelete = taskData[indexPath.row]
            let realm = try Realm()
            try realm.write {
                realm.delete(taskDelete)
            }
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    // MARK: Use ID to delete data
    func delete(id: String) {
        do {
            let realm = try Realm()
            let objectID = try ObjectId(string: id)
            if let task = realm.object(ofType: TaskListItem.self, forPrimaryKey: objectID) {
                try realm.write {
                    realm.delete(task)
                }
            }
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    // MARK: Modify and save data on Realm
    func updateData(id: String, newTitle: String, newNote: String, flag: Bool, datePickerIsOn: Bool, reminderMeDate: Date? = nil, notifyId: String) {
        do {
            let realm = try Realm()
            let objectID = try ObjectId(string: id)
            let task = realm.object(ofType: TaskListItem.self, forPrimaryKey: objectID)
            try realm.write {
                task?.title = newTitle
                task?.note = newNote
                task?.flag = flag
                task?.datePickerIsOn = datePickerIsOn
                task?.reminderMeDate = reminderMeDate
                task?.notificationId = notifyId
            }
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    // MARK: update flag data
    func updateFlagData(id: ObjectId, flag: Bool) {
        do {
            let realm = try Realm()
            let task = realm.object(ofType: TaskListItem.self, forPrimaryKey: id)
            try realm.write {
                task?.flag = flag
            }
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    // MARK: Complete a task
    func completeTask(id: ObjectId, taskStatus: Bool, closeDate: Date? = nil) {
        do {
            let realm = try Realm()
            let task = realm.object(ofType: TaskListItem.self, forPrimaryKey: id)
            try realm.write {
                task?.taskStatus = taskStatus
                task?.dateCompleted = closeDate
            }
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
}

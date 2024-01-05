//
//  Task.swift
//  MyTaskList
//
//  Created by Tony Chen on 23/5/2023.
//

import Foundation

struct Tasks {
    var id: String
    var dateCreated: Date = Date()
    var title: String
    var note: String?
    var flag: Bool
    var datePickerIsOn: Bool
    var reminderMeDate: Date? = Date()
    var notificationId: String?
    var dateCompleted: Date? = Date()
    var taskStatus: Bool?
    
    init(taskListItem: TaskListItem) {
        self.id = taskListItem.id.stringValue
        self.dateCreated = taskListItem.dateCreated
        self.title = taskListItem.title
        self.note = taskListItem.note
        self.flag = taskListItem.flag
        self.datePickerIsOn = taskListItem.datePickerIsOn
        self.reminderMeDate = taskListItem.reminderMeDate
        self.notificationId = taskListItem.notificationId
        self.dateCompleted = taskListItem.dateCompleted
        self.taskStatus = taskListItem.taskStatus
    }
}

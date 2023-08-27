//
//  TaskObject.swift
//  MyTaskList
//
//  Created by Tony Chen on 16/5/2023.
//

import Foundation
import RealmSwift

class TaskListItem: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var dateCreated: Date = Date()
    @Persisted var title: String = ""
    @Persisted var note: String? = ""
    @Persisted var flag: Bool = false
    @Persisted var datePickerIsOn: Bool = false
    @Persisted var reminderMeDate: Date? = nil
    @Persisted var notificationId: String? = ""
    @Persisted var dateCompleted: Date? = nil
    @Persisted var taskStatus: Bool? = false
}

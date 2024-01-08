//
//  Theme.swift
//  MyTaskList
//
//  Created by Tony Chen on 25/7/2023.
//

import UIKit

struct Theme {
    // MARK: UI colour
    struct Colours {
        static let blueShadowColor = #colorLiteral(red: 0, green: 0.1250701678, blue: 0.9529175421, alpha: 0.825159136)
        static let whiteColour = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        static let tintWhite = UIColor.white
        static let red = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        static let vividBlue = #colorLiteral(red: 0.1864877343, green: 0.4360160828, blue: 0.9999772906, alpha: 1)
        static let lightGray = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        static let gray = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        static let orange = #colorLiteral(red: 1, green: 0.5433388929, blue: 0, alpha: 1)
        static let vividGreen = #colorLiteral(red: 0.2360480191, green: 1, blue: 0.2006964495, alpha: 1)
        static let lightOrange = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        static let green = #colorLiteral(red: 0.2545660734, green: 0.7794763446, blue: 0.3503473699, alpha: 1)
        static let systemGray = UIColor.systemGray
        static let systemGray2 = UIColor.systemGray2
        static let black = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
    
    // MARK: Image used in model
    struct Images {
        static let plusButton = "addButton"
        static let noRecordFoundGif = "EmptyBox"
        static let sfButtonSquare = "square"
        static let sfButtonSqureCheckmark = "checkmark.square.fill"
        //static let sfFlagName = "flag.fill"
        static let flagRedFill = "FlagRedFill"
        static let trash = "trash.fill"
        static let flagFill = "flag.fill"
        static let unflag = "flag.slash.fill"
        static let flagCircleFill = "flag.circle.fill"
        static let calendarCircleFill = "calendar.circle.fill"
        static let bellCircleFill = "bell.circle.fill"
    }
    
    // MARK: Text and label display in model
    struct Text {
        static let emptyText = ""
        static let viewTaskControllerTitle = "My Tasks"
        static let noTaskFoundLabel = "No Task Found"
        static let noTaskFoundDescrip = "No task record avaiable at the moment. Please use plus button to create Task."
        static let editTaskControllerTitle = "Edit Task"
        static let taskTitlePlaceholder = "Enter task title..."
        static let notePlaceholder = "Add note..."
        static let flagLabel = " Flag"
        static let unflagLabel = "Unflag"
        static let today = "Today,"
        static let tomorrow = "Tomorrow,"
        static let yesterday = "Yesterday,"
        static let reminderMeLabel = " Reminder me"
        static let chooseDateLabel = " Choose date"
        static let deleteTaskAlertTitle = "Delete task?"
        static let deleteTaskAlertBody = "You cannot undo this action"
        static let taskReminder = "Task reminder"
        static let enableNotificationTitle = "Enable Notification?"
        static let enableNotificationBody = "To use reminder me feature, please enable notifications in settings."
        static let discardChangeAlertTitle = "Unsaved changes?"
        static let discardChangeAlertBody = "You have made changes, Do you want to keep editing or discard them?"
        static let taskListSectionTitle = "Task List"
        static let completedSectionTitle = "Completed"
        static let cantEditTaskTitle = "Unable to edit Task"
        static let cantEditTaskBody = "You can't edit a completed task. Please ensure the checkbox is unchecked to make any modifications."
        
        struct DateTimeFormat {
            static let dateTimeFormat = "EEEE, MMM d, yyyy, h:mm a"
            static let timeFormat = "h:mm a"
        }
    }
    
    // MARK: Number used 
    struct Number {
        static let taskTitleMaxLength = 50
        static let notesMaxLength = 500
    }
    
    // MARK: Label display in buttons
    struct ButtonLabel {
        static let saveButton = "Save"
        static let deleteButton = "Delete"
        static let cancelButton = "Cancel"
        static let closeButton = "Close"
        static let dismissbutton = "Dismiss"
        static let settingButton = "Setting"
        static let keepEditButton = "Keep Editing"
        static let discardChangesbutton = "Discard Changes"
    }
}

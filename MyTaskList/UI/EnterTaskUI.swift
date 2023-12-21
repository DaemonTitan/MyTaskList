//
//  Buttons.swift
//  MyTaskList
//
//  Created by Tony Chen on 16/5/2023.
//

import Foundation
import UIKit

class TaskUI: UIView {
    /// Record task title
    lazy var taskTitleTextField: UITextField = {
        var taskTitleTextField = UITextField()
        taskTitleTextField.attributedPlaceholder = NSAttributedString(string: Theme.Text.taskTitlePlaceholder,
                                                                      attributes:
                                                                        [NSAttributedString.Key.foregroundColor: Theme.Colours.lightGray])
        taskTitleTextField.font = .systemFont(ofSize: 20)
        taskTitleTextField.tintColor = Theme.Colours.whiteColour
        taskTitleTextField.textColor = Theme.Colours.whiteColour
        taskTitleTextField.backgroundColor = Theme.Colours.vividBlue
        taskTitleTextField.addPadding()
        taskTitleTextField.layer.borderColor = Theme.Colours.lightGray.cgColor
        taskTitleTextField.layer.cornerRadius = 7
        taskTitleTextField.layer.borderWidth = 1.0
        //taskTitleTextField.addBottomBorder(height: 1.0, color: Theme.Colours.whiteColour)
        taskTitleTextField.translatesAutoresizingMaskIntoConstraints = false
        return taskTitleTextField
    }()
    
    /// Task title field character count down label
    lazy var taskTitleCountLabel: UILabel = {
        var taskTitleCount = UILabel()
        taskTitleCount.textColor = Theme.Colours.whiteColour
        taskTitleCount.font = .systemFont(ofSize: 14)
        taskTitleCount.textAlignment = .right
        taskTitleCount.translatesAutoresizingMaskIntoConstraints = false
        return taskTitleCount
    }()
    
    /// Record task note
    lazy var noteTextField: UITextView = {
        var noteTextField = UITextView()
        noteTextField.font = .systemFont(ofSize: 18)
        noteTextField.tintColor = Theme.Colours.whiteColour
        noteTextField.textColor = Theme.Colours.whiteColour
        noteTextField.backgroundColor = Theme.Colours.vividBlue
        noteTextField.layer.cornerRadius = 8.0
        noteTextField.isScrollEnabled = true
        noteTextField.isEditable = true
        noteTextField.layer.borderColor = Theme.Colours.lightGray.cgColor
        noteTextField.layer.cornerRadius = 7
        noteTextField.layer.borderWidth = 1.0
        noteTextField.textContainerInset = UIEdgeInsets(top: 10,
                                                       left: 6,
                                                       bottom: 10,
                                                       right: 6)
        noteTextField.autocorrectionType = .yes
        noteTextField.spellCheckingType = .yes
        noteTextField.translatesAutoresizingMaskIntoConstraints = false
        return noteTextField
    }()
    
    /// Notes field character count down label
    lazy var notesCountLabel: UILabel = {
        var notesCount = UILabel()
        notesCount.textColor = Theme.Colours.whiteColour
        notesCount.font = .systemFont(ofSize: 14)
        notesCount.textAlignment = .right
        notesCount.translatesAutoresizingMaskIntoConstraints = false
        return notesCount
    }()
    
    lazy var noteTextPlaceholder: UILabel = {
        var placeholder = UILabel()
        placeholder.text = Theme.Text.notePlaceholder
        placeholder.textColor = Theme.Colours.lightGray
        placeholder.textAlignment = .left
        placeholder.font = .systemFont(ofSize: 18)
        placeholder.translatesAutoresizingMaskIntoConstraints = false
        return placeholder
    }()

    /// Task titile and notes stack view
    lazy var taskDetailStackView: UIStackView = {
        var taskDetailStackView = UIStackView()
        taskDetailStackView.axis = .vertical
        taskDetailStackView.spacing = 13
        taskDetailStackView.alignment = .fill
        taskDetailStackView.distribution = .fill
        taskDetailStackView.addArrangedSubview(taskTitleTextField)
        taskDetailStackView.addArrangedSubview(taskTitleCountLabel)
        taskDetailStackView.addArrangedSubview(noteTextField)
        taskDetailStackView.addArrangedSubview(notesCountLabel)
        taskDetailStackView.translatesAutoresizingMaskIntoConstraints = false
        return taskDetailStackView
    }()
    
    /// Flag label
    lazy var flagLabel: UILabel = {
        var flagLabel = UILabel()
        let sfSymbolName = Theme.Images.flagCircleFill
        let flagText = Theme.Text.flagLabel
        let sfImageConfiguration = UIImage.SymbolConfiguration(font: .systemFont(ofSize: 25.0))
        let image = UIImage(systemName: sfSymbolName,
                            withConfiguration: sfImageConfiguration)?.withTintColor(.white, renderingMode: .alwaysOriginal)
        flagLabel.addImageToFrontLabel(image: image ?? UIImage(), text: flagText)
        flagLabel.textAlignment = .left
        flagLabel.textColor = Theme.Colours.whiteColour
        flagLabel.font = .systemFont(ofSize: 18)
        flagLabel.translatesAutoresizingMaskIntoConstraints = false
        return flagLabel
    }()
    
    /// Flag switch
    lazy var flagSwitch: UISwitch = {
        var flagSwitch = UISwitch()
        flagSwitch.onTintColor = Theme.Colours.orange
        flagSwitch.backgroundColor = Theme.Colours.whiteColour
        flagSwitch.layer.cornerRadius = 16
        flagSwitch.isOn = false
        flagSwitch.translatesAutoresizingMaskIntoConstraints = false
        return flagSwitch
    }()
    
    /// Flag stack view
    lazy var flagStackView: UIStackView = {
        var flagStackView = UIStackView()
        flagStackView.axis = .horizontal
        flagStackView.spacing = 10
        flagStackView.alignment = .fill
        flagStackView.distribution = .fill
        flagStackView.addArrangedSubview(flagLabel)
        flagStackView.addArrangedSubview(flagSwitch)
        flagStackView.translatesAutoresizingMaskIntoConstraints = false
        return flagStackView
    }()
    
    /// Reminder me Label
    lazy var reminderMeLabel: UILabel = {
        var reminderMeLabel = UILabel()
        let sfSymbolName = Theme.Images.calendarCircleFill
        let reminderMeText = Theme.Text.reminderMeLabel
        let sfImageConfiguration = UIImage.SymbolConfiguration(font: .systemFont(ofSize: 25.0))
        let image = UIImage(systemName: sfSymbolName, withConfiguration: sfImageConfiguration)?.withTintColor(.white, renderingMode: .alwaysOriginal)
        reminderMeLabel.addImageToFrontLabel(image: image ?? UIImage(), text: reminderMeText)
        reminderMeLabel.textAlignment = .left
        reminderMeLabel.textColor = Theme.Colours.whiteColour
        reminderMeLabel.font = .systemFont(ofSize: 18)
        reminderMeLabel.translatesAutoresizingMaskIntoConstraints = false
        return reminderMeLabel
    }()
    
    /// Switches to enable due date
    lazy var reminderMeSwitch: UISwitch = {
        var reminderMeSwitch = UISwitch()
        reminderMeSwitch.onTintColor = Theme.Colours.vividGreen
        reminderMeSwitch.backgroundColor = Theme.Colours.whiteColour
        reminderMeSwitch.layer.cornerRadius = 16
        reminderMeSwitch.isOn = false
        reminderMeSwitch.translatesAutoresizingMaskIntoConstraints = false
        return reminderMeSwitch
    }()
    
    /// Reminder me calender date picker
    lazy var remindMeDatePicker: UIDatePicker = {
        var remindMeDatePicker = UIDatePicker()
        remindMeDatePicker.datePickerMode = .dateAndTime
        remindMeDatePicker.isHidden = true
        remindMeDatePicker.tintColor = Theme.Colours.lightOrange
        remindMeDatePicker.minimumDate = Date()
        remindMeDatePicker.overrideUserInterfaceStyle = .dark
        remindMeDatePicker.preferredDatePickerStyle = .inline
        remindMeDatePicker.translatesAutoresizingMaskIntoConstraints = false
        return remindMeDatePicker
    }()
    
    // Reminder me Stack view
    lazy var dateStackView: UIStackView = {
        var dateStackView = UIStackView()
        dateStackView.axis = .horizontal
        dateStackView.spacing = 10
        dateStackView.alignment = .fill
        dateStackView.distribution = .fill
        dateStackView.addArrangedSubview(reminderMeLabel)
        dateStackView.addArrangedSubview(reminderMeSwitch)
        dateStackView.translatesAutoresizingMaskIntoConstraints = false
        return dateStackView
    }()
    
    lazy var scrollView: UIScrollView = {
        var scrollView = UIScrollView()
        //scrollView.backgroundColor = .gray
        scrollView.bounces = true
        scrollView.autoresizingMask = .flexibleWidth
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    lazy var contentView: UIView = {
        var contentView = UIView()
        //contentView.backgroundColor = .purple
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    
    /// Save task button
    lazy var saveTaskButton: UIButton = {
        var saveTaskButton = UIButton()
        saveTaskButton.configuration = .filled()
        saveTaskButton.tintColor = .white
        saveTaskButton.configuration?.title = Theme.ButtonLabel.saveButton
        saveTaskButton.titleLabel?.font = .systemFont(ofSize: 100, weight: .bold)
        saveTaskButton.layer.cornerRadius = 20.0
        saveTaskButton.layer.masksToBounds = true
        saveTaskButton.translatesAutoresizingMaskIntoConstraints = false
        return saveTaskButton
    }()
    
    /// Delete task button
    lazy var deleteTaskButton: UIButton = {
        var deleteTaskButton = UIButton()
        deleteTaskButton.configuration = .filled()
        deleteTaskButton.tintColor = .white
        deleteTaskButton.configuration?.title = Theme.ButtonLabel.deleteButton
        deleteTaskButton.titleLabel?.font = .systemFont(ofSize: 100, weight: .bold)
        deleteTaskButton.layer.cornerRadius = 20.0
        deleteTaskButton.layer.masksToBounds = true
        deleteTaskButton.translatesAutoresizingMaskIntoConstraints = false
        return deleteTaskButton
    }()
}

//MARK: Task UI Extension for Create Task Screen
extension TaskUI {
    /// Reminder me swtich to unhide calender date picker
    func toggleReminderMeSwitch() {
        //reminderMeSwitch.addTarget(self, action: #selector(hideReminderMeField), for: .valueChanged)
        reminderMeSwitch.switchEditChangeListner{
            self.hideReminderMeField()
        }
    }
    
    /// Button action to hide reminder me date picker
    @objc func hideReminderMeField() {
        remindMeDatePicker.isHidden = !reminderMeSwitch.isOn
        
    }
    
    /// Check text field is empty or not to change save button state
    func textFieldEditChange() {
        updateSaveButtonState()
        taskTitleTextField.textFieldEditChangeListner {
            self.textfieldEditChange()
        }
    }
    
    /// Button action to change Save button state
    @objc func textfieldEditChange() {
        updateSaveButtonState()
    }
    
    func updateSaveButtonState() {
        if let titleText = taskTitleTextField.text, !titleText.isEmpty {
            saveTaskButton.isEnabled = true
        } else {
            saveTaskButton.isEnabled = false
        }
    }
}

//MARK: Task UI Extension for View Task Screen
extension TaskUI {
    func taskNotesPlaceholder() {
        noteTextField.addSubview(noteTextPlaceholder)
        noteTextPlaceholder.isHidden = !noteTextField.text.isEmpty
        NSLayoutConstraint.activate([
            noteTextPlaceholder.topAnchor.constraint(equalTo: noteTextField.topAnchor, constant: 10),
            noteTextPlaceholder.leadingAnchor.constraint(equalTo: noteTextField.leadingAnchor, constant: 11)
        ])
    }
    
    func unhideSaveButton() {
        /// Check task titile text field eidt change to change save button state
        taskTitleTextField.textFieldEditChangeListner {
            self.textfieldEditChange()
        }
        
        /// Check flag switch eidt change to change save button state
        flagSwitch.switchEditChangeListner {
            self.enableSaveTaskButton()
        }
        
        /// Check reminder me switch eidt change to change save button state
        reminderMeSwitch.switchEditChangeListner {
            self.enableSaveTaskButton()
        }
        
        /// Check date picker eidt change to change save button state
        remindMeDatePicker.datePickerEditChangeListner {
            self.enableSaveTaskButton()
        }
    }
    
    @objc func enableSaveTaskButton() {
        saveTaskButton.isEnabled = true
    }
}

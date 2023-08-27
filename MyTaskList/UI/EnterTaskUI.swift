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
        taskTitleTextField.tintColor = .white
        taskTitleTextField.textColor = .white
        taskTitleTextField.backgroundColor = Theme.Colours.vividBlue
        taskTitleTextField.layer.cornerRadius = 8.0
        taskTitleTextField.addBottomBorder(height: 1.0, color: .white)
        taskTitleTextField.translatesAutoresizingMaskIntoConstraints = false
        return taskTitleTextField
    }()
    
    /// Record task note
    lazy var noteTextField: UITextField = {
        var noteTextField = UITextField()
        noteTextField.attributedPlaceholder = NSAttributedString(string: Theme.Text.notePlaceholder,
                                                                      attributes:
                                                                    [NSAttributedString.Key.foregroundColor: Theme.Colours.lightGray])
        noteTextField.tintColor = .white
        noteTextField.textColor = .white
        noteTextField.backgroundColor = Theme.Colours.vividBlue
        noteTextField.layer.cornerRadius = 8.0
        noteTextField.addBottomBorder(height: 1.0, color: .white)
        noteTextField.translatesAutoresizingMaskIntoConstraints = false
        return noteTextField
    }()
//    lazy var noteTextView: UITextView = {
//        var noteTextView = UITextView()
//        noteTextView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
//        noteTextView.font = .systemFont(ofSize: 16)
//        noteTextView.layer.cornerRadius = 8.0
//        noteTextView.isScrollEnabled = true
//        noteTextView.textContainerInset = UIEdgeInsets(top: 10,
//                                                       left: 6,
//                                                       bottom: 10,
//                                                       right: 6)
//        noteTextView.autocorrectionType = .yes
//        noteTextView.spellCheckingType = .yes
//        noteTextView.translatesAutoresizingMaskIntoConstraints = false
//        return noteTextView
//    }()

    /// Task titile and notes stack view
    lazy var taskDetailStackView: UIStackView = {
        var taskDetailStackView = UIStackView()
        taskDetailStackView.axis = .vertical
        taskDetailStackView.spacing = 13
        taskDetailStackView.alignment = .fill
        taskDetailStackView.distribution = .fill
        taskDetailStackView.addArrangedSubview(taskTitleTextField)
        taskDetailStackView.addArrangedSubview(noteTextField)
        taskDetailStackView.translatesAutoresizingMaskIntoConstraints = false
        return taskDetailStackView
    }()
    
    /// Flag label
    lazy var flagLabel: UILabel = {
        var flagLabel = UILabel()
        let sfSymbolName = "flag.circle.fill"
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
        let sfSymbolName = "calendar.circle.fill"
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
    
    /// Add another task button
//    lazy var addMoreButton: UIButton = {
//        var addMoreButton = UIButton()
//        addMoreButton.configuration = .filled()
//        addMoreButton.tintColor = .white
//        addMoreButton.configuration?.title = "Add more"
//        addMoreButton.titleLabel?.font = .systemFont(ofSize: 100, weight: .bold)
//        addMoreButton.layer.cornerRadius = 20.0
//        addMoreButton.layer.masksToBounds = true
//        addMoreButton.translatesAutoresizingMaskIntoConstraints = false
//        return addMoreButton
//    }()
    
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
    
    @objc func hideReminderMeField() {
        remindMeDatePicker.isHidden = !reminderMeSwitch.isOn
        
    }
    
    /// Check text field is empty or not to change save button state
    func textFieldEditChange() {
        updateButtonState()
        taskTitleTextField.textFieldEditChangeListner {
            self.textfieldEditChange()
        }
    }
    
    @objc func textfieldEditChange() {
        updateButtonState()
    }
    
    func updateButtonState() {
        if let titleText = taskTitleTextField.text, !titleText.isEmpty {
            saveTaskButton.isEnabled = true
        } else {
            saveTaskButton.isEnabled = false
        }
    }
}

//MARK: Task UI Extension for View Task Screen
extension TaskUI {
    func unhideSaveButton() {
        /// Check task titile text field eidt change to change save button state
        taskTitleTextField.textFieldEditChangeListner {
            self.textfieldEditChange()
        }
        
        /// Check notes text field eidt change to change save button state
        noteTextField.textFieldEditChangeListner {
            self.checkTaskNoteValueChange()
        }
        
        /// Check flag switch eidt change to change save button state
        flagSwitch.switchEditChangeListner {
            self.checkFlagValueChange()
        }
        
        /// Check reminder me switch eidt change to change save button state
        reminderMeSwitch.switchEditChangeListner {
            self.checkReminderMeValueChange()
        }
        
        /// Check date picker eidt change to change save button state
        remindMeDatePicker.datePickerEditChangeListner {
            self.checkDatePickerValueChange()
        }
    }
    
    @objc func checkTaskNoteValueChange() {
        saveTaskButton.isEnabled = true
    }
    
    @objc func checkFlagValueChange() {
        saveTaskButton.isEnabled = true
    }
    
    @objc func checkReminderMeValueChange() {
        saveTaskButton.isEnabled = true
    }
    
    @objc func checkDatePickerValueChange() {
        saveTaskButton.isEnabled = true
    }
}

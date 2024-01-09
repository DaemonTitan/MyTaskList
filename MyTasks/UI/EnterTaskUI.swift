//
//  Buttons.swift
//  MyTaskList
//
//  Created by Tony Chen on 16/5/2023.
//

import Foundation
import UIKit

class TaskUI: UIView {
    // MARK: Task Title
    /// Task title text field
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
    
    /// Task titile and text count stack view
    lazy var taskTitleStackView: UIStackView = {
        var taskTitleStackView = UIStackView()
        taskTitleStackView.axis = .vertical
        taskTitleStackView.spacing = 5
        taskTitleStackView.alignment = .fill
        taskTitleStackView.distribution = .fill
        taskTitleStackView.addArrangedSubview(taskTitleTextField)
        taskTitleStackView.addArrangedSubview(taskTitleCountLabel)
        taskTitleStackView.translatesAutoresizingMaskIntoConstraints = false
        return taskTitleStackView
    }()
    
    // MARK: Task Notes
    /// Task note large text box
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
    
    /// Placeholder in notes field
    lazy var noteTextPlaceholder: UILabel = {
        var placeholder = UILabel()
        placeholder.text = Theme.Text.notePlaceholder
        placeholder.textColor = Theme.Colours.lightGray
        placeholder.textAlignment = .left
        placeholder.font = .systemFont(ofSize: 18)
        placeholder.translatesAutoresizingMaskIntoConstraints = false
        return placeholder
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
    
    /// Task notes and text count stack view
    lazy var taskNotesStackView: UIStackView = {
        var taskNotesStackView = UIStackView()
        taskNotesStackView.axis = .vertical
        taskNotesStackView.spacing = 5
        taskNotesStackView.alignment = .fill
        taskNotesStackView.distribution = .fill
        taskNotesStackView.addArrangedSubview(noteTextField)
        taskNotesStackView.addArrangedSubview(notesCountLabel)
        taskNotesStackView.translatesAutoresizingMaskIntoConstraints = false
        return taskNotesStackView
    }()
    
    /// Divid line from above Task titile and Notes field
    lazy var dividLineView1: UIView = {
        var dividLineView1 = UIView()
        dividLineView1.layer.borderColor = Theme.Colours.lightGray1.cgColor
        dividLineView1.layer.borderWidth = 1.0
        dividLineView1.translatesAutoresizingMaskIntoConstraints = false
        return dividLineView1
    }()
    
    // MARK: Priority
    /// Priority label and Exclamation icon
    lazy var priorityLabel: UILabel = {
        var priorityLabel = UILabel()
        let sfSymbolName = Theme.Images.priorityCircle
        let priorityText = Theme.Text.priorityLabel
        let sfImageConfiguration = UIImage.SymbolConfiguration(font: .systemFont(ofSize: 25.0))
        let image = UIImage(systemName: sfSymbolName,
                            withConfiguration: sfImageConfiguration)?.withTintColor(.white, renderingMode: .alwaysOriginal)
        priorityLabel.addImageToFrontLabel(image: image ?? UIImage(), text: priorityText)
        priorityLabel.textAlignment = .left
        priorityLabel.textColor = Theme.Colours.whiteColour
        priorityLabel.font = .systemFont(ofSize: 18)
        priorityLabel.translatesAutoresizingMaskIntoConstraints = false
        return priorityLabel
    }()
    
    /// Priority single select
    lazy var priorityButton: UIButton = {
        var priorityButton = UIButton()
        let optionClosure = {(action: UIAction) in }
        let nonePriority = UIAction(title: Theme.Text.PriorityValue.None,
                                    handler: optionClosure)
        let lowerPriority = UIAction(title: Theme.Text.PriorityValue.Low,
                                     image: UIImage(systemName: Theme.Images.signleexclamation),
                                     handler: optionClosure)
        let mediumPriority = UIAction(title: Theme.Text.PriorityValue.Medium,
                                      image: UIImage(systemName: Theme.Images.doubleexclamation),
                                      handler: optionClosure)
        let highPriority = UIAction(title: Theme.Text.PriorityValue.High,
                                    image: UIImage(systemName: Theme.Images.troubleexclamation),
                                    attributes: .destructive,
                                    handler: optionClosure)
        let subMenu = UIMenu(title: Theme.Text.emptyText,
                             options: .displayInline,
                             children: [nonePriority])
        priorityButton.menu = UIMenu(options: .displayInline,
                                     children: [subMenu, lowerPriority, mediumPriority, highPriority])
        priorityButton.showsMenuAsPrimaryAction = true
        priorityButton.changesSelectionAsPrimaryAction = true
        priorityButton.translatesAutoresizingMaskIntoConstraints = false
        return priorityButton
    }()
    
    /// Priority label and Priority Single Select Button stack view
    lazy var priorityStackView: UIStackView = {
        var priorityStackView = UIStackView()
        priorityStackView.axis = .horizontal
        priorityStackView.spacing = 90
        priorityStackView.alignment = .fill
        priorityStackView.distribution = .fill
        priorityStackView.addArrangedSubview(priorityLabel)
        priorityStackView.addArrangedSubview(priorityButton)
        priorityStackView.translatesAutoresizingMaskIntoConstraints = false
        return priorityStackView
    }()
    
    /// Divid line for Priority field
    lazy var dividLineView2: UIView = {
        var dividLineView2 = UIView()
        dividLineView2.layer.borderColor = Theme.Colours.lightGray1.cgColor
        dividLineView2.layer.borderWidth = 1.0
        dividLineView2.translatesAutoresizingMaskIntoConstraints = false
        return dividLineView2
    }()
    
    // MARK: Flag
    /// Flag label and Flag icon
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
    
    /// Flag label and Flag switch stack view
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
    
    /// Divid line for Flag field
    lazy var dividLineView3: UIView = {
        var dividLineView3 = UIView()
        dividLineView3.layer.borderColor = Theme.Colours.lightGray1.cgColor
        dividLineView3.layer.borderWidth = 1.0
        dividLineView3.translatesAutoresizingMaskIntoConstraints = false
        return dividLineView3
    }()
    
    // MARK: Reminder me and Date picker
    /// Reminder me Label and Bell icon
    lazy var reminderMeLabel: UILabel = {
        var reminderMeLabel = UILabel()
        let sfSymbolName = Theme.Images.bellCircleFill
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
    
    /// Reminder me switch
    lazy var reminderMeSwitch: UISwitch = {
        var reminderMeSwitch = UISwitch()
        reminderMeSwitch.onTintColor = Theme.Colours.vividGreen
        reminderMeSwitch.backgroundColor = Theme.Colours.whiteColour
        reminderMeSwitch.layer.cornerRadius = 16
        reminderMeSwitch.isOn = false
        reminderMeSwitch.translatesAutoresizingMaskIntoConstraints = false
        return reminderMeSwitch
    }()
    
    /// Reminder me label and Reminder me switch stack view
    lazy var reminderMeStackView: UIStackView = {
        var reminderMeStackView = UIStackView()
        reminderMeStackView.axis = .horizontal
        reminderMeStackView.spacing = 10
        reminderMeStackView.alignment = .fill
        reminderMeStackView.distribution = .fill
        reminderMeStackView.addArrangedSubview(reminderMeLabel)
        reminderMeStackView.addArrangedSubview(reminderMeSwitch)
        reminderMeStackView.translatesAutoresizingMaskIntoConstraints = false
        return reminderMeStackView
    }()
    
    /// Pick date time label and calendar icon
    lazy var chooseDateLabel: UILabel = {
        var chooseDateLabel = UILabel()
        let sfSymbolName = Theme.Images.calendarCircleFill
        let reminderMeText = Theme.Text.chooseDateLabel
        let sfImageConfiguration = UIImage.SymbolConfiguration(font: .systemFont(ofSize: 25.0))
        let image = UIImage(systemName: sfSymbolName, withConfiguration: sfImageConfiguration)?.withTintColor(.white, renderingMode: .alwaysOriginal)
        chooseDateLabel.addImageToFrontLabel(image: image ?? UIImage(), text: reminderMeText)
        chooseDateLabel.textAlignment = .left
        chooseDateLabel.textColor = Theme.Colours.whiteColour
        chooseDateLabel.font = .systemFont(ofSize: 18)
        chooseDateLabel.isHidden = true
        chooseDateLabel.translatesAutoresizingMaskIntoConstraints = false
        return chooseDateLabel
    }()
    
    /// Reminder me date time picker
    lazy var remindMeDatePicker: UIDatePicker = {
        var remindMeDatePicker = UIDatePicker()
        remindMeDatePicker.datePickerMode = .dateAndTime
        remindMeDatePicker.isHidden = true
        remindMeDatePicker.tintColor = Theme.Colours.lightOrange
        remindMeDatePicker.overrideUserInterfaceStyle = .dark
        remindMeDatePicker.preferredDatePickerStyle = .compact
        remindMeDatePicker.translatesAutoresizingMaskIntoConstraints = false
        return remindMeDatePicker
    }()
    
    /// Pick date/time label and Date picker stack view
    lazy var datePickerStackView: UIStackView = {
        var datePickerStackView = UIStackView()
        datePickerStackView.axis = .horizontal
        datePickerStackView.spacing = 10
        datePickerStackView.alignment = .fill
        datePickerStackView.distribution = .fill
        datePickerStackView.addArrangedSubview(chooseDateLabel)
        datePickerStackView.addArrangedSubview(remindMeDatePicker)
        datePickerStackView.translatesAutoresizingMaskIntoConstraints = false
        return datePickerStackView
    }()
    
    // MARK: Scroll and Content Views
    /// Scroll view
    lazy var scrollView: UIScrollView = {
        var scrollView = UIScrollView()
        //scrollView.backgroundColor = .gray
        scrollView.bounces = true
        scrollView.autoresizingMask = .flexibleWidth
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    /// UI elements content view
    lazy var contentView: UIView = {
        var contentView = UIView()
        //contentView.backgroundColor = .purple
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    
    // MARK: Save and Delete Buttons
    /// Save task button
    lazy var saveTaskButton: UIButton = {
        var saveTaskButton = UIButton()
        saveTaskButton.configuration = .filled()
        saveTaskButton.tintColor = Theme.Colours.tintWhite
        saveTaskButton.configuration?.title = Theme.ButtonLabel.saveButton
        saveTaskButton.titleLabel?.font = .systemFont(ofSize: 100, weight: .bold)
        saveTaskButton.layer.cornerRadius = 20.0
        saveTaskButton.layer.masksToBounds = true
        saveTaskButton.translatesAutoresizingMaskIntoConstraints = false
        return saveTaskButton
    }()
    
    /// Save button background view
    lazy var saveButtonBackground: UIView = {
        var saveButtonBackground = UIView()
        saveButtonBackground.backgroundColor = Theme.Colours.vividBlue
        saveButtonBackground.translatesAutoresizingMaskIntoConstraints = false
        return saveButtonBackground
    }()
    
    /// Delete task button
    lazy var deleteTaskButton: UIButton = {
        var deleteTaskButton = UIButton()
        deleteTaskButton.configuration = .filled()
        deleteTaskButton.tintColor = Theme.Colours.tintWhite
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
        chooseDateLabel.isHidden = !reminderMeSwitch.isOn
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
        
        priorityButton.buttonMenuTriggered {
            self.enableSaveTaskButton()
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

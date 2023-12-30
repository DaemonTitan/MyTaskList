//
//  ViewSelectTaskScreen.swift
//  MyTaskList
//
//  Created by Tony Chen on 16/5/2023.
//

import UIKit

class ViewSelectTaskScreen: UIViewController {
    
    private var viewTaskUI = TaskUI()
    private var realmManager = RealmManager()
    private var notificationManager = NotificationManager()
    private let notificationCenter = UNUserNotificationCenter.current()
    var task: TaskListItem?
    
    var taskTitle: String = ""
    var taskNote: String = ""
    var taskFlag: Bool = false
    var reminderMe: Bool = false
    var reminderDate: Date? = Date()
    
    public var saveComplitionHandler: (() -> Void)?
    public var deleteComplitionHandler: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Theme.Colours.vividBlue
        title = Theme.Text.editTaskControllerTitle
        let textAttributes = [NSAttributedString.Key.foregroundColor: Theme.Colours.whiteColour]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationController?.navigationBar.barTintColor = Theme.Colours.vividBlue
        configureView()
        
        viewTaskUI.taskTitleTextField.delegate = self
        viewTaskUI.noteTextField.delegate = self
        viewTaskUI.taskTitleTextField.returnKeyType = .next
        viewTaskUI.noteTextField.returnKeyType = .done
        viewTaskUI.unhideSaveButton()
        viewTaskUI.toggleReminderMeSwitch()
        dismissKeyboard()
        
        leftBarButton(title: Theme.ButtonLabel.cancelButton,
                      color: .white, style: .done,
                      targe: self,
                      action: #selector(cancel))
        
        viewTaskUI.saveTaskButton.buttonTouchUpInside {
            self.tapUpdateTask()
        }
        viewTaskUI.deleteTaskButton.buttonTouchUpInside {
            self.tapDeleteTask()
        }
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name:UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name:UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        /// Display task data during screen loads
        displayTaskData()
    }
    
    override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
        /// Hide or Add task notes placeholder when view is appearing
        viewTaskUI.taskNotesPlaceholder()
        
        /// Display character count after screen loads
        displayCharacterCount()
    }
    
    private func configureView() {
        view.addSubview(viewTaskUI.scrollView)
        NSLayoutConstraint.activate([
            viewTaskUI.scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            viewTaskUI.scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            viewTaskUI.scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            viewTaskUI.scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])

        viewTaskUI.scrollView.addSubview(viewTaskUI.contentView)
        NSLayoutConstraint.activate([
           viewTaskUI.contentView.topAnchor.constraint(equalTo: viewTaskUI.scrollView.topAnchor),
           viewTaskUI.contentView.leadingAnchor.constraint(equalTo: viewTaskUI.scrollView.leadingAnchor),
           viewTaskUI.contentView.trailingAnchor.constraint(equalTo: viewTaskUI.scrollView.trailingAnchor),
           viewTaskUI.contentView.bottomAnchor.constraint(equalTo: viewTaskUI.scrollView.bottomAnchor),
           viewTaskUI.contentView.heightAnchor.constraint(equalTo: viewTaskUI.scrollView.heightAnchor, constant: 90),
           viewTaskUI.contentView.widthAnchor.constraint(equalTo: viewTaskUI.scrollView.widthAnchor),
        ])
        newUILayout()
    }
    
    private func newUILayout() {
       viewTaskUI.contentView.addSubview(viewTaskUI.taskDetailStackView)
       viewTaskUI.contentView.addSubview(viewTaskUI.flagStackView)
       viewTaskUI.contentView.addSubview(viewTaskUI.dateStackView)
       viewTaskUI.contentView.addSubview(viewTaskUI.remindMeDatePicker)
       viewTaskUI.contentView.addSubview(viewTaskUI.deleteTaskButton)
       viewTaskUI.contentView.addSubview(viewTaskUI.saveTaskButton)
        
        NSLayoutConstraint.activate([
            viewTaskUI.taskDetailStackView.topAnchor.constraint(equalTo: viewTaskUI.contentView.topAnchor, constant: 10),
            viewTaskUI.taskDetailStackView.leadingAnchor.constraint(equalTo: viewTaskUI.contentView.leadingAnchor, constant: 18),
            viewTaskUI.taskDetailStackView.trailingAnchor.constraint(equalTo: viewTaskUI.contentView.trailingAnchor, constant: -18),
            viewTaskUI.taskTitleTextField.heightAnchor.constraint(equalToConstant: 40),
            viewTaskUI.taskTitleCountLabel.heightAnchor.constraint(equalToConstant: 20),
            viewTaskUI.noteTextField.heightAnchor.constraint(equalToConstant: 100),
            viewTaskUI.notesCountLabel.heightAnchor.constraint(equalToConstant: 20),
        
            viewTaskUI.flagStackView.topAnchor.constraint(equalTo: viewTaskUI.taskDetailStackView.bottomAnchor, constant: 30),
            viewTaskUI.flagStackView.leadingAnchor.constraint(equalTo: viewTaskUI.contentView.leadingAnchor, constant: 18),
            viewTaskUI.flagStackView.trailingAnchor.constraint(equalTo: viewTaskUI.contentView.trailingAnchor, constant: -18),
            
            viewTaskUI.dateStackView.topAnchor.constraint(equalTo: viewTaskUI.flagStackView.bottomAnchor, constant: 30),
            viewTaskUI.dateStackView.leadingAnchor.constraint(equalTo: viewTaskUI.contentView.leadingAnchor, constant: 18),
            viewTaskUI.dateStackView.trailingAnchor.constraint(equalTo: viewTaskUI.contentView.trailingAnchor, constant: -18),
            viewTaskUI.reminderMeSwitch.heightAnchor.constraint(equalToConstant: 31),
        
            viewTaskUI.remindMeDatePicker.topAnchor.constraint(equalTo: viewTaskUI.dateStackView.bottomAnchor, constant: 30),
            viewTaskUI.remindMeDatePicker.leadingAnchor.constraint(equalTo: viewTaskUI.contentView.leadingAnchor, constant: 18),
            viewTaskUI.remindMeDatePicker.trailingAnchor.constraint(equalTo: viewTaskUI.contentView.trailingAnchor, constant: -18),
            
            viewTaskUI.deleteTaskButton.topAnchor.constraint(equalTo: viewTaskUI.remindMeDatePicker.bottomAnchor, constant: 30),
            viewTaskUI.deleteTaskButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -80),
            viewTaskUI.deleteTaskButton.heightAnchor.constraint(equalToConstant: 40),
            viewTaskUI.deleteTaskButton.widthAnchor.constraint(equalToConstant: 150),
            
            viewTaskUI.saveTaskButton.topAnchor.constraint(equalTo: viewTaskUI.remindMeDatePicker.bottomAnchor, constant: 30),
            viewTaskUI.saveTaskButton.leadingAnchor.constraint(equalTo: viewTaskUI.deleteTaskButton.trailingAnchor, constant: 20),
            viewTaskUI.saveTaskButton.heightAnchor.constraint(equalToConstant: 40),
            viewTaskUI.saveTaskButton.widthAnchor.constraint(equalToConstant: 150),
        ])
    }
}

extension ViewSelectTaskScreen: UITextFieldDelegate, UITextViewDelegate {
    // MARK: Text field
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == viewTaskUI.taskTitleTextField {
            viewTaskUI.noteTextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField === viewTaskUI.taskTitleTextField {
            guard let titleText = textField.text else { return }
            taskTitle = titleText
            displayCharacterCount()
        }
    }
    
    /// Set character limit to task title field
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentString = viewTaskUI.taskTitleTextField.text ?? ""
        return currentString.count + (string.count - range.length) <= Theme.Number.taskTitleMaxLength
    }
    
    // MARK: Text view
    func textViewDidChangeSelection(_ textView: UITextView) {
        if textView == viewTaskUI.noteTextField {
            guard let noteText = textView.text else {return}
            taskNote = noteText
            displayCharacterCount()
        }
    }
    
    /// Check notes text view edit change to change save button state
    func textViewDidChange(_ textView: UITextView) {
        viewTaskUI.saveTaskButton.isEnabled = true
        displayCharacterCount()
        viewTaskUI.noteTextPlaceholder.isHidden = !viewTaskUI.noteTextField.text.isEmpty
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        viewTaskUI.noteTextPlaceholder.isHidden = true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        viewTaskUI.noteTextPlaceholder.isHidden = !viewTaskUI.noteTextField.text.isEmpty
    }
    
    /// Set character limit to notes field
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentString = viewTaskUI.noteTextField.text ?? ""
        return currentString.count + (text.count - range.length) <= Theme.Number.notesMaxLength
    }
}

extension ViewSelectTaskScreen {
    /// Data mapping for display task on view select task controller
    func displayTaskData() {
        guard let taskItem = task else { return }
        viewTaskUI.taskTitleTextField.text = taskItem.title
        viewTaskUI.noteTextField.text = taskItem.note
        viewTaskUI.flagSwitch.isOn = taskItem.flag
        
        if let taskDate = taskItem.reminderMeDate {
            viewTaskUI.reminderMeSwitch.isOn = true
            viewTaskUI.remindMeDatePicker.isHidden = false
            viewTaskUI.remindMeDatePicker.date = taskDate
        }
        viewTaskUI.saveTaskButton.isEnabled = false
        
        if let noteField = task?.note {
            taskTitle = taskItem.title
            taskNote = noteField
            taskFlag = taskItem.flag
            reminderMe = taskItem.datePickerIsOn
            reminderDate = taskItem.reminderMeDate
        }
    }
    
    /// Display task titile and notes field character count down
    func displayCharacterCount() {
        guard let taskTitleCount = viewTaskUI.taskTitleTextField.text?.count else { return }
        guard let notesCount = viewTaskUI.noteTextField.text?.count else { return }
        
        viewTaskUI.taskTitleCountLabel.text = "\(taskTitleCount) / \(String(Theme.Number.taskTitleMaxLength))"
        viewTaskUI.notesCountLabel.text = "\(notesCount) / \(String(Theme.Number.notesMaxLength))"
    }
    
    @objc func keyboardWillShow(notification:NSNotification) {
        guard let userInfo = notification.userInfo else { return }
        var keyboardFrame:CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)

        var contentInset:UIEdgeInsets = self.viewTaskUI.scrollView.contentInset
        contentInset.bottom = keyboardFrame.size.height + 10
        viewTaskUI.scrollView.contentInset = contentInset
    }

    @objc func keyboardWillHide(notification:NSNotification) {
        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        viewTaskUI.scrollView.contentInset = contentInset
    }
    
    @objc func tapUpdateTask() {
        let saveButton = viewTaskUI.saveTaskButton
        saveButton.buttonBounceAnimation(button: saveButton)
        notificationCenter.getNotificationSettings { (settings) in
            DispatchQueue.main.async {
                switch settings.authorizationStatus {
                case .denied, .notDetermined:
                    Alert.showNotificationDenyAlert(on: self)
                case .authorized, .provisional, .ephemeral:
                    self.updateTask()
                @unknown default:
                    return
                }
            }
        }
    }
    
    func updateTask() {
        guard let titleField = viewTaskUI.taskTitleTextField.text, !titleField.isEmpty else {return}
        guard let taskId = task?.id else {return}
        let noteField = viewTaskUI.noteTextField.text ?? ""
        let flagSwitch = viewTaskUI.flagSwitch.isOn
        let reminderMeSwitch = viewTaskUI.reminderMeSwitch.isOn
        let reminderDate = viewTaskUI.remindMeDatePicker.date
        let id = notificationManager.notificationId

        if viewTaskUI.remindMeDatePicker.isHidden {
            notificationManager.deletePendingNotification(notificationId: Configure.selectedNotificationId)
            realmManager.updateData(id: taskId.stringValue,
                                    newTitle: titleField,
                                    newNote: noteField,
                                    flag: flagSwitch,
                                    datePickerIsOn: reminderMeSwitch,
                                    reminderMeDate: nil,
                                    notifyId: "")
            saveComplitionHandler?()
            dismiss(animated: true)
        } else {
            notificationManager.deletePendingNotification(notificationId: Configure.selectedNotificationId)
            realmManager.updateData(id: taskId.stringValue,
                                    newTitle: titleField,
                                    newNote: noteField,
                                    flag: flagSwitch,
                                    datePickerIsOn: reminderMeSwitch,
                                    reminderMeDate: reminderDate,
                                    notifyId: id)
            notificationManager.dispatchNotification(title: Theme.Text.taskReminder,
                                                     body: titleField,
                                                     date: reminderDate)
            saveComplitionHandler?()
            dismiss(animated: true)
        }
    }
    
    @objc func tapDeleteTask() {
        let deleteButton = viewTaskUI.deleteTaskButton
        deleteButton.buttonBounceAnimation(button: deleteButton)
        Alert.deleteTaskAlert(on: self,
                              with: Theme.Text.deleteTaskAlertTitle,
                              message: Theme.Text.deleteTaskAlertBody)
        {
            self.deleteTask()
        }
    }

    func deleteTask() {
        guard let taskId = task?.id else {return}
        realmManager.delete(id: taskId.stringValue)
        notificationManager.deletePendingNotification(notificationId: Configure.selectedNotificationId)
        deleteComplitionHandler?()
        dismiss(animated: true)
    }
    
    @objc func cancel() {
        checkTextValueChange()
    }
    
    func flagSwitchValueChange(_ toggle: UISwitch) {
        if toggle ==  viewTaskUI.flagSwitch {
            taskFlag = toggle.isOn
        }
    }
    
    func reminderMeSwitchValueChange(_ toggle: UISwitch) {
        if toggle ==  viewTaskUI.reminderMeSwitch {
            reminderMe = toggle.isOn
        }
    }
    
    func checkTextValueChange() {
        flagSwitchValueChange(viewTaskUI.flagSwitch)
        reminderMeSwitchValueChange(viewTaskUI.reminderMeSwitch)

        guard let taskItem = task else { return }
        if viewTaskUI.reminderMeSwitch.isOn && viewTaskUI.remindMeDatePicker.date != taskItem.reminderMeDate {
            Alert.showDiscardChangeAlert(on: self)
        } else if viewTaskUI.reminderMeSwitch.isOn == false && reminderDate != taskItem.reminderMeDate {
            Alert.showDiscardChangeAlert(on: self)
        } else if taskTitle != taskItem.title ||
                    taskNote != taskItem.note ||
                    taskFlag != taskItem.flag ||
                    reminderMe != taskItem.datePickerIsOn {
            Alert.showDiscardChangeAlert(on: self)
        } else {
            dismiss(animated: true)
        }
    }
}

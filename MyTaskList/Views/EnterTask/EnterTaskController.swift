//
//  EnterTaskScreen.swift
//  MyTaskList
//
//  Created by Tony Chen on 16/5/2023.
//

import UIKit

class EnterTaskController: UIViewController, UITextFieldDelegate {
    private var enterTaskUI = TaskUI()
    private var realmManager = RealmManager()
    private var notificationManager = NotificationManager()
    private let notificationCenter = UNUserNotificationCenter.current()
    
    public var completionHandler: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Theme.Colours.vividBlue
        
        navigationController?.navigationBar.barTintColor = Theme.Colours.vividBlue
        configureView()
        
        enterTaskUI.taskTitleTextField.becomeFirstResponder()
        enterTaskUI.taskTitleTextField.delegate = self
        enterTaskUI.noteTextField.delegate = self
        enterTaskUI.taskTitleTextField.returnKeyType = .next
        enterTaskUI.noteTextField.returnKeyType = .done
        enterTaskUI.toggleReminderMeSwitch()
        enterTaskUI.textFieldEditChange()
        dismissKeyboard()
        
        leftBarButton(title: Theme.ButtonLabel.cancelButton,
                      color: .white,
                      style: .done,
                      targe: self,
                      action: #selector(cancel))
        
        enterTaskUI.saveTaskButton.addTarget(self,
                                             action: #selector(tapSaveButton),
                                             for: .touchUpInside)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name:UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name:UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    private func configureView() {
        view.addSubview(enterTaskUI.scrollView)
        NSLayoutConstraint.activate([
            enterTaskUI.scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            enterTaskUI.scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            enterTaskUI.scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            enterTaskUI.scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])

        enterTaskUI.scrollView.addSubview(enterTaskUI.contentView)
        NSLayoutConstraint.activate([
            enterTaskUI.contentView.topAnchor.constraint(equalTo: enterTaskUI.scrollView.topAnchor),
            enterTaskUI.contentView.leadingAnchor.constraint(equalTo: enterTaskUI.scrollView.leadingAnchor),
            enterTaskUI.contentView.trailingAnchor.constraint(equalTo: enterTaskUI.scrollView.trailingAnchor),
            enterTaskUI.contentView.bottomAnchor.constraint(equalTo: enterTaskUI.scrollView.bottomAnchor),
            enterTaskUI.contentView.heightAnchor.constraint(equalTo: enterTaskUI.scrollView.heightAnchor),
            enterTaskUI.contentView.widthAnchor.constraint(equalTo: enterTaskUI.scrollView.widthAnchor),
        ])
        newUILayout()
    }
    
    private func newUILayout() {
        enterTaskUI.contentView.addSubview(enterTaskUI.taskDetailStackView)
        enterTaskUI.contentView.addSubview(enterTaskUI.flagStackView)
        enterTaskUI.contentView.addSubview(enterTaskUI.dateStackView)
        enterTaskUI.contentView.addSubview(enterTaskUI.remindMeDatePicker)
        enterTaskUI.contentView.addSubview(enterTaskUI.saveTaskButton)
        
        NSLayoutConstraint.activate([
            enterTaskUI.taskDetailStackView.topAnchor.constraint(equalTo: enterTaskUI.contentView.topAnchor, constant: 10),
            enterTaskUI.taskDetailStackView.leadingAnchor.constraint(equalTo: enterTaskUI.contentView.leadingAnchor, constant: 18),
            enterTaskUI.taskDetailStackView.trailingAnchor.constraint(equalTo: enterTaskUI.contentView.trailingAnchor, constant: -18),
            enterTaskUI.taskTitleTextField.heightAnchor.constraint(equalToConstant: 40),
            enterTaskUI.noteTextField.heightAnchor.constraint(equalToConstant: 30),
        
            enterTaskUI.flagStackView.topAnchor.constraint(equalTo: enterTaskUI.taskDetailStackView.bottomAnchor, constant: 30),
            enterTaskUI.flagStackView.leadingAnchor.constraint(equalTo: enterTaskUI.contentView.leadingAnchor, constant: 18),
            enterTaskUI.flagStackView.trailingAnchor.constraint(equalTo: enterTaskUI.contentView.trailingAnchor, constant: -18),
            
            enterTaskUI.dateStackView.topAnchor.constraint(equalTo: enterTaskUI.flagStackView.bottomAnchor, constant: 30),
            enterTaskUI.dateStackView.leadingAnchor.constraint(equalTo: enterTaskUI.contentView.leadingAnchor, constant: 18),
            enterTaskUI.dateStackView.trailingAnchor.constraint(equalTo: enterTaskUI.contentView.trailingAnchor, constant: -18),
            enterTaskUI.reminderMeSwitch.heightAnchor.constraint(equalToConstant: 31),
        
            enterTaskUI.remindMeDatePicker.topAnchor.constraint(equalTo: enterTaskUI.dateStackView.bottomAnchor, constant: 30),
            enterTaskUI.remindMeDatePicker.leadingAnchor.constraint(equalTo: enterTaskUI.contentView.leadingAnchor, constant: 18),
            enterTaskUI.remindMeDatePicker.trailingAnchor.constraint(equalTo: enterTaskUI.contentView.trailingAnchor, constant: -18),
        
            enterTaskUI.saveTaskButton.topAnchor.constraint(equalTo: enterTaskUI.remindMeDatePicker.bottomAnchor, constant: 40),
            enterTaskUI.saveTaskButton.leadingAnchor.constraint(equalTo: enterTaskUI.contentView.leadingAnchor, constant: 40),
            enterTaskUI.saveTaskButton.trailingAnchor.constraint(equalTo: enterTaskUI.contentView.trailingAnchor, constant: -40),
            enterTaskUI.saveTaskButton.heightAnchor.constraint(equalToConstant: 40),
        ])
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == enterTaskUI.taskTitleTextField {
            enterTaskUI.noteTextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
}

extension EnterTaskController {
    @objc func keyboardWillShow(notification:NSNotification) {
        guard let userInfo = notification.userInfo else { return }
        var keyboardFrame:CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)

        var contentInset:UIEdgeInsets = self.enterTaskUI.scrollView.contentInset
        contentInset.bottom = keyboardFrame.size.height + 20
        enterTaskUI.scrollView.contentInset = contentInset
    }

    @objc func keyboardWillHide(notification:NSNotification) {
        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        enterTaskUI.scrollView.contentInset = contentInset
    }
    
    @objc func tapSaveButton() {
            notificationCenter.getNotificationSettings { (settings) in
                DispatchQueue.main.async {
                    switch settings.authorizationStatus {
                    case .denied, .notDetermined:
                        Alert.showNotificationDenyAlert(on: self)
                    case .authorized, .provisional, .ephemeral:
                        self.saveTask()
                    @unknown default:
                        return
                    }
                }
            }
    }
    
    func saveTask() {
        guard let titleField = enterTaskUI.taskTitleTextField.text, !titleField.isEmpty else {return}
        let noteField = enterTaskUI.noteTextField.text ?? ""
        let flagSwitch = enterTaskUI.flagSwitch.isOn
        let reminderMeSwitch = enterTaskUI.reminderMeSwitch.isOn
        let reminderDate = enterTaskUI.remindMeDatePicker.date
        let id = notificationManager.notificationId
        
        if enterTaskUI.remindMeDatePicker.isHidden {
            realmManager.writeData(title: titleField,
                                   note: noteField,
                                   flag: flagSwitch,
                                   datePickerIsOn: reminderMeSwitch,
                                   reminderMeDate: nil,
                                   notifyId: "")
            completionHandler?()
            dismiss(animated: true)
        } else {
            notificationManager.dispatchNotification(title: "Task reminder",
                                                     body: titleField,
                                                     date: reminderDate)
            realmManager.writeData(title: titleField,
                                   note: noteField,
                                   flag: flagSwitch,
                                   datePickerIsOn: reminderMeSwitch,
                                   reminderMeDate: reminderDate,
                                   notifyId: id)
            completionHandler?()
            dismiss(animated: true)
        }
    }
    
    @objc func cancel() {
        dismiss(animated: true)
    }
    
}

//
//  TaskCell.swift
//  MyTaskList
//
//  Created by Tony Chen on 24/5/2023.
//

import UIKit

class TaskCell: UITableViewCell {
    static let taskCellIdentifier = "taskCell"
    
    let taskCellUI = TaskCellUI()
    //let viewTaskViewModel = ViewTaskViewModel()
    public var buttonTapCallBack: (() -> Void)?
    
    /// Date format for future dates
    static let futureDatesFormatter: DateFormatter = {
        let format = Theme.Text.DateTimeFormat.dateTimeFormat
        let dateFormatter = DateFormatter()
        //dateFormatter.dateStyle = .medium
        dateFormatter.dateFormat = format
        return dateFormatter
    }()
    
    
    /// Date format for Yesterday, Today and Tomorrow
    static let presentDatesFormatter: DateFormatter = {
        let format = Theme.Text.DateTimeFormat.timeFormat
        let dateFormatter = DateFormatter()
        //dateFormatter.dateStyle = .medium
        dateFormatter.dateFormat = format
        return dateFormatter
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(taskCellUI.backgroundView)
        contentView.addSubview(taskCellUI.completeCheckButton)
        contentView.addSubview(taskCellUI.taskTitleLabel)
        contentView.addSubview(taskCellUI.priorityLabel)
        contentView.addSubview(taskCellUI.flagImage)
        contentView.addSubview(taskCellUI.reminderDateLabel)
        
        taskCellUI.completeCheckButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        NSLayoutConstraint.activate([
            taskCellUI.backgroundView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 7),
            taskCellUI.backgroundView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -7),
            taskCellUI.backgroundView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            taskCellUI.backgroundView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            taskCellUI.completeCheckButton.leadingAnchor.constraint(equalTo: taskCellUI.backgroundView.leadingAnchor),
            taskCellUI.completeCheckButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -5),
            taskCellUI.completeCheckButton.heightAnchor.constraint(equalToConstant: 50),
            taskCellUI.completeCheckButton.widthAnchor.constraint(equalToConstant: 50),
            
            taskCellUI.priorityLabel.trailingAnchor.constraint(equalTo: taskCellUI.backgroundView.trailingAnchor),
            taskCellUI.priorityLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -30),
            taskCellUI.priorityLabel.heightAnchor.constraint(equalToConstant: 20),
            taskCellUI.priorityLabel.widthAnchor.constraint(equalToConstant: 60),
            
            taskCellUI.taskTitleLabel.leadingAnchor.constraint(equalTo: taskCellUI.completeCheckButton.trailingAnchor, constant: 2),
            taskCellUI.taskTitleLabel.trailingAnchor.constraint(equalTo: taskCellUI.flagImage.leadingAnchor, constant: -3),
            taskCellUI.taskTitleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -5),
            taskCellUI.taskTitleLabel.heightAnchor.constraint(equalToConstant: 30),
            
            taskCellUI.reminderDateLabel.topAnchor.constraint(equalTo: taskCellUI.taskTitleLabel.bottomAnchor, constant: 5),
            taskCellUI.reminderDateLabel.leadingAnchor.constraint(equalTo: taskCellUI.completeCheckButton.trailingAnchor),
            taskCellUI.reminderDateLabel.heightAnchor.constraint(equalToConstant: 14),
            taskCellUI.reminderDateLabel.widthAnchor.constraint(equalToConstant: 240),
            
            taskCellUI.flagImage.trailingAnchor.constraint(equalTo: taskCellUI.backgroundView.trailingAnchor, constant: -20),
            taskCellUI.flagImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 5),
            taskCellUI.flagImage.heightAnchor.constraint(equalToConstant: 30),
            taskCellUI.flagImage.widthAnchor.constraint(equalToConstant: 30),
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        taskCellUI.taskTitleLabel.text = nil
        taskCellUI.reminderDateLabel.text = nil
        taskCellUI.priorityLabel.text = nil
    }
    
    func configureTaskTitle(taskTitle: String) {
        taskCellUI.taskTitleLabel.attributedText = taskTitle.removeStrikeThrough()
        taskCellUI.taskTitleLabel.font = .systemFont(ofSize: 15, weight: .semibold)
        taskCellUI.taskTitleLabel.textColor = Theme.Colours.black
    }
    
    func completedTaskTitle(taskTitle: String) {
        taskCellUI.taskTitleLabel.attributedText = taskTitle.strikeThrough()
        taskCellUI.taskTitleLabel.font = .systemFont(ofSize: 15, weight: .light)
        taskCellUI.taskTitleLabel.textColor = Theme.Colours.systemGray2
    }
    
    func configurePriority(priority: String) {
        switch priority {
        case "High":
            setPriorityLabel(priority: priority, txtColour: Theme.Colours.whiteColour, bkColour: Theme.Colours.red)
        case "Medium":
            setPriorityLabel(priority: priority, txtColour: Theme.Colours.whiteColour, bkColour: Theme.Colours.orange)
        case "Low":
            setPriorityLabel(priority: priority, txtColour: Theme.Colours.whiteColour, bkColour: Theme.Colours.green)
        default:
            setPriorityLabel(priority: priority, txtColour: Theme.Colours.whiteColour, bkColour: Theme.Colours.whiteColour)
        }
    }
    
    func configureFlag(showImage: Bool) {
        if showImage == true {
            taskCellUI.flagImage.isHidden = false
        } else {
            taskCellUI.flagImage.isHidden = true
        }
    }
    
    func displayReminderMeDate(date: Date) {
        let formatedFutureDate = TaskCell.futureDatesFormatter.string(from: date)
        let formatedPresentDate = TaskCell.presentDatesFormatter.string(from: date)

        if Calendar.current.isDateInToday(date) {
            taskCellUI.reminderDateLabel.text = "\(Theme.Text.today) \(formatedPresentDate)"
        } else if Calendar.current.isDateInYesterday(date) {
            taskCellUI.reminderDateLabel.text = "\(Theme.Text.yesterday) \(formatedPresentDate)"
        } else if Calendar.current.isDateInTomorrow(date) {
            taskCellUI.reminderDateLabel.text = "\(Theme.Text.tomorrow) \(formatedPresentDate)"
        } else {
            taskCellUI.reminderDateLabel.text = formatedFutureDate
        }
    }
    
    func configureCompleteButton(imageName: String, size: Double, color: UIColor, state: UIControl.State) {
            self.taskCellUI.completeCheckButton.sfButtonState(sfImage: imageName,
                                              sfSize: size,
                                              color: color,
                                              state: state)
    }
    
    @objc func buttonTapped() {
        taskCellUI.completeCheckButton.checkboxAnimation {
            self.buttonTapCallBack?()
        }
       }
}

extension TaskCell {
    // Configure priority text and colour
    func setPriorityLabel(priority: String, txtColour: UIColor, bkColour: UIColor) {
        taskCellUI.priorityLabel.text = priority
        taskCellUI.priorityLabel.textColor = txtColour
        taskCellUI.priorityLabel.backgroundColor = bkColour
    }
}

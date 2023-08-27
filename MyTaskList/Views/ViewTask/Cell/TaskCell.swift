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
    let enterTaskUI = TaskUI()
    let viewTaskViewModel = ViewTaskViewModel()
    
    /// Date format for future dates
    static let futureDatesFormatter: DateFormatter = {
        let format = "EEEE, MMM d, yyyy, h:mm a"
        let dateFormatter = DateFormatter()
        //dateFormatter.dateStyle = .medium
        dateFormatter.dateFormat = format
        return dateFormatter
    }()
    
    
    /// Date format for Yesterday, Today and Tomorrow
    static let presentDatesFormatter: DateFormatter = {
        let format = "h:mm a"
        let dateFormatter = DateFormatter()
        //dateFormatter.dateStyle = .medium
        dateFormatter.dateFormat = format
        return dateFormatter
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(taskCellUI.backgroundView)
        contentView.addSubview(taskCellUI.taskTitleLabel)
        contentView.addSubview(taskCellUI.completeCheckButton)
        contentView.addSubview(taskCellUI.flagImage)
        contentView.addSubview(taskCellUI.reminderMeLabel)
        
        taskCellUI.completeCheckButton.addTarget(self, action: #selector(completeTask), for: .touchUpInside)
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
            
            taskCellUI.completeCheckButton.leadingAnchor.constraint(equalTo: taskCellUI.backgroundView.leadingAnchor, constant: 10),
            taskCellUI.completeCheckButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 1),
//            taskCellUI.completeCheckButton.heightAnchor.constraint(equalToConstant: 21),
//            taskCellUI.completeCheckButton.widthAnchor.constraint(equalToConstant: 21),
            
            taskCellUI.taskTitleLabel.leadingAnchor.constraint(equalTo: taskCellUI.completeCheckButton.trailingAnchor, constant: 15),
            taskCellUI.taskTitleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            taskCellUI.taskTitleLabel.heightAnchor.constraint(equalToConstant: 30),
            taskCellUI.taskTitleLabel.widthAnchor.constraint(equalToConstant: 240),
            
            taskCellUI.reminderMeLabel.topAnchor.constraint(equalTo: taskCellUI.taskTitleLabel.bottomAnchor),
            taskCellUI.reminderMeLabel.leadingAnchor.constraint(equalTo: taskCellUI.completeCheckButton.centerXAnchor, constant: 30),
            taskCellUI.reminderMeLabel.heightAnchor.constraint(equalToConstant: 14),
            taskCellUI.reminderMeLabel.widthAnchor.constraint(equalToConstant: 240),
            
            taskCellUI.flagImage.trailingAnchor.constraint(equalTo: taskCellUI.backgroundView.trailingAnchor, constant: -30),
            taskCellUI.flagImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            taskCellUI.flagImage.heightAnchor.constraint(equalToConstant: 40),
            taskCellUI.flagImage.widthAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        taskCellUI.taskTitleLabel.text = nil
        taskCellUI.reminderMeLabel.text = nil
    }
    
    func configureCell(taskTitle: String) {
        taskCellUI.taskTitleLabel.text = taskTitle
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
            taskCellUI.reminderMeLabel.text = "Today, \(formatedPresentDate)"
        } else if Calendar.current.isDateInYesterday(date) {
            taskCellUI.reminderMeLabel.text = "Yesterday, \(formatedPresentDate)"
        } else if Calendar.current.isDateInTomorrow(date) {
            taskCellUI.reminderMeLabel.text = "Tomorrow, \(formatedPresentDate)"
        } else {
            taskCellUI.reminderMeLabel.text = formatedFutureDate
        }
    }
    
    @objc func completeTask(_ sender: UIButton) {
        sender.checkboxAnimation() {
            sender.isSelected
            self.taskCellUI.toggleStrikeThrough(for: self.taskCellUI.taskTitleLabel)
            
        }
    }
    
    
    
}

//
//  TaskCellUI.swift
//  MyTaskList
//
//  Created by Tony Chen on 24/5/2023.
//

import Foundation
import UIKit

class TaskCellUI: UIView {
    /// Display task titile in cell
    lazy var taskTitleLabel: UILabel = {
        var taskTitleLabel = UILabel()
        //taskTitleLabel.font = .systemFont(ofSize: 15)
        taskTitleLabel.textColor = Theme.Colours.black
        taskTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        return taskTitleLabel
    }()
    
    /// Checkbox to mark task complete
    lazy var completeCheckButton: UIButton = {
        var completeCheckButton = UIButton(type: .custom)
        completeCheckButton.backgroundColor = Theme.Colours.whiteColour
        completeCheckButton.layer.cornerRadius = 10
        completeCheckButton.clipsToBounds = true
        completeCheckButton.translatesAutoresizingMaskIntoConstraints = false
        return completeCheckButton
    }()
    
    /// View background to display as each cell
    lazy var backgroundView: UIView = {
        var backgroundView = UIView()
        backgroundView.backgroundColor = Theme.Colours.whiteColour
        backgroundView.layer.cornerRadius = 10
        backgroundView.layer.shadowColor = Theme.Colours.systemGray.cgColor
        backgroundView.layer.shadowOffset = CGSize(width: 0, height: 0)
        backgroundView.layer.shadowOpacity = 0.4
        backgroundView.layer.masksToBounds = false
        backgroundView.layer.shouldRasterize = true
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        return backgroundView
    }()
    
    /// Display Reminder Date
    lazy var reminderDateLabel: UILabel = {
        var reminderDateLabel = UILabel()
        reminderDateLabel.font = .systemFont(ofSize: 13)
        reminderDateLabel.textColor = Theme.Colours.darkGray
        reminderDateLabel.translatesAutoresizingMaskIntoConstraints = false
        return reminderDateLabel
    }()
    
    /// Display Priority
    lazy var priorityLabel: UILabel = {
        var priorityLabel = UILabel()
        priorityLabel.font = .systemFont(ofSize: 12, weight: .medium)
        priorityLabel.textAlignment = .center
        priorityLabel.layer.cornerRadius = 8
        priorityLabel.layer.masksToBounds = true
        priorityLabel.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        priorityLabel.translatesAutoresizingMaskIntoConstraints = false
        return priorityLabel
    }()
    
    /// Display flag image
    lazy var flagImage: UIImageView = {
        var flagImage = UIImageView()
        flagImage.contentMode = .scaleAspectFit
        let sfFlagName = Theme.Images.flagFill
//        flagImage.image = UIImage(systemName: sfFlagName, withConfiguration: nil)?.withTintColor(Theme.Colours.orange, renderingMode: .alwaysOriginal)
        flagImage.image = UIImage(named: Theme.Images.flagRedFill)
        flagImage.isHidden = true
        flagImage.translatesAutoresizingMaskIntoConstraints = false
        return flagImage
    }()
}

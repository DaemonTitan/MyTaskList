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
        taskTitleLabel.font = .systemFont(ofSize: 15)
        taskTitleLabel.textColor = .black
        taskTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        return taskTitleLabel
    }()
    
    /// Checkbox to mark task complete
    lazy var completeCheckButton: UIButton = {
        var completeCheckButton = UIButton(type: .custom)
        completeCheckButton.backgroundColor = Theme.Colours.whiteColour
        completeCheckButton.layer.cornerRadius = 10
        completeCheckButton.sfButtonState(sfImage: "square",
                                          sfSize: 25.0,
                                          color: Theme.Colours.lightGray,
                                          state: .normal)
        completeCheckButton.sfButtonState(sfImage: "checkmark.square.fill",
                                          sfSize: 25.0,
                                          color: Theme.Colours.green,
                                          state: .selected)
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
    lazy var reminderMeLabel: UILabel = {
        var dateLabel = UILabel()
        dateLabel.font = .systemFont(ofSize: 13)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        return dateLabel
    }()
    
    /// Display flag image
    lazy var flagImage: UIImageView = {
        var flagImage = UIImageView()
        flagImage.contentMode = .scaleAspectFit
        let sfFlagName = "flag.fill"
//        flagImage.image = UIImage(systemName: sfFlagName, withConfiguration: nil)?.withTintColor(Theme.Colours.orange, renderingMode: .alwaysOriginal)
        flagImage.image = UIImage(named: Theme.images.flagRedFill)
        flagImage.isHidden = true
        flagImage.translatesAutoresizingMaskIntoConstraints = false
        return flagImage
    }()
}

extension TaskCellUI {
    
    func toggleStrikeThrough(for label: UILabel) {
        let currentAttributes = label.attributedText?.attributes(at: 0, effectiveRange: nil)
        let hasStrikeThrough = currentAttributes?[NSAttributedString.Key.strikethroughStyle] != nil
        
        let attributedText = NSMutableAttributedString(string: label.text ?? "")
        
        if hasStrikeThrough {
            attributedText.removeAttribute(NSAttributedString.Key.strikethroughStyle,
                                           range: NSMakeRange(0, attributedText.length))
            label.textColor = .black
        } else {
            attributedText.addAttribute(NSAttributedString.Key.strikethroughStyle,
                                        value: NSUnderlineStyle.single.rawValue,
                                        range: NSMakeRange(0, attributedText.length))
            label.textColor = .systemGray2
        }
        
        label.attributedText = attributedText
    }
}

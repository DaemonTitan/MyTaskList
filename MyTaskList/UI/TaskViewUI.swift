//
//  UIComponents.swift
//  MyTaskList
//
//  Created by Tony Chen on 16/5/2023.
//

import Foundation
import UIKit

class TaskViewUI: UIViewController {
    /// Create Task Button
    lazy var plusButton: UIButton = {
        var plusButton = UIButton()
        plusButton.setImage(UIImage(named: Theme.images.plusButton), for: .normal)
        plusButton.layer.cornerRadius = 25
        plusButton.clipsToBounds = true
        plusButton.layer.shadowColor = Theme.Colours.blueShadowColor.cgColor
        plusButton.layer.shadowOffset = CGSize(width: 1.0, height: 6.0)
        plusButton.layer.shadowOpacity = 0.8
        plusButton.layer.masksToBounds = false
        plusButton.translatesAutoresizingMaskIntoConstraints = false
        return plusButton
    }()
    
}

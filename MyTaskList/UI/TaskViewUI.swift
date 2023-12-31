//
//  UIComponents.swift
//  MyTaskList
//
//  Created by Tony Chen on 16/5/2023.
//

import Foundation
import UIKit
import Lottie

class TaskViewUI: UIViewController {
    /// Create Task Button
    lazy var plusButton: UIButton = {
        var plusButton = UIButton()
        plusButton.setImage(UIImage(named: Theme.Images.plusButton), for: .normal)
        plusButton.layer.cornerRadius = 25
        plusButton.clipsToBounds = true
        plusButton.layer.shadowColor = Theme.Colours.blueShadowColor.cgColor
        plusButton.layer.shadowOffset = CGSize(width: 1.0, height: 6.0)
        plusButton.layer.shadowOpacity = 0.8
        plusButton.layer.masksToBounds = false
        plusButton.translatesAutoresizingMaskIntoConstraints = false
        return plusButton
    }()
    
    /// My Task View Bottom Blur Effects
//    lazy var blurView: UIVisualEffectView = {
//        let blurEffect = UIBlurEffect(style: .regular)
//        let blurView = UIVisualEffectView(effect: blurEffect)
//        blurView.layer.masksToBounds = true
//        blurView.clipsToBounds = true
//        blurView.alpha = 0.65
//        blurView.translatesAutoresizingMaskIntoConstraints = false
//        return blurView
//    }()
    
    /// No record found
    lazy var noRecordGif: LottieAnimationView = {
        var noRecordGif = LottieAnimationView()
        noRecordGif = .init(name: Theme.Images.noRecordFoundGif)
        noRecordGif.contentMode = .scaleAspectFit
        noRecordGif.loopMode = .loop
        noRecordGif.animationSpeed = 1.0
        noRecordGif.clearsContextBeforeDrawing = true
        noRecordGif.translatesAutoresizingMaskIntoConstraints = false
        return noRecordGif
    }()
    
    lazy var noTaskLabel: UILabel = {
        let noTaskLabel = UILabel()
        noTaskLabel.textAlignment = NSTextAlignment.center
        noTaskLabel.textColor = Theme.Colours.black
        noTaskLabel.font = .systemFont(ofSize: 20, weight: .bold)
        noTaskLabel.text = Theme.Text.noTaskFoundLabel
        noTaskLabel.translatesAutoresizingMaskIntoConstraints = false
        return noTaskLabel
    }()
    
    lazy var noTaskFoundDescription: UILabel = {
        let noTaskFoundDescription = UILabel()
        noTaskFoundDescription.textAlignment = NSTextAlignment.center
        noTaskFoundDescription.textColor = Theme.Colours.gray
        noTaskFoundDescription.font = .systemFont(ofSize: 17)
        noTaskFoundDescription.numberOfLines = 0
        noTaskFoundDescription.text = Theme.Text.noTaskFoundDescrip
        noTaskFoundDescription.translatesAutoresizingMaskIntoConstraints = false
        return noTaskFoundDescription
    }()
}

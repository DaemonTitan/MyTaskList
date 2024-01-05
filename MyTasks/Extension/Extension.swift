//
//  ViewControllerExtension.swift
//  MyTaskList
//
//  Created by Tony Chen on 18/5/2023.
//

import Foundation
import UIKit

// MARK: UI View Controller Extension
extension UIViewController {
    /// Add button to top right of navigation bar
    public func rightBarButton(title: String, color: UIColor, style: UIBarButtonItem.Style, targe: Any, action: Selector) {
        let rightBarButton = UIBarButtonItem(title: title, style: style, target: targe, action: action)
        rightBarButton.tintColor = color
        navigationItem.rightBarButtonItem = rightBarButton
    }
    
    /// Add button to top left of navigation bar
    public func leftBarButton(title: String, color: UIColor, style: UIBarButtonItem.Style, targe: Any, action: Selector) {
        let leftBarButton = UIBarButtonItem(title: title, style: style, target: targe, action: action)
        leftBarButton.tintColor = color
        navigationItem.leftBarButtonItem = leftBarButton
    }
    
    /// User tap on screen to dismiss keyboard
    func dismissKeyboard() {
           let tap: UITapGestureRecognizer = UITapGestureRecognizer( target: self,
                                                                     action: #selector(UIViewController.dismissKeyboardTouchOutside))
           tap.cancelsTouchesInView = false
           view.addGestureRecognizer(tap)
        }
        
    @objc private func dismissKeyboardTouchOutside() {
       view.endEditing(true)
    }
    
}

// MARK: UITextField Extension
extension UITextField {
    /// Add padding to textField
    func addPadding() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    
    /// Add bottom boarder to UITextField
    internal func addBottomBorder(height: CGFloat = 0.5 , color: UIColor = .black) {
          let borderView = UIView()
          borderView.backgroundColor = color
          borderView.translatesAutoresizingMaskIntoConstraints = false
          addSubview(borderView)
          NSLayoutConstraint.activate(
              [
                  borderView.leadingAnchor.constraint(equalTo: leadingAnchor),
                  borderView.trailingAnchor.constraint(equalTo: trailingAnchor),
                  borderView.bottomAnchor.constraint(equalTo: bottomAnchor),
                  borderView.heightAnchor.constraint(equalToConstant: height)
              ]
          )
      }
    
    /// Listen to UITextField text edit change
    func textFieldEditChangeListner(onTextEdit: @escaping () -> Void) {
        self.addAction(UIAction() { action in
            onTextEdit()
        }, for: .editingChanged)
    }
}

// MARK: UILabel Extension
extension UILabel {
    /// Add image to the front of label
    func addImageToFrontLabel(image: UIImage, text: String) {
        // Create Attachment
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = image
        // Set bound to reposition
        let imageOffsetY: CGFloat = -7.0
        imageAttachment.bounds = CGRect(x: 0, y: imageOffsetY, width: imageAttachment.image!.size.width, height: imageAttachment.image!.size.height)
        // Create string with attachment
        let attachmentString = NSAttributedString(attachment: imageAttachment)
        // Initialize mutable string
        let completeText = NSMutableAttributedString(string: "")
        // Add image to mutable string
        completeText.append(attachmentString)
        // Add your text to mutable string
        let textAfterIcon = NSAttributedString(string: text)
        completeText.append(textAfterIcon)
        self.textAlignment = .center
        self.attributedText = completeText
    }
}

// MARK: UIButton Extension
extension UIButton {
    /// Animate check mark
    func checkboxAnimation(closure: @escaping () -> Void){
        guard let image = self.imageView else {return}
        self.isHighlighted = false

        UIView.animate(withDuration: 0.1, delay: 0.1, options: .curveLinear, animations: {
            image.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)

        }) { (success) in
            UIView.animate(withDuration: 0.1, delay: 0, options: .curveLinear, animations: {
                self.isSelected = !self.isSelected
                //to-do
                closure()
                image.transform = .identity
            }, completion: nil)
        }
    }
    
    /// Display SF symbol in UIButton
    func sfButtonState(sfImage: String, sfSize: Double, color: UIColor, state: State) {
        let sfImage = sfImage
        let sfImageConfig = UIImage.SymbolConfiguration(font: .systemFont(ofSize: CGFloat(sfSize)))
        let image = UIImage(systemName: sfImage, withConfiguration: sfImageConfig)?.withTintColor(color, renderingMode: .alwaysOriginal)
        self.setImage(image, for: state)
    }
    
    /// UIButton touch up inside
    func buttonTouchUpInside(touchUpAction: @escaping () -> Void) {
        addAction(UIAction() { action in
            touchUpAction()
        }, for: .touchUpInside)
    }
    
    func buttonBounceAnimation(button: UIButton) {
        button.transform = CGAffineTransform(scaleX: 0.50, y: 0.50)
        UIView.animate(withDuration: 0.8,
                       delay: 0,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 2.0,
                       options: .allowUserInteraction,
                       animations: {
            button.transform = .identity
        }, completion: nil)
    }
}

extension String {
    func strikeThrough() -> NSAttributedString {
        let attributedText = NSMutableAttributedString(string: self)
        attributedText.addAttribute(NSAttributedString.Key.strikethroughStyle,
                                    value: NSUnderlineStyle.single.rawValue,
                                    range: NSMakeRange(0, attributedText.length))
        return attributedText
    }
    
    func removeStrikeThrough() -> NSAttributedString {
        let attributedText = NSMutableAttributedString(string: self)
        attributedText.addAttribute(NSAttributedString.Key.strikethroughStyle,
                                    value: [],
                                    range: NSMakeRange(0, attributedText.length))
        return attributedText
    }
}

// MARK: UISwitch Extension
extension UISwitch {
    /// Listen to UISwtich edtit change
    func switchEditChangeListner(onValueChange: @escaping () -> Void) {
        addAction(UIAction() { action in
            onValueChange()
        }, for: .valueChanged)
    }
}

// MARK: UIDatePicker Extension
extension UIDatePicker {
    /// Listen to date picker edit change
    func datePickerEditChangeListner(onValueChange: @escaping () -> Void) {
        addAction(UIAction() { action in
            onValueChange()
        }, for: .valueChanged)
    }
}

//
//  TaskTableViewModel.swift
//  MyTaskList
//
//  Created by Tony Chen on 16/8/2023.
//

import Foundation
import UIKit

class TaskTableViewModel {
    var taskViewUI = TaskViewUI()
    
    func noRecordsFoundSetup(view: UIView, tableView: UITableView) {
        let noRecordGif = taskViewUI.noRecordGif
        let noTaskLabel = taskViewUI.noTaskLabel
        let noTaskFoundDescription = taskViewUI.noTaskFoundDescription
        
        view.addSubview(noRecordGif)
        view.addSubview(noTaskLabel)
        view.addSubview(noTaskFoundDescription)
        noRecordGif.play()
        
        NSLayoutConstraint.activate([
            noRecordGif.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            noRecordGif.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -140),
            noRecordGif.widthAnchor.constraint(equalToConstant:  250),
            noRecordGif.heightAnchor.constraint(equalToConstant: 250),
            
            noTaskLabel.topAnchor.constraint(equalTo: noRecordGif.bottomAnchor),
            noTaskLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            noTaskLabel.heightAnchor.constraint(equalToConstant: 40),
            noTaskLabel.widthAnchor.constraint(equalToConstant: 180),
            
            noTaskFoundDescription.topAnchor.constraint(equalTo: noTaskLabel.bottomAnchor),
            noTaskFoundDescription.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            noTaskFoundDescription.heightAnchor.constraint(equalToConstant: 80),
            noTaskFoundDescription.widthAnchor.constraint(equalToConstant: 340)
        ])
    }
    
    func restore() {
        taskViewUI.noRecordGif.stop()
        taskViewUI.noRecordGif.removeFromSuperview()
        taskViewUI.noTaskLabel.removeFromSuperview()
        taskViewUI.noTaskFoundDescription.removeFromSuperview()
    
    }
}

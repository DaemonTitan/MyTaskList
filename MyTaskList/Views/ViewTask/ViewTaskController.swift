//
//  ViewController.swift
//  MyTaskList
//
//  Created by Tony Chen on 16/5/2023.
//

import UIKit

var selectedNotificationId: String = ""

class ViewTaskController: UIViewController {
    
    private var taskViewUI = TaskViewUI()
    var notificationManager = NotificationManager()
    var realmManager = RealmManager()
    
    lazy var tableView: UITableView = {
        var tableView = UITableView()
        tableView.register(TaskCell.self, forCellReuseIdentifier: TaskCell.taskCellIdentifier)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = Theme.Text.viewTaskControllerTitle
        view.addSubview(tableView)
        view.addSubview(taskViewUI.blurView)
        view.addSubview(taskViewUI.plusButton)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        
        notificationManager.notificationPermission(vc: self)
        notificationManager.notificationList()
        buttonLayout()
        realmManager.openRealm()
        realmManager.viewOpenedTask()
        realmManager.viewCompletedTask()
        
        // find realm file location
        realmManager.findRealmFile()
        
        taskViewUI.plusButton.addTarget(self, action: #selector(createTask), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }

    func buttonLayout() {
        NSLayoutConstraint.activate([
            taskViewUI.plusButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 120),
            taskViewUI.plusButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 300),
            taskViewUI.plusButton.heightAnchor.constraint(equalToConstant: 50),
            taskViewUI.plusButton.widthAnchor.constraint(equalToConstant: 50),
            
            taskViewUI.blurView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            taskViewUI.blurView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            taskViewUI.blurView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            taskViewUI.blurView.topAnchor.constraint(equalTo: taskViewUI.plusButton.topAnchor, constant: -20)
        ])
    }
    
    @objc func createTask() {
        let rootEnterTaskController = EnterTaskController()
        
        rootEnterTaskController.completionHandler = { [weak self] in
            self?.realmManager.readData()
            self?.tableView.reloadData()
        }
        
        let enterTaskController = UINavigationController(rootViewController: rootEnterTaskController)
        present(enterTaskController, animated: true)
    }
}

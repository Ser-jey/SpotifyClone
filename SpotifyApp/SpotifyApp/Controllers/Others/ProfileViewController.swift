//
//  ProfileViewController.swift
//  SpotifyApp
//
//  Created by Сергей Кривошеев on 23.04.2023.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.isHidden = true
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    private var models: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Profile"
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        fetchProfile()
        view.backgroundColor = .systemBackground
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    private func fetchProfile() {
        APICaller.shared.getCurrentUserProfile { [weak self] result in
            DispatchQueue.main.async {
                self?.failedToGetProfile()

                switch result {
                case .success(let model):
                    self?.updateUI(with: model)
                case .failure(let error):
                    print("Failed to get Profile\(error)")
                    self?.failedToGetProfile()
                }
            }
        }
    }
    
    private func updateUI(with model: UserProfile) {
        tableView.isHidden = false
        // configure table models
        models.append("Full Name: \(model.display_name)")
        models.append("Email Address: \(model.email)")
        models.append("USER ID: \(model.id)")
        models.append("Plan: \(model.product)")

        tableView.reloadData()
    }
    
    private func failedToGetProfile() {
        let label = UILabel(frame: .zero)
        label.text = "Failed to load profile."
        label.textColor = .secondaryLabel
        label.sizeToFit()
        view.addSubview(label)
        label.center = view.center
        
    }
    
    //MARK: - TABLEVIEW
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        models.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.selectionStyle = .none
        cell.textLabel?.text = models[indexPath.row]
        return cell
    }
    
    
    
    
}

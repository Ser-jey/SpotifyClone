//
//  ProfileViewController.swift
//  SpotifyApp
//
//  Created by Сергей Кривошеев on 23.04.2023.
//

import UIKit

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Profile"
        APICaller.shared.getCurrentUserProfile { result in
            switch result {
            case .success(let model):
                break
            case .failure(let error):
                print("\(error.localizedDescription) /////")
            }
        }
    }

}

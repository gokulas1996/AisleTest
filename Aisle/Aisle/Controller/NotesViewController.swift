//
//  NotesViewController.swift
//  Aisle
//
//  Created by Gokul A S on 24/09/22.
//

import UIKit

class NotesViewController: UIViewController {
    
    var token: String = ""
    var networkManager = NetworkManager.shared
    var notes: Notes?
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var notesImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViews()
        self.fetchNotes {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    func setupViews() {
        self.notesImageView.layer.cornerRadius = 10.0
        self.notesImageView.layer.masksToBounds = true
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
    func fetchNotes(completion: @escaping () -> ()) {
        let headers = [Constants.authorization : token]
        networkManager.fetchData(endPoint: Constants.test_profile_list, headers: headers, parameters: nil, httpMethod: .get) { data, status, error in
            if let data = data {
                self.notes = try? JSONDecoder().decode(Notes.self, from: data)
                completion()
            }
        }
    }
}

extension NotesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.cell, for: indexPath) as! NotesCollectionViewCell
        cell.likesLabel.text = self.notes?.likes?.profiles?[indexPath.row].first_name
        if let imageURL = self.notes?.likes?.profiles?[indexPath.row].avatar {
            cell.likesImageView.imageFromServerURL(urlString: imageURL, PlaceHolderImage: UIImage(named: Constants.placeholderImage)!)
        }
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.notes?.likes?.likes_received_count ?? 1
    }    
}



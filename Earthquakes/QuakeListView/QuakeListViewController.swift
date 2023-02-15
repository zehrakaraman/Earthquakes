//
//  QuakeListViewController.swift
//  Earthquakes
//
//  Created by Zehra on 12.01.2023.
//

import UIKit

private let reuseIdentifier = "Cell"

class QuakeListViewController: UICollectionViewController {
    
    var dataSource: DataSource!
    var quakes: [Quake] = Quake.sampleData

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Earthquakes"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let listLayout = listLayout()
        collectionView.collectionViewLayout = listLayout
        
        prepareForViewing()
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        if editing {
            prepareForEditing()
        } else {
            prepareForViewing()
        }
    }
    
    private func prepareForEditing() {
        updateCellRegistration()
        
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(didCancelEdit))
        navigationItem.rightBarButtonItem = cancelButton
        let selectAllButton = UIBarButtonItem(title: "Select All", style: .plain, target: self, action: #selector(didPressSelectAllButton))
        navigationItem.leftBarButtonItem = selectAllButton
        
        updateSnapshot()
    }
    
    private func prepareForViewing() {
        updateCellRegistration()
        
        navigationItem.rightBarButtonItem = editButtonItem
        navigationItem.leftBarButtonItem = nil
        
        updateSnapshot()
    }
    
    private func updateCellRegistration() {
        let cellRegistration = UICollectionView.CellRegistration(handler: cellRegistrationHandler)
        dataSource = DataSource(collectionView: collectionView) { (collectionView: UICollectionView, indexPath: IndexPath, identifier: Quake.ID) in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: identifier)
        }
    }
    
    private func listLayout() -> UICollectionViewCompositionalLayout {
        var listConfiguration = UICollectionLayoutListConfiguration(appearance: .grouped)
        listConfiguration.showsSeparators = true
        listConfiguration.backgroundColor = .clear
        return UICollectionViewCompositionalLayout.list(using: listConfiguration)
    }
}

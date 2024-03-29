//
//  QuakeListViewController+DataSource.swift
//  Earthquakes
//
//  Created by Zehra on 14.01.2023.
//

import UIKit

extension QuakeListViewController {
    typealias DataSource = UICollectionViewDiffableDataSource<Int, String>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, String>
    
    func cellRegistrationHandler(cell: UICollectionViewListCell, indexPath: IndexPath, id: Quake.ID) {
        let quake = quake(for: id)
        var contentConfiguration = cell.defaultContentConfiguration()
        contentConfiguration.text = quake.place
        contentConfiguration.textProperties.font = UIFont.preferredFont(forTextStyle: .title3)
        contentConfiguration.secondaryText = quake.time.dayAndTimeText
        contentConfiguration.secondaryTextProperties.color = .secondaryLabel
        cell.contentConfiguration = contentConfiguration
        
        if self.isEditing {
            var selectedButtonConfiguration = selectedButtonConfiguration(for: quake)
            selectedButtonConfiguration.tintColor = selectedQuakes.contains(where: { $0.id == quake.id }) ? .systemBlue : .systemGray2
            cell.accessories = [.customView(configuration: selectedButtonConfiguration)]
        }
    }
    
    private func selectedButtonConfiguration(for quake: Quake) -> UICellAccessory.CustomViewConfiguration {
        let symbolName = selectedQuakes.contains(where: { $0.id == quake.id }) ? "checkmark.circle.fill" : "circle"
        let symbolConfiguration = UIImage.SymbolConfiguration(textStyle: .title2)
        let image = UIImage(systemName: symbolName, withConfiguration: symbolConfiguration)
        let button = QuakeSelectedButton()
        button.id = quake.id
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(didPressSelectedButton(_:)), for: .touchUpInside)
        
        UIView.animate(withDuration: 0.5) { [weak self] in
            self?.view.layoutIfNeeded()
        }
        
        return UICellAccessory.CustomViewConfiguration(customView: button, placement: .leading(displayed: .always))
    }
    
//    private func quakeMagnitudeConfiguration() -> UICellAccessory.CustomViewConfiguration {
//        let view = UIView(frame: CGRect(x: 5, y: 5, width: 10, height: collectionView.frame.size.height - 10))
//        let roundedRectangle = UIView()
//        collectionView.addSubview(view)
//        view.addSubview(roundedRectangle)
//        roundedRectangle.translatesAutoresizingMaskIntoConstraints = false
//
//        roundedRectangle.layer.cornerRadius = 8
//        roundedRectangle.backgroundColor = .black
//
//        NSLayoutConstraint.activate([
//            roundedRectangle.widthAnchor.constraint(equalToConstant: 80),
//            roundedRectangle.heightAnchor.constraint(equalToConstant: 60),
//            roundedRectangle.topAnchor.constraint(equalTo: view.topAnchor, constant: 2),
//            roundedRectangle.leftAnchor.constraint(equalTo: view.leftAnchor, constant: -10),
//            roundedRectangle.bottomAnchor.constraint(equalTo: view.bottomAnchor),
//            roundedRectangle.rightAnchor.constraint(equalTo: view.rightAnchor),
//        ])
//
//        return UICellAccessory.CustomViewConfiguration(customView: view, placement: .leading())
//    }
    
    func selectQuake(with id: Quake.ID) {
        if !selectedQuakes.contains(where: { $0.id ==  id }) {
            let quake = quake(for: id)
            let index = quakes.indexOfQuake(with: id)
            selectedQuakes.append(quake)
//            collectionView.selectItem(at: IndexPath(item: index, section: 0), animated: true, scrollPosition: .centeredHorizontally)
        } else {
            let index = selectedQuakes.indexOfQuake(with: id)
            selectedQuakes.remove(at: index)
//            collectionView.deselectItem(at: IndexPath(item: index, section: 0), animated: true)
        }
        updateSnapshot(reloading: [id])
    }
    
    func updateSnapshot(reloading idsThatChanged: [Quake.ID] = []) {
        let ids = idsThatChanged.filter { id in quakes.contains(where: { $0.id == id })}
        var snapshot = Snapshot()
        snapshot.appendSections([0])
        snapshot.appendItems(quakes.map { $0.id })
        if !ids.isEmpty {
            snapshot.reloadItems(ids)
        }
        dataSource.apply(snapshot)
    }
    
    func quake(for id: Quake.ID) -> Quake {
        let index = quakes.indexOfQuake(with: id)
        return quakes[index]
    }
}

//
//  QuakeListViewController+Actions.swift
//  Earthquakes
//
//  Created by Zehra on 14.01.2023.
//

import UIKit

extension QuakeListViewController {
    @objc func didCancelEdit() {
        setEditing(false, animated: true)
    }
    
    @objc func didPressSelectedButton(_ sender: QuakeSelectedButton) {
        guard let id = sender.id else { return }
        selectQuake(with: id)
    }
    
    @objc func didPressSelectAllButton() {
        selectMode.toggle()
        let deselectAllButton = UIBarButtonItem(title: "Deselect All", style: .plain, target: self, action: #selector(didPressDeselectAllButton))
        navigationItem.leftBarButtonItem = deselectAllButton
    }
    
    @objc func didPressDeselectAllButton() {
        selectMode.toggle()
        let selectAllButton = UIBarButtonItem(title: "Select All", style: .plain, target: self, action: #selector(didPressSelectAllButton))
        navigationItem.leftBarButtonItem = selectAllButton
    }
}

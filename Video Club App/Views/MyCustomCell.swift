//
//  MyCustomCell.swift
//  Video Club App
//
//  Created by Rodrigo Camargo on 4/24/21.
//

import UIKit

class MyCustomCell: UICollectionViewCell, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyCustomCell.reuseIdentifier, for: indexPath) as? MyCustomCell else {
                    fatalError("Unexpected Index Path")
                }
    }
    
    static let reuseIdentifier = "MyCustomCell"

    @IBAction func onAddToCartPressed(_ sender: Any) {
        addButtonTapAction?()
    }

    var addButtonTapAction : (() -> Void)?
}

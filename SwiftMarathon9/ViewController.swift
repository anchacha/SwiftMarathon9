//
//  ViewController.swift
//  SwiftMarathon9
//
//  Created by Anton Charny on 26/03/2023.
//

import UIKit

class ViewController: UIViewController {

    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 20
        layout.sectionInset = .init(top: .zero, left: 20, bottom: .zero, right: 20)
        return layout
    }()
    
    private lazy var collection: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: self.layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        return collection
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.collection.dataSource = self
        self.collection.delegate = self
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Collection"
        
        
        self.view.addSubview(self.collection)
        
        NSLayoutConstraint.activate([
            self.collection.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.collection.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.collection.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.collection.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
    }


}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        cell.backgroundColor = .blue
        cell.layer.cornerRadius = 16
        return cell
    }
    
    
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 50, height: collectionView.frame.height / 2)
    }

    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let itemWidth: CGFloat = view.frame.width - 50

        let cellWidth = itemWidth + self.layout.minimumLineSpacing
        let targetXContentOffset = targetContentOffset.pointee.x / cellWidth

        let offset = round(targetXContentOffset) * cellWidth - 20
        targetContentOffset.pointee.x = offset
    }
}

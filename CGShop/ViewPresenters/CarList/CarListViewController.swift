//
//  CarListViewController.swift
//  CGShop
//
//  Created by Victor Mesquita on 1/10/19.
//  Copyright © 2019 cg. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

protocol CarListViewProtocol {
    func reloadCarList(cars: [Car])
}

class CarListViewController : LoadableViewController {
    let presenter = CarListPresenter()
    var carTableData = [Car]()
    var carId: Int = 0

    
    @IBOutlet weak var filterCarSearchBar: UISearchBar!
    @IBOutlet weak var uiCarsCollection: UICollectionView!
    
    override func viewDidLoad() {
        self.presenter.attachToView(viewController: self)
        
        setupCollectionView()
        
        presenter.fetchCarList()
        
        setupView()
    }
    
    func setupView() {
        configureUiCollectionLayout()
    }
    
    func setupCollectionView(){
        uiCarsCollection.register(UICarCollectionViewCell.nib, forCellWithReuseIdentifier: ReusableIds.CarList.PRODUCT_ITEM_CELL)
    }
    
    fileprivate func configureUiCollectionLayout(){
        uiCarsCollection.collectionViewLayout = CarGridFlowLayout()
    }
    
    override func willSkeleton() -> Bool {
        return false
    }
}

extension CarListViewController : CarListViewProtocol {
    func reloadCarList(cars: [Car]) {
        carTableData = cars;
        uiCarsCollection.reloadData()
    }
}

// MARK: - CarList SearchBarDelegate
extension CarListViewController : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter.searchCar(carName: searchText)
    }
}

// MARK: - CarList Collection View
extension CarListViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.carTableData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReusableIds.CarList.PRODUCT_ITEM_CELL, for: indexPath) as! UICarCollectionViewCell
        
        
        setCellData(cell: cell, indexPath: indexPath)
        
        return cell;
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let index = indexPath.item
        
        self.carId = self.carTableData[index].id;
        
        performSegue(withIdentifier: Segues.CAR_DETAIL_SEGUE, sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let carDetailViewController = segue.destination as? CarDetailViewController, segue.identifier == Segues.CAR_DETAIL_SEGUE {
            carDetailViewController.carId = self.carId;
        }
    }
    
    func setCellData(cell: UICarCollectionViewCell, indexPath: IndexPath){
        let car:Car = carTableData[indexPath.row]
        
        cell.lbCarName.text = car.nome
        
        cell.ivCar.kf.setImage(with: URL(string: car.imagem), placeholder: UIImage(named: "placeholder"))
        
        let preco = String(describing: car.preco)
        
        cell.lbCarPrice.text = "R$ \(preco)"
    }
}

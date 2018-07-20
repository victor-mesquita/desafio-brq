//
//  RootViewController.swift
//  CGShop
//
//  Created by mac on 16/07/2018.
//  Copyright © 2018 cg. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher
import RxSwift
import RxCocoa

class RootViewController : UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var searchBarFilterCars: UISearchBar!
    @IBOutlet weak var cvCars: UICollectionView!
    
    fileprivate let disposeBag = DisposeBag();
    var cars = [CarViewModel]()
    var viewModel: RootViewModel?
    fileprivate let refreshControl = UIRefreshControl()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return self.cars.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productitem", for: indexPath) as! ProductItemUICollectionViewCell
        
        setCellData(cell: cell, indexPath: indexPath)
        
        return cell;
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        debugPrint(indexPath.item)

        let carDetailViewController = UIStoryboard.main.carDetailViewController
        self.navigationController?.pushViewController(carDetailViewController, animated: true)
//        self.present(carDetailViewController, animated: true, completion: nil)
    }
    
    func setCellData(cell: ProductItemUICollectionViewCell, indexPath: IndexPath){
        let car:CarViewModel = cars[indexPath.row]
        
        cell.lbCarName.text = car.nome
        
        cell.ivCar.kf.setImage(with: URL(string: car.imagem), placeholder: UIImage(named: "placeholder"))

        let preco = String(car.preco)
        
        cell.lbCarPrice.text = "R$ \(preco)"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        bindRx()
        configureUiCollectionLayout()
    }
    
    func bindRx(){
        guard let vm = viewModel else { return }
        
        searchBarFilterCars.rx.text.orEmpty.bind(to: vm.searchText).disposed(by: disposeBag);
        
        vm.result.subscribe(onNext: { [weak self] data in
            self?.cars = data;
            self?.cvCars.reloadData()
        })
            .disposed(by: disposeBag)
        
        vm.searchResult.subscribe(onNext: { [weak self] filteredData in
            self?.cars = filteredData
            self?.cvCars.reloadData()
        }).disposed(by: disposeBag)
    }
    
    fileprivate func configureUiCollectionLayout(){
        cvCars.collectionViewLayout = CarGridFlowLayout()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


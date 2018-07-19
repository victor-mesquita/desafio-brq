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
    fileprivate let refreshControl = UIRefreshControl()
    @IBOutlet weak var cvCars: UICollectionView!
    
    fileprivate let disposeBag = DisposeBag();
    var cars = [CarViewModel]()
    var viewModel: RootViewModel! = RootViewModel()
    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return self.cars.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "productitem") as! TableViewCell
//
//        let car: Car = cars[indexPath.row]
//
//        cell.lProductName.text = car.nome
//
//        let borderColor = UIColor(red:102/255, green:102/255, blue:102/255, alpha:1.0)
//
//        cell.layer.borderWidth = 1.0
//        cell.layer.borderColor = borderColor.cgColor
//
//        cell.ivProduct.kf.setImage(with: URL(string: car.imagem!))
//
//        return cell
//    }
//
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productitem", for: indexPath)
        
        //let car:CarViewModel = cars[indexPath.row]
        
        //        cell.lProductName.text = car.nome
        
        //        cell.ivProduct.kf.setImage(with: URL(string: car.imagem!))
        
        return cell;
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindRx()
        configureRefreshControl()
        configureUiCollectionLayout()
        
    }
    
    func bindRx(){
        guard let vm = viewModel else { return }
        
        vm.carListResult.drive(onNext: { [weak self] data in
            self?.refreshControl.endRefreshing()
            self?.cars = data
            self?.cvCars.reloadData()
        }).disposed(by: disposeBag)

        searchBarFilterCars.rx.text.orEmpty.bind(to: vm.searchText).disposed(by: disposeBag);
    }
    
    fileprivate func configureRefreshControl() {
        refreshControl.backgroundColor = UIColor.clear
        refreshControl.tintColor = UIColor.lightGray
        
        cvCars.addSubview(refreshControl)
    }
    
    fileprivate func configureUiCollectionLayout(){
        cvCars.collectionViewLayout = CarGridFlowLayout()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


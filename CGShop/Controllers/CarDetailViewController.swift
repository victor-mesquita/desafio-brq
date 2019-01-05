//
//  CarDetailViewController.swift
//  CGShop
//
//  Created by mac on 20/07/2018.
//  Copyright © 2018 cg. All rights reserved.
//

import UIKit
import RxSwift
import Kingfisher
import RxCocoa

class CarDetailViewController : UIViewController {
    
    @IBAction func onClick(_ sender: Any) {
        closeView()
    }
    
    @IBOutlet weak var carImage: UIImageView!
    @IBOutlet weak var lbCarPrice: UILabel!
    @IBOutlet weak var lbCarName: UILabel!
    @IBOutlet weak var lbContentDescrition: UILabel!
    
    
    var viewModel: CarViewModel? = nil
    
    fileprivate let disposeBag = DisposeBag();
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindToView(carViewModel: viewModel!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func bindToView(carViewModel: CarViewModel){
        lbCarPrice.text = "R$ \(carViewModel.preco)" ;
        lbCarName.text = carViewModel.nome
        lbContentDescrition.text = carViewModel.descricao
        
        carImage.kf.setImage(with: URL(string: carViewModel.imagem), placeholder: UIImage(named: "placeholder"))
    }
    
    func closeView(){
        self.dismiss(animated: true, completion: nil)
    }
}

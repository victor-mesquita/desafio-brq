import UIKit

extension UIStoryboard {
    static var main: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }
}

extension UIStoryboard {
    var rootViewController: RootViewController {
        guard let vc = UIStoryboard.main.instantiateViewController(withIdentifier: "rootViewController") as? RootViewController else {
            fatalError("RootViewController não foi encontrado")
        }
        return vc
    }
    
    var carDetailViewController: CarDetailViewController {
        guard let vc = UIStoryboard.main.instantiateViewController(withIdentifier: "carDetailViewController") as? CarDetailViewController else {
            fatalError("CarDetailViewController não foi encontrado")
        }
        return vc
    }
}

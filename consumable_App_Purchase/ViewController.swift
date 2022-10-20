//
//  ViewController.swift
//  consumable_App_Purchase
//
//  Created by AVINASH on 19/10/22.
//

import UIKit

struct Model {
    let title : String
    let handler :(() -> Void)
}

class ViewController: UIViewController {
    
    @IBOutlet weak var toggle: UISwitch!
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var models = [Model]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        toggle.isEnabled = false
        models.append(Model(title: "500 Diamond", handler: {
            IPAManager.shared.purchase(product: .dimond_500) { [weak self] count in
                DispatchQueue.main.async {
                    let currentCount = self?.mydiamondcount ?? 0
                    let newCount = currentCount + count
                    UserDefaults.standard.setValue(newCount, forKey: "diamond_Count")
                    if currentCount < newCount {
                        self?.toggleHideshow()
                    }
                   
                   // self?.setupHeader()
                }
                
            }
        }))
        models.append(Model(title: "1000 Diamond", handler: {
            IPAManager.shared.purchase(product: .dimond_1000){ [weak self] count in
                DispatchQueue.main.async {
                    let currentCount = self?.mydiamondcount ?? 0
                    let newCount = currentCount + count
                    UserDefaults.standard.setValue(newCount, forKey: "diamond_Count")
                  //  self?.setupHeader()
                    if currentCount < newCount {
                        self?.toggleHideshow()
                    }
                }
                
            }
        }))
        models.append(Model(title: "2000 Diamond", handler: {
            IPAManager.shared.purchase(product: .dimond_2000){ [weak self] count in
                DispatchQueue.main.async {
                    let currentCount = self?.mydiamondcount ?? 0
                    let newCount = currentCount + count
                    UserDefaults.standard.setValue(newCount, forKey: "diamond_Count")
                 //   self?.setupHeader()
                    if currentCount < newCount {
                        self?.toggleHideshow()
                    }
                }
                
            }
        }))
        models.append(Model(title: "5000 Diamond", handler: {
            IPAManager.shared.purchase(product: .dimond_5000){ [weak self] count in
                DispatchQueue.main.async {
                    let currentCount = self?.mydiamondcount ?? 0
                    let newCount = currentCount + count
                    UserDefaults.standard.setValue(newCount, forKey: "diamond_Count")
                   // self?.setupHeader()
                    if currentCount < newCount {
                        self?.toggleHideshow()
                    }
                }
                
            }
        }))
        
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
       // setupHeader()
    }
    
    
}

extension ViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = model.title
        cell.imageView?.image = UIImage(systemName: "heart.fill")
        cell.imageView?.tintColor = .systemRed
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
                    let model = models[indexPath.row]
                    model.handler()
                    print("------------- \(indexPath.row)")
        
//        let vc = storyboard?.instantiateViewController(withIdentifier: "Payment_Check") as! Payment_Check
//        navigationController?.pushViewController(vc, animated: true)
//        if  UserDefaults.standard.bool(forKey: "num") {
//            let model = models[indexPath.row]
//            model.handler()
//            print("------------- \(indexPath.row)")
//
//        }
        
    }
    
    
    var mydiamondcount  : Int {
        return UserDefaults.standard.integer(forKey: "diamond_Count")
        
    }
    func toggleHideshow() {
        
        if UserDefaults.standard.bool(forKey: "num") {
            print("-------\(UserDefaults.standard.bool(forKey: "num"))")
            toggle.isEnabled = true
        }
    }
    
    func setupHeader (){
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.width))
        let imageView = UIImageView(image: UIImage(systemName: "heart.fill"))
        header.addSubview(imageView)
        
        imageView.frame = CGRect(x: (view.frame.size.width - 100)/2, y: 10, width: 100, height: 100)
        imageView.tintColor = .systemRed
        let label = UILabel(frame: CGRect(x: 10, y: 120, width: view.frame.size.width - 20 , height: 100))
        header.addSubview(label)
        label.font = .systemFont(ofSize: 25, weight: .bold)
        label.textAlignment = .center
        label.text = "\(mydiamondcount) Diamond"
        tableView.tableHeaderView = header
    }
}


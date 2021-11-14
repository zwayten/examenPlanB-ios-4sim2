//
//  ViewController.swift
//  examenPlanB
//
//  Created by Yassine Zitoun on 13/11/2021.
//

import UIKit

class ViewController: UIViewController {
    
    //vars
    let sandwichs = ["Jambon Gruyere", "Emince Poulet Fondant", "Emince Boeuf Fondant", "Kebab Poulet", "Poulet Grille", "Rapido Jambon Fromage", "Rapido Thon", "Thon"]
    
    let prices = [6.2, 9.5, 7.8, 6.8, 6.8, 3.8, 3.8, 6.8]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    


}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sandwichs.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "sandCell")
        let contentView = cell?.contentView
        let imageView = contentView?.viewWithTag(1) as! UIImageView
        let labelSand = contentView?.viewWithTag(2) as! UILabel
        let labelPrice = contentView?.viewWithTag(3) as! UILabel
        
        
        imageView.image = UIImage(named: sandwichs[indexPath.row])
        labelSand.text = sandwichs[indexPath.row]
        labelPrice.text = String(prices[indexPath.row]) + " DT"
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "detailSegue", sender: indexPath)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSegue" {
            
            let index = sender as! IndexPath
            let destination = segue.destination as! DetailViewController
            
            
            destination.sandwich = sandwichs[index.row]
            destination.price = Float(prices[index.row])
        }
    }
    
    
    
}


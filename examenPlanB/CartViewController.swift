//
//  CartViewController.swift
//  examenPlanB
//
//  Created by Yassine Zitoun on 13/11/2021.
//

import UIKit
import CoreData

class CartViewController: UIViewController {
    
    var panier = [String]()
    var prices = [Float]()
    var quantites = [Int]()
    var totalPrice: Float?

    @IBOutlet var collectionSand: UICollectionView!
    @IBOutlet var tot: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        totalPrice = 0.0
        for i in 0..<panier.count {
            totalPrice! += prices[i] * Float(quantites[i])
            tot.text = "Total: \(String(format: "%.2f", totalPrice!)) DT"
                    }

      
    }
    
    @IBAction func deletesand(_ sender: Any) {
        deleteAll()
        panier.removeAll()
        prices.removeAll()
        quantites.removeAll()
        totalPrice! = 0.0
        tot.text = "Total: \(String(format: "%.2f", totalPrice!)) DT"
        
        collectionSand.reloadData()
    }
    //function delete all
    func deleteAll() {
        //3default
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let pc = appDelegate.persistentContainer
        let mc = pc.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Commande")
        let deleteRequest =  NSBatchDeleteRequest(fetchRequest: request)
        do {
            try mc.execute(deleteRequest)
            try mc.save()
        } catch {
            print("error")
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    func fetchData() {
        //3defualt
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let pc = appDelegate.persistentContainer
        let mc = pc.viewContext
        
        let request = NSFetchRequest<NSManagedObject>(entityName: "Commande")
        do {
            let result = try mc.fetch(request)
            for item in result {
                panier.append(item.value(forKey: "name") as! String)
                prices.append(item.value(forKey: "price") as! Float)
                quantites.append(item.value(forKey: "quantite") as! Int)
            }
        } catch  {
            print("cannot fetch : error")
        }
    }
    
}

extension CartViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return panier.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "rCell", for: indexPath)
        
        let contentView = cell.contentView
        let image = contentView.viewWithTag(1) as! UIImageView
        let name = contentView.viewWithTag(2) as! UILabel
        let price = contentView.viewWithTag(3) as! UILabel
        let quantite = contentView.viewWithTag(4) as! UILabel
        
        image.image = UIImage(named: panier[indexPath.row])
        name.text = panier[indexPath.row]
        price.text = String(prices[indexPath.row])
        quantite.text = "\(quantites[indexPath.row]) Piéces."
        return cell
    }
}

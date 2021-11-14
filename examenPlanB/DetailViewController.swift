//
//  DetailViewController.swift
//  examenPlanB
//
//  Created by Yassine Zitoun on 13/11/2021.
//

import UIKit
import CoreData

class DetailViewController: UIViewController {

    //var
    var sandwich: String?
    var price: Float?
    
    var stepValue = 0
    
    //outlets
    
    @IBOutlet var imageDetail: UIImageView!
    @IBOutlet var nameDetail: UILabel!
    @IBOutlet var priceDetail: UILabel!
    @IBOutlet var stepperIndicator: UILabel!
    
    
    //function alert
    func displayAlert(a: String, b: String) {
        let alert = UIAlertController(title: a, message: b, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true)
    }
    
    
    @IBAction func commande(_ sender: Any) {
        let exist = checkSandwich(name: sandwich!)
        if exist == false{
            insertSand()
        } else {
            update(name: sandwich!)
        }
        
    }
    
    //Insert fucntion
    func insertSand() {
        //default
        let appDelagte = UIApplication.shared.delegate as! AppDelegate
        let persistentContainer = appDelagte.persistentContainer
        let managedContext = persistentContainer.viewContext
        
        let entityDescription = NSEntityDescription.entity(forEntityName: "Commande", in: managedContext)
        let object = NSManagedObject.init(entity: entityDescription!, insertInto: managedContext)
        
            object.setValue(sandwich!, forKey: "name")
            object.setValue(price!, forKey: "price")
            object.setValue(stepValue, forKey: "quantite")
            
            do {
                try managedContext.save()
                displayAlert(a: "Message", b: "Food added successfully !")
            } catch  {
                print("save error")
            }
       
       
        
    }
    
    func update(name: String){
        
        //3default
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let persistentContainer = appDelegate.persistentContainer
        let managedContext = persistentContainer.viewContext // [managedObject]
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Commande")
        let predicate = NSPredicate(format: "name = %@", name)
        request.predicate = predicate
        
        do {
            let result = try managedContext.fetch(request) as! [NSManagedObject]
            if result.count > 0 {
                
                let oldValue = result[0].value(forKey: "quantite") as! Int
                let newValue = oldValue + Int(stepValue)
                result[0].setValue(newValue, forKey: "quantite")
               
                do {
                    try managedContext.save()
                    displayAlert(a: "Message", b: "Food already exist! \n new quanity: \(newValue) ")
                } catch {
                    print("couldn't save")
                }
                }
            
        } catch  {
            print("error fetch")
        }
        
    }
    
    
    //check sandwich
    func checkSandwich(name: String) -> Bool {
        var exist = false
        //3default
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let persistentContainer = appDelegate.persistentContainer
        let managedContext = persistentContainer.viewContext // [managedObject]
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Commande")
        let predicate = NSPredicate(format: "name = %@", name)
        request.predicate = predicate
        
        do {
            let result = try managedContext.fetch(request) as! [NSManagedObject]
            if result.count > 0 {
                exist = true
                }
            
        } catch  {
            print("error fetch")
        }
        return exist
    }
    
    
   
    
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageDetail.image = UIImage(named: sandwich!)
        nameDetail.text = sandwich!
        priceDetail.text = String(price!)
        stepperIndicator.text = String(stepValue)

        // Do any additional setup after loading the view.
    }
    
    @IBAction func stepclick(_ sender: UIStepper) {
        stepValue = Int(sender.value)
        stepperIndicator.text = String(stepValue)
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//
//  MenuViewController.swift
//  Minesweeper
//
//  Created by IHEB ISSAWI on 3/3/17.
//  Copyright © 2017 iheb.issawi. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    @IBOutlet weak var diffValue: UISlider!
    @IBAction func diffValueChanged(_ sender: Any) {
        
        self.diffValue.value = self.diffValue.value.rounded()
    }
    @IBAction func helpBtn(_ sender: Any) {
        
        let firstUseViewController = self.storyboard?.instantiateViewController(withIdentifier: "FirstUseViewController") as! FirstUseViewController

        self.present(firstUseViewController, animated: true, completion: nil)

    }
    @IBAction func startGameBtn(_ sender: Any) {
        let mainViewController = self.storyboard?.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
        mainViewController.size = Int(self.diffValue.value)+5
        self.present(mainViewController, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        checkFirstUse()
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func checkFirstUse(){
        let firstuseStatus = UserDefaults.standard.string(forKey: "firstUse") ?? "false"
        if(firstuseStatus == "false"){
            UserDefaults.standard.set("true", forKey: "firstUse")
            let firstUseViewController = self.storyboard?.instantiateViewController(withIdentifier: "FirstUseViewController") as! FirstUseViewController
            self.present(firstUseViewController, animated: true, completion: nil)

        }
    }

}

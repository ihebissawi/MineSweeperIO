//
//  PageContentViewController.swift
//  Minesweeper
//
//  Created by IHEB ISSAWI on 3/3/17.
//  Copyright © 2017 iheb.issawi. All rights reserved.
//

import UIKit

class PageContentViewController: UIViewController {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var skipBtnOutlet: UIButton!
    @IBOutlet weak var text: UILabel!
    @IBAction func skipBtn(_ sender: Any) {
        
        self.dismiss(animated: true)
        
    }
    var pageIndex: Int = 0
    var strTitle: String!
    var strPhotoName: String!
    var strBtnTitle: String!

   
    override func viewDidLoad() {
        super.viewDidLoad()
        

        image.image = UIImage(named: strPhotoName)
        text.text = strTitle
        skipBtnOutlet.setTitle( strBtnTitle , for: .normal )
        

        
        
    }

    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        for view in self.view.subviews {
            if view is UIScrollView {
                view.frame = UIScreen.main.bounds
            } else if view is UIPageControl {
                view.backgroundColor = UIColor.red
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

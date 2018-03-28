//
//  ViewController2.swift
//  Proyecto de dispositivos 2,0
//
//  Created by Carlos Balcazar on 27/03/18.
//  Copyright © 2018 The Way 2.0. All rights reserved.
//

import UIKit

class ViewController2: UIViewController {

    @IBOutlet weak var text: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        text.text! = ViewController.variable

        // Do any additional setup after loading the view.
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

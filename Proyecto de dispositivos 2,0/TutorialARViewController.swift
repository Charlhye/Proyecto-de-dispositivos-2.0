//
//  TutorialARViewController.swift
//  Proyecto de dispositivos 2,0
//
//  Created by Carlos Balcazar on 01/05/18.
//  Copyright © 2018 The Way 2.0. All rights reserved.
//

import UIKit

class TutorialARViewController: UIViewController {
    
    var ruta = ""
    var videoadd = ""

    @IBOutlet weak var activityInd: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.endIgnoringInteractionEvents()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        activityInd.startAnimating()
        
        UIApplication.shared.beginIgnoringInteractionEvents()
        
        let sigVista = segue.destination as! ViewControllerAR
        sigVista.ruta = ruta
        sigVista.videoadd = videoadd
    }
    

}

//
//  ViewController.swift
//  FunFacts
//
//  Created by Kyle Wilson on 9/5/15.
//  Copyright (c) 2015 Bluyam Inc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var funFactLabel: UILabel!
    @IBOutlet var funFactButton: UIButton!
    
    let factBook = FactBook()
    let colorWheel = ColorWheel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        funFactLabel.text = factBook.factsArray[0];
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func showFunFact() {
        view.backgroundColor = colorWheel.randomColor()
        funFactButton.tintColor = view.backgroundColor
        funFactLabel.text = factBook.randomFact()
    }

}


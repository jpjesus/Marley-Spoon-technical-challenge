//
//  ViewController.swift
//  MarleySpoonChallenge
//
//  Created by Jesus Parada on 20/07/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        var aaaaaa = RecipeProvider()
        aaaaaa.getRecipeList { a in
          print(a)
        }
    }
}

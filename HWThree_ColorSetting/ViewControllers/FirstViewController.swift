//
//  FirstViewController.swift
//  HWThree_ColorSetting
//
//  Created by Anton Kondratenko on 28.06.2023.
//

import UIKit

class FirstViewController: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let colorVC = segue.destination as? ColorViewController else { return }
        colorVC.delegate = self
        colorVC.colorView?.backgroundColor = view.backgroundColor ?? .red
    }
}

extension FirstViewController: ColorViewControllerDelegate {
    func changeColor(_ color: UIColor) {
        view.backgroundColor = color
    }
}

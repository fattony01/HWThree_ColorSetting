//
//  FirstViewController.swift
//  HWThree_ColorSetting
//
//  Created by Anton Kondratenko on 28.06.2023.
//

import UIKit

class FirstViewController: UIViewController {
    
//MARK: - Overrides    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let colorVC = segue.destination as? ColorViewController else { return }
        colorVC.delegate = self
        colorVC.viewColor = view.backgroundColor
    }
}

//MARK: - Extension
extension FirstViewController: ColorViewControllerDelegate {
    func changeColor(_ color: UIColor) {
        view.backgroundColor = color
    }
}

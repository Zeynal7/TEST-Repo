//
//  ViewController.swift
//  NavigationBarTest
//
//  Created by Zeynal Zeynalov on 19.04.23.
//

import UIKit

class ViewController: UITableViewController {
    var onViewWillAppear: (UIViewController) -> Void = { _ in }
    var onViewWillDisappear: (UIViewController) -> Void = { _ in }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        onViewWillAppear(self)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        onViewWillDisappear(self)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let text: String
        switch indexPath.row {
        case 0:
            text = "Opaque nav bar"
        case 1:
            text = "white nav bar title"
        default:
            text = "invalid"
        }
        cell.textLabel?.text = text
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            navigationController?.pushViewController(.secondary(), animated: true)
        case 1:
            navigationController?.pushViewController(.ternary(), animated: true)
        default:
            break
        }
    }
}

extension UIViewController {
    static func initial() -> UIViewController {
        let controller = ViewController()
        controller.view.backgroundColor = .white
        controller.title = "Initial"
        return controller
    }

    static func secondary() -> UIViewController {
        let controller = ViewController()
        controller.view.backgroundColor = .white
        controller.title = "Opaque nav bar"
        controller.onViewWillAppear = {
            $0.setOpaqueNavBar()
        }
        controller.onViewWillDisappear = {
            $0.resetNavBarOpaqueness()
        }
        return controller
    }

    static func ternary() -> UIViewController {
        let controller = ViewController()
        controller.view.backgroundColor = .lightGray
        controller.onViewWillAppear = {
            $0.setNavBarColorsToWhite()
        }
        controller.onViewWillDisappear = {
            $0.resetNavBarColors()
        }
        controller.title = "white nav bar title"
        return controller
    }
}

extension UIViewController {
    func updateNavBarAppearance(tintColor: UIColor, titleColor: UIColor) {
        navigationController?.navigationBar.tintColor = tintColor
        navigationController?.navigationBar.titleTextAttributes?[.foregroundColor] = titleColor
    }

    func setNavBarColorsToWhite() {
        updateNavBarAppearance(tintColor: .white, titleColor: .white)
    }

    func resetNavBarColors() {
        updateNavBarAppearance(tintColor: .blue, titleColor: .lightGray)
    }

    func setOpaqueNavBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        navigationController?.navigationBar.standardAppearance = appearance
    }

    func resetNavBarOpaqueness() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        navigationController?.navigationBar.standardAppearance = appearance
    }
}

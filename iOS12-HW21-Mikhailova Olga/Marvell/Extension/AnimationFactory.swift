//
//  AnimationFactory.swift
//  iOS12-HW21-Mikhailova Olga
//
//  Created by FoxxFire on 10.04.2024.
//

import UIKit

extension UITableView {
    func isLastVisibleCell(at indexPath: IndexPath) -> Bool {
        guard let lastIndexPath = indexPathsForVisibleRows?.last else {
            return false
        }
        
        return lastIndexPath == indexPath
    }
}

typealias Animation = (UITableViewCell, IndexPath, UITableView) -> Void

final class Animator {
    private var hasAnimatedAllCells = false
    private let animation: Animation
    
    init(animation: @escaping Animation) {
        self.animation = animation
    }
    
    func animate(cell: UITableViewCell, at indexPath: IndexPath, in tableView: UITableView) {
        guard !hasAnimatedAllCells else { return }
        
        animation(cell, indexPath, tableView)
        
        hasAnimatedAllCells = tableView.isLastVisibleCell(at: indexPath)
    }
}

enum AnimationFactory {
    static func makeFadeAnimation(duration: TimeInterval, delayFactor: Double) -> Animation {
        return { cell, IndexPath, _ in
            cell.alpha = 0
            
            UIView.animate(withDuration: duration, delay: delayFactor * Double(IndexPath.row)) {
                cell.alpha = 1
            }
            
        }
    }
    
    static func makeMoveUpWithBounce(rowHeight: CGFloat, duration: TimeInterval, delayFactor: Double) -> Animation {
        return { cell, IndexPath, tableView in
            cell.transform = CGAffineTransform(translationX: 0, y: rowHeight)
            
            UIView.animate(withDuration: duration,
                           delay: delayFactor * Double(IndexPath.row), usingSpringWithDamping: 0.4, initialSpringVelocity: 0.1,
                           options:[.curveEaseInOut]) {
                cell.transform = CGAffineTransform(translationX: 0, y: 0)
            }
        }
    }
    
    static func makeMoveUpWithFade(rowHeight: CGFloat, duration: TimeInterval, delayFactor: Double) -> Animation {
        return { cell, IndexPath, _ in
            cell.alpha = 0
            
            UIView.animate(withDuration: duration,
                           delay: delayFactor * Double(IndexPath.row),
                           options:[.curveEaseInOut],
                           animations: {
                cell.transform = CGAffineTransform(translationX: 0, y: 0)
                cell.alpha = 1
            })
        }
    }
    
    static func makeSlideIn(duration: TimeInterval, delayFactor: Double) -> Animation {
        return { cell, IndexPath, tableView in
            cell.transform = CGAffineTransform(translationX: tableView.bounds.width, y: 0)
            
            UIView.animate(withDuration: duration,
                           delay: delayFactor * Double(IndexPath.row),
                           options:[.curveEaseInOut],
                           animations: {
                cell.transform = CGAffineTransform(translationX: 0, y: 0)
            })
        }
    }
}


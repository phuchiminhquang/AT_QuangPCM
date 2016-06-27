

import UIKit

protocol AvatarViewDelegate {
    func didSelectAvatar(myView: AvatarView)
}

class AvatarView: UIView {

    var avatarView: UIImageView!
    var lbName: UILabel!
    let greenColor = UIColor(red: 80/255, green: 155/255, blue: 90/255, alpha: 1)
    var delegate: AvatarViewDelegate!
    var index: Int = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configFrame(frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func configFrame(frame: CGRect) {
        // Add image
        let imageFrame = CGRectMake(0, 0, frame.size.width, frame.size.height - frame.size.height / 4)
        self.avatarView = UIImageView(image: UIImage(named: "avatar.png"))
        self.avatarView.frame = imageFrame
        self.avatarView.contentMode = .ScaleToFill
        self.addSubview(avatarView)
        
        // Add label name
        let labelFrame = CGRectMake(0, frame.size.height - frame.size.height / 4 , frame.size.width, frame.size.height / 4)
        self.lbName = UILabel(frame: labelFrame)
        self.lbName.text = "Guest"
        self.lbName.textAlignment = .Center
        self.lbName.font = self.lbName.font.fontWithSize(13)
        self.lbName.backgroundColor = greenColor
        self.lbName.textColor = UIColor.whiteColor()
        self.addSubview(lbName)
        
        // Add button
        let button = UIButton(type: .Custom)
        button.frame = CGRectMake(0, 0, frame.size.width, frame.size.height)
        button.addTarget(self, action: #selector(self.tapButton), forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(button)
    }
    
    func tapButton() {
        if let deleagte = self.delegate {
            deleagte.didSelectAvatar(self)
        }
    }

}

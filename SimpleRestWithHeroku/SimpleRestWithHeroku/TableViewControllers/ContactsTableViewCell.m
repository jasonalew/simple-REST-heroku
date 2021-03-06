//
//  ContactsTableViewCell.m
//  SimpleRestWithHeroku
//
//  Created by Jason Lew on 6/7/16.
//  Copyright © 2016 Jason Lew. All rights reserved.
//

#import "ContactsTableViewCell.h"

@implementation ContactsTableViewCell

- (void)setContact:(Contact *)contact {
    _contact = contact;
    self.firstNameLabel.text = _contact.firstName;
    self.lastNameLabel.text = _contact.lastName;
    self.emailLabel.text = _contact.email;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

//
//  ContactsTableViewCell.h
//  SimpleRestWithHeroku
//
//  Created by Jason Lew on 6/7/16.
//  Copyright © 2016 Jason Lew. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Contact.h"

@interface ContactsTableViewCell : UITableViewCell
@property (strong, nonatomic) Contact *contact;

@property (weak, nonatomic) IBOutlet UILabel *firstNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;

@end

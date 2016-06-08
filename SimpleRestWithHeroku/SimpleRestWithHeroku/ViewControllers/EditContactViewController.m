//
//  EditContactViewController.m
//  SimpleRestWithHeroku
//
//  Created by Jason Lew on 6/8/16.
//  Copyright © 2016 Jason Lew. All rights reserved.
//

#import "EditContactViewController.h"
#import "Contact.h"
#import "ContactsHTTPClient.h"

@interface EditContactViewController ()<UITextFieldDelegate, ContactsHTTPClientDelegate>
@property (nonatomic) BOOL editContact;

@property (weak, nonatomic) IBOutlet UITextField *firstNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;

@end

@implementation EditContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.firstNameTextField.delegate = self;
    self.lastNameTextField.delegate = self;
    self.emailTextField.delegate = self;
    
    // If there is a contact then we are editing, if not we are adding.
    if (self.contact) {
        self.title = @"Edit Contact";
        self.editContact = YES;
    } else {
        self.editContact = NO;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)saveButtonPressed:(UIBarButtonItem *)sender {
    if (self.firstNameTextField.text.length > 0 && self.lastNameTextField.text.length > 0 && self.emailTextField.text.length > 0) {
        ContactsHTTPClient *contactsClient = [ContactsHTTPClient sharedContactsHTTPClient];
        contactsClient.delegate = self;
        NSDictionary *dict = @{
                               @"firstName": self.firstNameTextField.text,
                               @"lastName": self.lastNameTextField.text,
                               @"email": self.emailTextField.text
                               };
        if (self.editContact) {
            [contactsClient editContact:dict];
        } else {
            [contactsClient addContact:dict];
        }
    } else {
        // TODO: Provide user feedback for missing field
    }
}

- (void)contactsHTTPClientDidUpdateContact:(ContactsHTTPClient *)client {
    [self.navigationController popViewControllerAnimated:YES];
}

@end

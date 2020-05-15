// Copyright (c) 2020 WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
//
// WSO2 Inc. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

# Contains information about an invoice
# 
# + customer - The ID of the customer who will be billed
# + auto_advance - Controls whether Stripe will perform automatic collection of the invoice. 
# 				   When false, the invoice’s state will not automatically advance without an explicit action
# + collection_method - Collection method. Either charge_automatically, or send_invoice
# + description - A string holding a description of the invoice
# + subscription - The ID of the subscription to invoice, if any. If not set, the created invoice will 
# 				   include all pending invoice items for the customer
# + application_fee_amount - A fee in cents that will be applied to the invoice and transferred to the 
#                            application owner’s Stripe account
# + custom_fields - A list of up to 4 custom fields to be displayed on the invoice
# + days_until_due - The number of days from when the invoice is created until it is due. Valid only for 
# 				     invoices where collection_method=send_invoice
# + default_payment_method - ID of the default payment method for the invoice
# + default_source - ID of the default payment source for the invoice
# + tax_rates - The tax rates that will apply to any line item that does not have tax_rates set
# + due_date - The date on which payment for this invoice is due. Valid only for invoices where 
# 			    `collection_method=send_invoice`
# + footer - Footer to be displayed on the invoice
# + statement_descriptor - Extra information about a charge for the customer’s credit card statement
public type Invoice record {
	string? customer?;
	boolean? auto_advance?;
	string? collection_method?;
	string? description?;
 // map<string> metaData?;
    string? subscription?;
	int? application_fee_amount?;
	InvoiceCustomFields? custom_fields?;
	int? days_until_due?;
	string? default_payment_method?;
	string? default_source?;
	string[]? tax_rates?;
	int? due_date?;
	string? footer?;
	string? statement_descriptor?;	
};

# A list of up to 4 custom fields to be displayed on the invoice
# 
# + name - The name of the custom field. This may be up to 30 characters
# + value - The value of the custom field. This may be up to 30 characters
public type InvoiceCustomFields record {
	string? name?;
	string? value?;
};

# Configurations related to paying an invoice
# 
# + forgive - In cases where the source used to pay the invoice has insufficient funds, passing `forgive=true` 
#             controls whether a charge should be attempted for the full amount available on the source, up to 
#             the amount to fully pay the invoice
# + off_session - Indicates if a customer is on or off-session while an invoice payment is attempted.
# + paid_out_of_band - Boolean representing whether an invoice is paid outside of Stripe. This will result in no 
#                      charge being made
# + payment_method - A payment method to be charged. The payment method must be the ID of a PaymentMethod belonging 
#                    to the customer associated with the invoice being paid
# + source - A payment source to be charged. The source must be the ID of a source belonging to the customer associated 
#            with the invoice being paid
public type InvoicePay record {
	boolean forgive?;
	boolean off_session?;
	boolean paid_out_of_band?;
	string payment_method?;
	string 'source;
};
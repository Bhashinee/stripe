// // Copyright (c) 2020 WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
// //
// // WSO2 Inc. licenses this file to you under the Apache License,
// // Version 2.0 (the "License"); you may not use this file except
// // in compliance with the License.
// // You may obtain a copy of the License at
// //
// // http://www.apache.org/licenses/LICENSE-2.0
// //
// // Unless required by applicable law or agreed to in writing,
// // software distributed under the License is distributed on an
// // "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// // KIND, either express or implied.  See the License for the
// // specific language governing permissions and limitations
// // under the License.

// import ballerina/http;
// import ballerina/auth;

// public type Invoices client object {
//     private http:Client invoices;
    
//     public function __init(http:Client stripeClient) {
//        self.invoices = stripeClient;
//     }

//     # Creates an invoice.
//     #
//     # + invoiceParams - Invoice configurations
//     # + return - `Invoice` record, or else a `stripe:Error` in case of a failure
//     public remote function createInvoice(InvoiceParams invoiceParams) returns @tainted Invoice|Error {
//         //return charge;
//     }

//     # Retrieves an invoice.
//     #
//     # + invoiceId - Invoice ID
//     # + return - `Invoice` record, or else a `stripe:Error` in case of a failure
//     public remote function retrieveInvoice(string invoiceId) returns @tainted Invoice|Error {
//        // return charge;
//     }

//     # Updates an invoice.
//     #
//     # + invoiceId - Invoice ID
//     # + invoiceParams - Invoice configurations
//     # + return - `Invoice` record, or else a `stripe:Error` in case of a failure
//     public remote function updateInvoice(string invoiceId, InvoiceParams invoiceParams) returns @tainted Invoice|Error {
//         // return charge;
//     }

//     # Deletes a draft invoice.
//     #
//     # + invoiceId - Invoice ID
//     # + return - `()` if the invoice is deleted succesfully or else a `stripe:Error` if the invoice has been already deleted
//     public remote function deleteDraftInvoice(string invoiceId) returns @tainted Error? {
//         // return ();
//     }

//     # Finalizes an invoice.
//     #
//     # + invoiceId - Invoice ID
//     # + autoAdvance - `true` if Stripe performs automatic collection of the invoice, otherwise `false`
//     # + return - `Invoice` record
//     public remote function finalizeInvoice(string invoiceId, boolean autoAdvance) returns @tainted Invoice {
//         // return ();
//     }

//     # Pays an invoice.
//     #
//     # + invoiceId - Invoice ID
//     # + invoicePayParams - Parameters to be used when paying an invoice
//     # + return - `Invoice` record
//     public remote function payInvoice(string invoiceId, InvoicePayParams invoicePayParams) returns @tainted Invoice {
//         // return ();
//     }

//     # Pays an invoice.
//     #
//     # + invoiceId - Invoice ID
//     # + invoicePayParams - Parameters to be used when paying an invoice
//     # + return - `Invoice` record
//     public remote function sendInvoiceForMannualPayment(string invoiceId) returns @tainted Invoice {
//         // return ();
//     }

//     # Voids an invoice.
//     #
//     # + invoiceId - Invoice ID
//     # + return - `Invoice` record
//     public remote function voidInvoice(string invoiceId) returns @tainted Invoice {
//         // return ();
//     }

//     # Marks an invoice as uncollectible.
//     #
//     # + invoiceId - Invoice ID
//     # + return - `Invoice` record
//     public remote function markInvoiceUncollectible(string invoiceId) returns @tainted Invoice {
//         // return ();
//     }

//     # Retrieves an upcoming invoice.
//     #
//     # + customerId - Customer ID whose upcoming invoice you’d like to retrieve
//     # + invoiceParams - Invoice parameters to filter
//     # + return - `Invoice` record
//     public remote function retrieveUpcomingInvoice(string customerId, InvoiceParams invoiceParams) returns @tainted Invoice {
//         // return ();
//     }

//     # Lists all invoices.
//     #
//     # + return - An array of `Invoice` records, if no invoices are available the resulting record will be empty or else a `stripe:Error` 
//     # for non-existant customer IDs
//     public remote function listInvoices(InvoiceListParams invoiceListParams) returns @tainted Invoice[]|Error {
//         // return ();
//     }
// };


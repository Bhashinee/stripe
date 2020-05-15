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

import ballerina/http;
import ballerina/io;

public type Invoices client object {
    private http:Client invoices;
    private string path = "/v1/invoices";
    
    public function __init(http:Client stripeClient) {
       self.invoices = stripeClient;
    }

    # Creates an invoice.
    #
    # + invoice - Invoice configurations
    # + return - `Invoice` record, or else a `stripe:Error` in case of a failure
    public remote function create(Invoice invoice) returns @tainted Invoice|Error {
        string queryString = createInvoiceQuery(invoice);
        io:println(queryString);
        http:Response response = check createPostRequest(self.invoices, queryString, self.path);
        return mapToInvoiceRecord(response);
    }

    # Retrieves an invoice.
    #
    # + invoiceId - Invoice ID
    # + return - `Invoice` record, or else a `stripe:Error` in case of a failure
    public remote function retrieve(string invoiceId) returns @tainted Invoice|Error {
        string path = self.path + "/" + invoiceId;
        http:Response response = check createGetRequest(self.invoices, path);
        return mapToInvoiceRecord(response);
    }

    # Updates an invoice.
    #
    # + invoiceId - Invoice ID
    # + invoice - Invoice configurations
    # + return - `Invoice` record, or else a `stripe:Error` in case of a failure
    public remote function update(string invoiceId, Invoice invoice) returns @tainted Invoice|Error {
        string path = self.path + "/" + invoiceId;
        string queryString = createInvoiceQuery(invoice);
        http:Response response = check createPostRequest(self.invoices, queryString, path);
        return mapToInvoiceRecord(response);
    }

    # Deletes a draft invoice.
    #
    # + invoiceId - Invoice ID
    # + return - `()` if the invoice is deleted succesfully or else a `stripe:Error` if the invoice has been already deleted
    public remote function deleteDraft(string invoiceId) returns @tainted Error? {
        string path = self.path + "/" + invoiceId;
        http:Response response = check createDeleteRequest(self.invoices, path);
        return checkDeleteResponse(response);
    }

    # Finalizes an invoice.
    #
    # + invoiceId - Invoice ID
    # + autoAdvance - `true` if Stripe performs automatic collection of the invoice, otherwise `false`
    # + return - `Invoice` record
    public remote function finalize(string invoiceId, boolean? autoAdvance = false) returns @tainted Invoice|Error {
        string path = self.path + "/" + invoiceId + "/finalize";
        string queryString = "auto_advance=" + autoAdvance.toString();
        http:Response response = check createPostRequest(self.invoices, queryString, path);
        return mapToInvoiceRecord(response);
    }

    # Pays an invoice.
    #
    # + invoiceId - Invoice ID
    # + invoicePay - Parameters to be used when paying an invoice
    # + return - `Invoice` record
    public remote function payInvoice(string invoiceId, InvoicePay? invoicePay = ()) returns @tainted Invoice|Error {
        string invoicePayQuery = "";
        string path = self.path + "/" + invoiceId + "/pay";
        if (invoicePay is InvoicePay) {
            invoicePayQuery = createInvoicePayQuery(invoicePay);
        }
        http:Response response = check createPostRequest(self.invoices, invoicePayQuery, path);
        return mapToInvoiceRecord(response);
    }

    # Send an invoice for mannual payment.
    #
    # + invoiceId - Invoice ID
    # + return - `Invoice` record
    public remote function sendForMannualPayment(string invoiceId) returns @tainted Invoice|Error {
        string path = self.path + "/" + invoiceId + "/send";
        http:Response response = check createPostRequest(self.invoices, "", path);
        return mapToInvoiceRecord(response);
    }

    // # Voids an invoice.
    // #
    // # + invoiceId - Invoice ID
    // # + return - `Invoice` record
    // public remote function voidInvoice(string invoiceId) returns @tainted Invoice {
    //     // return ();
    // }

    # Marks an invoice as uncollectible.
    #
    # + invoiceId - Invoice ID
    # + return - `Invoice` record
    public remote function markInvoiceUncollectible(string invoiceId) returns @tainted Invoice|Error {
        string path = self.path + "/" + invoiceId + "/mark_uncollectible";
        http:Response response = check createPostRequest(self.invoices, "", path);
        return mapToInvoiceRecord(response);
    }

    // # Retrieves an upcoming invoice.
    // #
    // # + customerId - Customer ID whose upcoming invoice you’d like to retrieve
    // # + invoice - Invoice parameters to filter
    // # + return - `Invoice` record
    // public remote function retrieveUpcomingInvoice(string customerId, Invoice? invoice = ()) returns @tainted Invoice|Error {
    //     string path = self.path + "/upcoming?customer=" + customerId;
    //     string invoiceQuery = "";
    //     if (invoice is Invoice) {
    //         invoiceQuery = createInvoiceQuery(invoice);
    //     }
    //     io:println(path);
    //     http:Response response = check createPostRequest(self.invoices, invoiceQuery, path);
    //     return mapToInvoiceRecord(response);
    // }

    # Lists all invoices.
    #
    # + return - An array of `Invoice` records, if no invoices are available the resulting record will be empty or else a `stripe:Error` 
    # for non-existant customer IDs
    public remote function list() returns @tainted Invoice[]|Error {
        http:Response response = check createGetRequest(self.invoices, self.path);
        return mapToInvoices(response);
    }
};


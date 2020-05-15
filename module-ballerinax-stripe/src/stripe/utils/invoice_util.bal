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

function createInvoiceQuery(Invoice invoiceParams) returns string {
    string customFields = "";
    string invoiceQuery = "";
    string taxQuery = ""; 
    foreach [string, anydata] [key, value] in invoiceParams.entries() {
        if (key == "custom_fields") {
            var customFieldsRecord = invoiceParams?.custom_fields;
            if (customFieldsRecord is InvoiceCustomFields) {
                var name = customFieldsRecord["name"];
                var invoiceValue = customFieldsRecord["value"];
                if (name is string) {
                    customFields = customFields + "custom_fields[name]=" + name + "&";
                }
                if (invoiceValue is string) {
                    customFields = customFields + "custom_fields[value]=" + invoiceValue + "&";
                }
            }
        } 
        else if (key == "tax_rates") {
            string[]? taxRates = invoiceParams["tax_rates"];
            if (taxRates is string[]) {
                foreach var tax in taxRates {
                    taxQuery = taxQuery + "\"" + tax + "\",";
                }
                io:println(taxQuery);
                taxQuery = "default_tax_rates = [" + taxQuery.substring(0, taxQuery.length() - 1) + "]";
            }

        }
        invoiceQuery = invoiceQuery + key + "=" + getEncodedUri(value.toString()) + "&";
    }
    return customFields + invoiceQuery + taxQuery;
}

function mapToInvoiceRecord(http:Response response) returns @tainted Invoice|Error {
    json|error payload = response.getJsonPayload();
    if (payload is error) {
        return setJsonResError(payload);
    } else {
        io:println("---------------------------------");
        io:println(payload.toJsonString());
        io:println("---------------------------------");
        check checkForErrorResponse(payload);
        Invoice|error invoice = Invoice.constructFrom(payload);
        if (invoice is error) {
            return Error(message = "Response cannot be converted to Customer record", cause = invoice);
        } else {
            return invoice;
        }
    }        
}

function createInvoicePayQuery(InvoicePay invoicePay) returns string {
    string payQuery = "";
    foreach [string, anydata] [key, value] in invoicePay.entries() {
        payQuery = payQuery + key + "=" + getEncodedUri(value.toString()) + "&";
    }
    return payQuery;
}

function mapToInvoices(http:Response response) returns @tainted Invoice[]|Error {
    json|error payload = response.getJsonPayload();
    if (payload is error) {
        return setJsonResError(payload);
    } else {
        io:println(payload.toJsonString());
        var invoices = payload.data;
        if (invoices is error) {
            return setJsonResError(invoices);
        }
        json invoicesJson = <json> invoices;
        check checkForErrorResponse(invoicesJson);
        Invoice[]|error invoicesList = Invoice[].constructFrom(invoicesJson);
        if (invoicesList is error) {
            return Error(message = "Response cannot be converted to Customer record", cause = invoicesList);
        } else {
            return invoicesList;
        }
    }        
}
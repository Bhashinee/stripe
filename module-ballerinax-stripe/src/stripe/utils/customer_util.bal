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

function createCustomerQuery(Customer cusParams) returns string {
    string cusQuery = "";
    string addressQuery = "";
    string shippingAddressQuery = "";
    string invoiceSettingsQuery = "";
    string queryString;
    foreach [string, anydata] [key, value] in cusParams.entries() {
        if (key == "address") {
            var city = cusParams?.address["city"];
            var country = cusParams?.address["country"];
            var line1 = cusParams?.address["line1"];
            var line2 = cusParams?.address["line2"];
            var postalCode = cusParams?.address["postalCode"];
            var state = cusParams?.address["state"];
            if (city is string) {
                addressQuery = addressQuery + "address[city]=" + getEncodedUri(city) + "&";
            }
            if (country is string) {
                addressQuery = addressQuery + "address[country]=" + getEncodedUri(country) + "&";
            }    
            if (line1 is string) {
                addressQuery = addressQuery + "address[line1]=" + getEncodedUri(line1) + "&";
            } 
            if (line2 is string) {
                addressQuery = addressQuery + "address[line2]=" + getEncodedUri(line2) + "&";
            } 
            if (postalCode is string) {
                addressQuery = addressQuery + "address[postalCode]=" + getEncodedUri(postalCode) + "&";
            } 
            if (state is string) {
                addressQuery = addressQuery + "address[state]=" + getEncodedUri(state) + "&";
            }       
        } else if (key == "invoice_settings") {
            var name = cusParams?.invoice_settings["name"];
            var invoiceValue = cusParams?.invoice_settings["value"];
            if (name is string) {
                invoiceSettingsQuery = invoiceSettingsQuery + "invoice_settings[custom_fields][name]=" + getEncodedUri(name) + "&";                
            }
            if (invoiceValue is string) {
                invoiceSettingsQuery = invoiceSettingsQuery + "invoice_settings[custom_fields][value]=" + getEncodedUri(invoiceValue) + "&";                
            }
        } else if (key == "shipping") {
            var city = cusParams?.shipping["address"]["city"];
            var country = cusParams?.shipping["address"]["country"];
            var line1 = cusParams?.shipping["address"]["line1"];
            var line2 = cusParams?.shipping["address"]["line2"];
            var postalCode = cusParams?.shipping["address"]["postalCode"];
            var state = cusParams?.shipping["address"]["state"];
            var name = cusParams?.shipping["name"];
            var phone = cusParams?.shipping["phone"];
            if (city is string) {
                shippingAddressQuery = shippingAddressQuery + "shipping[address][city]=" + getEncodedUri(city) + "&";
            }
            if (country is string) {
                shippingAddressQuery = shippingAddressQuery + "shipping[address][country]=" 
                                        + getEncodedUri(country) + "&";
            }    
            if (line1 is string) {
                shippingAddressQuery = shippingAddressQuery + "shipping[address][line1]=" + getEncodedUri(line1) + "&";
            } 
            if (line2 is string) {
                shippingAddressQuery = shippingAddressQuery + "shipping[address][line2]=" + getEncodedUri(line2) + "&";
            } 
            if (postalCode is string) {
                shippingAddressQuery = shippingAddressQuery + "shipping[address][postalCode]=" 
                                        + getEncodedUri(postalCode) + "&";
            } 
            if (state is string) {
                shippingAddressQuery = shippingAddressQuery + "shipping[address][state]=" + getEncodedUri(state) + "&";
            } 
            if (name is string) {
                shippingAddressQuery = shippingAddressQuery + "shipping[name]=" + getEncodedUri(name) + "&";
            }
            if (phone is string) {
                shippingAddressQuery = shippingAddressQuery + "shipping[phone]=" + getEncodedUri(phone) + "&";
            }            
        } else {
            cusQuery = cusQuery + key + "=" + getEncodedUri(value.toString()) + "&";
        }
    }
    queryString = cusQuery + addressQuery + invoiceSettingsQuery + shippingAddressQuery;
    return queryString;
}

function mapToCustomerRecord(http:Response response) returns @tainted Customer|Error {
    json|error payload = response.getJsonPayload();
    if (payload is error) {
        return setJsonResError(payload);
    } else {
        io:println("---------------------------------");
        io:println(payload.toJsonString());
        io:println("---------------------------------");
        Customer|error customer = Customer.constructFrom(payload);
        if (customer is error) {
            return Error(message = "Response cannot be converted to Customer record", cause = customer);
        } else {
            return customer;
        }
    }        
}

function mapToCustomers(http:Response response) returns @tainted Customer[]|Error {
    json|error payload = response.getJsonPayload();
    if (payload is error) {
        return setJsonResError(payload);
    } else {
        var customers = payload.data;
        if (customers is error) {
            return setJsonResError(customers);
        }
        json customersJson = <json> customers;
        Customer[]|error customerList = Customer[].constructFrom(customersJson);
        if (customerList is error) {
            return Error(message = "Response cannot be converted to Customer record", cause = customerList);
        } else {
            return customerList;
        }
    }        
}


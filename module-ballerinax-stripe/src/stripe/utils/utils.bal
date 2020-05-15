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

import ballerina/encoding;
import ballerina/http;

function getEncodedUri(string value) returns string {
    string|error encoded = encoding:encodeUriComponent(value, "UTF8");
    if (encoded is string) {
        return encoded;
    } else {
        return value;
    }
}

function createPostRequest(http:Client stripeClient, string queryString, string path) returns http:Response|Error {
    http:Request req = new;
    req.setPayload(queryString);
    req.setHeader("Content-Type", "application/x-www-form-urlencoded");
    http:Response|error response = stripeClient->post(path, req);
    if (response is error) {
        return setResError(response);
    } else {
        return response;
    }
}

function createGetRequest(http:Client stripeClient, string path) returns http:Response|Error {
    http:Response|error response = stripeClient->get(path);
    if (response is error) {
        return setResError(response);
    } else {
        return response;
    }
}

function createDeleteRequest(http:Client stripeClient, string path) returns http:Response|Error {
    http:Response|error response = stripeClient->delete(path);
    if (response is error) {
        return setResError(response);
    } else {
        return response;
    }
}

function setResError(error errorResponse) returns Error {
    return Error(message = "Error received from the stripe server", cause = errorResponse);
}

function setJsonResError(error errorResponse) returns Error {
    return Error(message = "Error occurred while accessing the JSON payload of the response", 
                        cause = errorResponse);
}

function checkDeleteResponse(http:Response response) returns @tainted Error? {
    json|error payload = response.getJsonPayload();
    if (payload is error) {
        return setJsonResError(payload);
    } else {
        var deleted = payload.deleted;
        if (deleted is error) {
            var message = payload.'error.message;
            if (message is string) {
                return setJsonResError(error(message));
            } else {
                return Error(message = "Error occurred while accessing the JSON payload of the response");
            }           
        } else {
            if (deleted.toString() == "true") {
                return ();
            }
        }
    }     
}

function createAddressQuery(Address address) returns string {
    var city = address[CITY];
    var country = address[COUNTRY];
    var line1 = address[LINE1];
    var line2 = address[LINE2];
    var postalCode = address[POSTAL_CODE];
    var state = address[STATE];
    string addressQuery = "";
    if (city is string) {
        addressQuery = addressQuery + ADDRESS_CITY + getEncodedUri(city) + AND;
    }
    if (country is string) {
        addressQuery = addressQuery + ADDRESS_COUNTRY + getEncodedUri(country) + AND;
    }    
    if (line1 is string) {
        addressQuery = addressQuery + ADDRESS_LINE1 + getEncodedUri(line1) + AND;
    } 
    if (line2 is string) {
        addressQuery = addressQuery + ADDRESS_LINE2 + getEncodedUri(line2) + AND;
    } 
    if (postalCode is string) {
        addressQuery = addressQuery + ADDRESS_POSTAL_CODE + getEncodedUri(postalCode) + AND;
    } 
    if (state is string) {
        addressQuery = addressQuery + ADDRESS_STATE + getEncodedUri(state) + AND;
    } 
    return addressQuery;
} 

function createShippingAddressQuery(CustomerShippingDetails shipping) returns string {
    var city = shipping[ADDRESS][CITY];
    var country = shipping[ADDRESS][COUNTRY];
    var line1 = shipping[ADDRESS][LINE1];
    var line2 = shipping[ADDRESS][LINE2];
    var postalCode = shipping[ADDRESS][POSTAL_CODE];
    var state = shipping[ADDRESS][STATE];
    var name = shipping[NAME];
    var phone = shipping[PHONE];
    string shippingQuery = "";
    if (city is string) {
        shippingQuery = shippingQuery + SHIPPING_ADDRESS_CITY + getEncodedUri(city) + AND;
    }
    if (country is string) {
        shippingQuery = shippingQuery + SHIPPING_ADDRESS_COUNTRY + getEncodedUri(country) + AND;
    }    
    if (line1 is string) {
        shippingQuery = shippingQuery + SHIPPING_ADDRESS_LINE1 + getEncodedUri(line1) + AND;
    } 
    if (line2 is string) {
        shippingQuery = shippingQuery + SHIPPING_ADDRESS_LINE2 + getEncodedUri(line2) + AND;
    } 
    if (postalCode is string) {
        shippingQuery = shippingQuery + SHIPPING_POSTAL_CODE + postalCode + AND;
    } 
    if (state is string) {
        shippingQuery = shippingQuery + SHIPPING_STATE + getEncodedUri(state) + AND;
    } 
    if (name is string) {
        shippingQuery = shippingQuery + SHIPPING_NAME + getEncodedUri(name) + AND;
    }
    if (phone is string) {
        shippingQuery = shippingQuery + SHIPPING_PHONE + getEncodedUri(phone) + AND;
    }             
    return shippingQuery;
} 

function checkForErrorResponse(json jsonResp) returns Error? {
    json|error errorResp = jsonResp.'error;
    if (errorResp is error) {
        return ();
    } else {    
        return Error(message = errorResp.toJsonString());
    }
}
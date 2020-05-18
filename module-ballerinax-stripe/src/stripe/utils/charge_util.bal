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

// function createChargeQuery(Charge chargeParams) returns string {
//     string chargeQuery = "";
//     string transferQuery = "";
//     string shippingQuery = "";
//     string queryString;
//     foreach [string, anydata] [key, value] in chargeParams.entries() {
//         if (key == SHIPPING) {
//             var city = chargeParams?.shipping[ADDRESS][CITY];
//             var country = chargeParams?.shipping[ADDRESS][COUNTRY];
//             var line1 = chargeParams?.shipping[ADDRESS][LINE1];
//             var line2 = chargeParams?.shipping[ADDRESS][LINE2];
//             var postalCode = chargeParams?.shipping[ADDRESS][POSTAL_CODE];
//             var state = chargeParams?.shipping[ADDRESS][STATE];
//             var name = chargeParams?.shipping[NAME];
//             var phone = chargeParams?.shipping[PHONE];
//             var carrier = chargeParams?.shipping[CARRIER];
//             var trackingNum = chargeParams?.shipping[TRACKING_NUMBER];
//             if (city is string) {
//                 shippingQuery = shippingQuery + SHIPPING_ADDRESS_CITY + getEncodedUri(city) + AND;
//             }
//             if (country is string) {
//                 shippingQuery = shippingQuery + SHIPPING_ADDRESS_COUNTRY + getEncodedUri(country) + AND;
//             }    
//             if (line1 is string) {
//                 shippingQuery = shippingQuery + SHIPPING_ADDRESS_LINE1 + getEncodedUri(line1) + AND;
//             } 
//             if (line2 is string) {
//                 shippingQuery = shippingQuery + SHIPPING_ADDRESS_LINE2 + getEncodedUri(line2) + AND;
//             } 
//             if (postalCode is string) {
//                 shippingQuery = shippingQuery + SHIPPING_POSTAL_CODE + getEncodedUri(postalCode) + AND;
//             } 
//             if (state is string) {
//                 shippingQuery = shippingQuery + SHIPPING_STATE + getEncodedUri(state) + AND;
//             } 
//             if (name is string) {
//                 shippingQuery = shippingQuery + SHIPPING_NAME + getEncodedUri(name) + AND;
//             }
//             if (phone is string) {
//                 shippingQuery = shippingQuery + SHIPPING_PHONE + getEncodedUri(phone) + AND;
//             }   
//             if (carrier is string) {
//                 shippingQuery = shippingQuery + SHIPPING_CARRIER + getEncodedUri(carrier) + AND;
//             }  
//             if (trackingNum is string) {
//                 shippingQuery = shippingQuery + SHIPPING_TRACKING_NUMBER + getEncodedUri(trackingNum) + AND;
//             }      
//         } else if (key == "sourceId") {
//                 chargeQuery = chargeQuery + "source=" + getEncodedUri(value.toString()) + AND;
//         } else if (key == "transfer_data") {
//             var amount = chargeParams[AMOUNT];
//             var destination = chargeParams[DESTINATION];
//             if (amount is int) {
//                 transferQuery = transferQuery + TRANSFER_DATA_AMOUNT + amount.toString() + AND;
//             } 
//             if (destination is string) {
//                 transferQuery = transferQuery + TRANSFER_DATA_DESTINATION + destination.toString() + AND;
//             }
//         } else {
//             chargeQuery = chargeQuery + key + "=" + getEncodedUri(value.toString()) + AND;
//         }
//     }
//     queryString = chargeQuery + transferQuery + shippingQuery;
//     io:println(queryString);
//     return queryString;
// }

function mapToChargeRecord(http:Response response) returns @tainted Charge|Error {
    json|error payload = response.getJsonPayload();
    if (payload is error) {
        return setJsonResError(payload);
    } else {
        io:println("---------------------------------");
        io:println(payload.toJsonString());
        io:println("---------------------------------");
        check checkForErrorResponse(payload);
        Charge|error charge = Charge.constructFrom(payload);
        if (charge is error) {
            return Error(message = "Response cannot be converted to Customer record", cause = charge);
        } else {
            return charge;
        }
    }        
}

function mapToCharges(http:Response response) returns @tainted Charge[]|Error {
    json|error payload = response.getJsonPayload();
    if (payload is error) {
        return setJsonResError(payload);
    } else {
        var charges = payload.data;
        if (charges is error) {
            return setJsonResError(charges);
        }
        json chargesJson = <json> charges;
        io:println(chargesJson.toJsonString());
        check checkForErrorResponse(chargesJson);
        Charge[]|error chargeList = Charge[].constructFrom(chargesJson);
        if (chargeList is error) {
            return Error(message = "Response cannot be converted to Charge record array", cause = chargeList);
        } else {
            return chargeList;
        }
    }        
}

function createCaptureQuery(Capture capture) returns string {
    string transferQuery = "";
    string queryString = "";
    foreach [string, anydata] [key, value] in capture.entries() {
        if (key == "transfer_data") {
            var amount = capture["amount"];
            var destination = capture["destination"];
            if (amount is int) {
                transferQuery = transferQuery + "transfer_data[amount]=" + amount.toString() + "&";
            } 
            if (destination is string) {
                transferQuery = transferQuery + "transfer_data[destination]=" + destination.toString() + "&";
            }
        } else {
            queryString = queryString + key + "=" + getEncodedUri(value.toString()) + "&";            
        }
    }
    return queryString + transferQuery;
}
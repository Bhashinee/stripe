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

// public type Charges client object {

//     private http:Client charges;

//     public function __init(http:Client stripeClient) {
//        self.charges = stripeClient;
//     }

//     # Creates a charge.
//     #
//     # + chargeParams - Charge configurations
//     # + return - `Charge` record, or else a `stripe:Error` in case of a failure
//     public remote function createCharge(ChargeParams chargeParams) returns @tainted Charge|Error {
//         return charge;
//     }

//     # Retrieves a customer.
//     #
//     # + chargeId - Charge ID
//     # + return - `Charge` record, or else a `stripe:Error` in case of a failure
//     public remote function retrieveCharge(string chargeId) returns @tainted Charge|Error {
//         return charge;
//     }

//     # Updates a charge.
//     #
//     # + chargeId - Charge ID
//     # + chargeParams - Charge configurations
//     # + return - `Charge` record, or else a `stripe:Error` in case of a failure
//     public remote function updateCharge(string chargeId, ChargeParams chargeParams) returns @tainted Charge|Error {
//         return charge;
//     }

//     # Captures a charge.
//     #
//     # + chargeId - Charge ID
//     # + captureParams - Capture charge configurations
//     # + return - `Charge` record or else a `stripe:Error` if it is already refunded, expired, captured, or an invalid capture amount is specified.
//     public remote function captureCharge(string chargeId, CaptureParams captureParams) returns @tainted Charge|Error {
//         return ();
//     }

//     # Lists all charges.
//     #
//     # + return - An array of `Charge` records, if no charges are available the resulting record will be empty or else a `stripe:Error` 
//     # for non-existant customer IDs
//     public remote function listChrages() returns @tainted Customer[]|Error {
//         return ();
//     }
// };


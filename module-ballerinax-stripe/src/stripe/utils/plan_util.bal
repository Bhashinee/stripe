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

// function createPlanQuery(Plan planParams) returns string {
//     string tierQuery = "";
//     string planQuery = "";

//     foreach [string, anydata] [key, value] in planParams.entries() {
//         if (key == PRODUCT) {
//             var productRecord = planParams?.product;
//             if (productRecord is PlanProduct) {
//                 var active = productRecord[ACTIVE];
//                 var name = productRecord[NAME];
//                 var id = productRecord[ID];
//                 var unitLabel = productRecord[UNIT_LABEL];
//                 var statementDescriptor = productRecord[STATEMENT_DESCRIPTOR];
//                 if (active is boolean) {
//                     planQuery = planQuery + PRODUCT_ACTIVE + active.toString() + AND;
//                 }
//                 if (name is string) {
//                     planQuery = planQuery + PRODUCT_NAME + getEncodedUri(name) + AND;
//                 }
//                 if (id is string) {
//                     planQuery = planQuery + PRODUCT_ID + getEncodedUri(id) + AND;
//                 }
//                 if (statementDescriptor is string) {
//                     planQuery = planQuery + PRODUCT_STATEMENT_DESCRIPTOR + getEncodedUri(statementDescriptor) + AND;
//                 }
//                 if (unitLabel is string) {
//                     planQuery = planQuery + PRODUCT_UNIT_LABEL + getEncodedUri(unitLabel) + AND;
//                 }
//             } 
//             else {
//                 planQuery = planQuery + key + "=" + getEncodedUri(value.toString()) + AND;
//             }
//         } else if (key == PRICE_TIERS) {
//             var tierArray = planParams?.price_tiers;
//             if (tierArray is PlanTierParams[]) {
//                 int count = 0;
//                 foreach var tier in tierArray {
//                     var flatAmount = tier[FLAT_AMOUNT];
//                     var flatAmountDec = tier[FLAT_AMOUNT_DECIMAL];
//                     var unitAmount = tier[UNIT_AMOUNT];
//                     var unitAmountDec = tier[UNIT_AMOUNT_DECIMAL];
//                     var upTo = tier[UP_TO];
//                     if (flatAmount is int) {
//                         tierQuery = tierQuery + TIERS + "[" + count.toString() + "][" 
//                                     + FLAT_AMOUNT + "]=" + flatAmount.toString() + AND;
//                     }
//                     if (flatAmountDec is float) {
//                         tierQuery = tierQuery + TIERS + "[" + count.toString() + "][" 
//                                     + FLAT_AMOUNT_DECIMAL + "]=" + flatAmountDec.toString() + AND;
//                     }
//                     if (unitAmount is int) {
//                         tierQuery = tierQuery + TIERS + "[" + count.toString() + "][" + UNIT_AMOUNT + "]=" 
//                                     + unitAmount.toString() + AND;
//                     }
//                     if (unitAmountDec is float) {
//                         tierQuery = tierQuery + TIERS + "[" + count.toString() + "][" + UNIT_AMOUNT_DECIMAL + "]=" 
//                                     + unitAmountDec.toString() + AND;
//                     }
//                     if (upTo is string) {
//                         tierQuery = tierQuery + TIERS + "[" + count.toString() + "][" + UP_TO + "]=" + upTo + AND;
//                     }
//                     count = count + 1;
//                 }
//             }
//         } else if (key == TRANSFORM_USAGE) {
//             var transformRecord = planParams?.transform_usage;
//             if (transformRecord is PlanTransformUsageParams) {
//                 var devideBy = transformRecord[DIVIDED_BY];
//                 var round = transformRecord[ROUND];
//                 if (devideBy is int) {
//                     planQuery = planQuery + TRANSFORM_USAGE_DIVIDED_BY + devideBy.toString() + AND;
//                 }
//                 if (round is string) {
//                     planQuery = planQuery + TRANSFORM_USAGE_ROUND + getEncodedUri(round) + AND;
//                 }
//             }
//         } else {
//             planQuery = planQuery + key + "=" + getEncodedUri(value.toString()) + AND;
//         }
//     }
//     return planQuery + tierQuery;
// }

function mapToPlanRecord(http:Response response) returns @tainted Plan|Error {
    json|error payload = response.getJsonPayload();
    if (payload is error) {
        return setJsonResError(payload);
    } else {
        io:println("---------------------------------");
        io:println(payload.toJsonString());
        io:println("---------------------------------");
        check checkForErrorResponse(payload);
        Plan|error plan = Plan.constructFrom(payload);
        if (plan is error) {
            return Error(message = "Response cannot be converted to Customer record", cause = plan);
        } else {
            return plan;
        }
    }        
}

function mapToPlans(http:Response response) returns @tainted Plan[]|Error {
    json|error payload = response.getJsonPayload();
    if (payload is error) {
        return setJsonResError(payload);
    } else {
        io:println(payload.toJsonString());
        var plans = payload.data;
        if (plans is error) {
            return setJsonResError(plans);
        }
        json plansJson = <json> plans;
        check checkForErrorResponse(plansJson);
        Plan[]|error plansList = Plan[].constructFrom(plansJson);
        if (plansList is error) {
            return Error(message = "Response cannot be converted to Customer record", cause = plansList);
        } else {
            return plansList;
        }
    }        
}
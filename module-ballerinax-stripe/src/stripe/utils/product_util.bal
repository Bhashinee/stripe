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

import ballerina/io;
import ballerina/http;

function createProductQuery(Product proParams) returns string {
    string attributesQuery = "";
    string queryString = "";
    foreach [string, anydata] [key, value] in proParams.entries() {
        if (key == PRODUCT_ATTRIBUTES) {
            string[]? attr = proParams[PRODUCT_ATTRIBUTES];
            if (attr is string[]) {
                foreach var item in attr {
                    io:println(item);
                    attributesQuery = attributesQuery + ATTRIBUTES_QUERY + item + AND;
                } 
            }   
        } else if (key == PACKAGE_DIMENSIONS) {
            var height = proParams?.package_dimensions[PACKAGE_HEIGHT];
            var length = proParams?.package_dimensions[PACKAGE_LENGTH];
            var weight = proParams?.package_dimensions[PACKAGE_WEIGHT];
            var width = proParams?.package_dimensions[PACKAGE_WIDTH];
            if (height is float) {
                queryString = queryString + PACKAGE_DIMENSION_HEIGHT + height.toString() + AND;
            }
            if (length is float) {
                queryString = queryString + PACKAGE_DIMENSION_LENGTH + length.toString() + AND;
            }
            if (weight is float) {
                queryString = queryString + PACKAGE_DIMENSION_WEIGHT + weight.toString() + AND;
            }
            if (width is float) {
                queryString = queryString + PACKAGE_DIMENSION_WIDTH + width.toString() + AND;
            }
        } else if (key == DEACTIVATE_ON) {
            string[]? deactivateAttr = proParams[DEACTIVATE_ON];
            if (deactivateAttr is string[]) {
                foreach var item in deactivateAttr {
                    queryString = queryString + DEACTIVATE_ON_QUERY + item + AND;
                } 
            }
        } else if (key == IMAGES) {
            string[]? imagesArr = proParams[IMAGES];
            if (imagesArr is string[]) {
                foreach var item in imagesArr {
                    attributesQuery = attributesQuery + IMAGES_QUERY + item + AND;
                } 
            }
        } else {
            queryString = queryString + key + "=" + getEncodedUri(value.toString()) + AND;
        }
    }
    queryString = queryString + attributesQuery;
    io:println("----------------------------------------");
    io:println(queryString);
    io:println("---------------------------------------------");
    return queryString;
}

function mapToProductRecord(http:Response response) returns @tainted Product|Error {
    json|error payload = response.getJsonPayload();
    if (payload is error) {
        return setJsonResError(payload);
    } else {
        io:println("---------------------------------");
        io:println(payload.toJsonString());
        io:println("---------------------------------");
        check checkForErrorResponse(payload);
        Product|error product = Product.constructFrom(payload);
        if (product is error) {
            return Error(message = "Response cannot be converted to Product record", cause = product);
        } else {
            return product;
        }
    }        
}

function mapToProducts(http:Response response) returns @tainted Product[]|Error {
    json|error payload = response.getJsonPayload();
    if (payload is error) {
        return setJsonResError(payload);
    } else {
        var products = payload.data;
        if (products is error) {
            return setJsonResError(products);
        }
        json productsJson = <json> products;
        check checkForErrorResponse(productsJson);
        Product[]|error productList = Product[].constructFrom(productsJson);
        if (productList is error) {
            return Error(message = "Response cannot be converted to Customer record", cause = productList);
        } else {
            return productList;
        }
    }        
}
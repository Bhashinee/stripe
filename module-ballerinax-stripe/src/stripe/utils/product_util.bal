import ballerina/io;
import ballerina/http;


function createProductQuery(Product proParams) returns string {
    string proQuery = "";
    string attributesQuery = "";
    string deactivateOnQuery = "";
    string imagesQuery = "";
    string queryString;
    string dimensionsQuery = "";
    foreach [string, anydata] [key, value] in proParams.entries() {
        if (key == "attributes") {
            string[]? attr = proParams["attributes"];
            if (attr is string[]) {
                foreach var item in attr {
                    io:println(item);
                    attributesQuery = attributesQuery + "attributes[]=" + item + "&";
                } 
            }   
        } else if (key == "package_dimensions") {
            var height = proParams?.package_dimensions["height"];
            var length = proParams?.package_dimensions["length"];
            var weight = proParams?.package_dimensions["weight"];
            var width = proParams?.package_dimensions["width"];
            if (height is float) {
                dimensionsQuery = dimensionsQuery + "package_dimensions[height]=" + height.toString() + "&";
            }
            if (length is float) {
                dimensionsQuery = dimensionsQuery + "package_dimensions[length]=" + length.toString() + "&";
            }
            if (weight is float) {
                dimensionsQuery = dimensionsQuery + "package_dimensions[weight]=" + weight.toString() + "&";
            }
            if (width is float) {
                dimensionsQuery = dimensionsQuery + "package_dimensions[width]=" + width.toString() + "&";
            }
        } else if (key == "deactivate_on") {
            string[]? deactivateAttr = proParams["deactivate_on"];
            if (deactivateAttr is string[]) {
                foreach var item in deactivateAttr {
                    attributesQuery = deactivateOnQuery + "deactivate_on[]=" + item + "&";
                } 
            }
        } else if (key == "images") {
            string[]? imagesArr = proParams["images"];
            if (imagesArr is string[]) {
                foreach var item in imagesArr {
                    attributesQuery = imagesQuery + "images[]=" + item + "&";
                } 
            }
        } else {
            proQuery = proQuery + key + "=" + getEncodedUri(value.toString()) + "&";
        }
    }
    queryString = proQuery + attributesQuery + dimensionsQuery + attributesQuery + imagesQuery;
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
        Product[]|error productList = Product[].constructFrom(productsJson);
        if (productList is error) {
            return Error(message = "Response cannot be converted to Customer record", cause = productList);
        } else {
            return productList;
        }
    }        
}
'use strict';

exports.handler = function (event, context, callback) {
    var response = {
        statusCode: 200,
        body: JSON.stringify(event['headers']['X-Forwarded-For']),
    };

    callback(null, response);
};

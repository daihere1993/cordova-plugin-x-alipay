var exec = require('cordova/exec');

var xAlipay = function (params, successFn, failureFn) {

    exec(successFn, failureFn, 'XAlipay', 'aliPayment', [params]);
};

module.exports = xAlipay;

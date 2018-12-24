var exec = require('cordova/exec');
var channel = require('cordova/channel');

// Called when Cordova is ready for work.
channel.onCordovaReady.subscribe(function() {
    ensureCustomEventExists();
    exec(nativeCallback, null, 'XAlipay', 'initPlugin', []);
});

/*
 * Polyfill for adding CustomEvent which may not exist on older versions of Android.
 * See https://developer.mozilla.org/fr/docs/Web/API/CustomEvent for more details.
 */
function ensureCustomEventExists() {
    // Create only if it doesn't exist
    if (window.CustomEvent) {
        return;
    }
  
    var CustomEvent = function(event, params) {
        params = params || {
            bubbles: false,
            cancelable: false,
            detail: undefined
        };
        var evt = document.createEvent('CustomEvent');
        evt.initCustomEvent(event, params.bubbles, params.cancelable, params.detail);
        return evt;
    };
  
    CustomEvent.prototype = window.Event.prototype;
    window.CustomEvent = CustomEvent;
}

/**
 * Method is called when native side sends us different events.
 * Those events can be about update download/installation process.
 *
 * @param {String} msg - JSON formatted string with call arguments
 */
function nativeCallback(msg) {
    // parse call arguments
    if (msg.hasOwnProperty('eventName')) {
        document.dispatchEvent(new CustomEvent(msg.eventName, msg));
        broadcastEventFromNative(msg);
    } else {
        console.log('EventName is not provided, skipping');
    }
}

var xAlipay = function (params, successFn, failureFn) {
    exec(successFn, failureFn, 'XAlipay', 'aliPayment', [params]);
};

module.exports = xAlipay;

# cordova-plugin-x-alipay
💰This is a alipay plugin of cordova.

# Feature

-  Ali payment for app.

# Install
```bash
cordova plugin add cordova-plugin-x-alipay --variable --variable aliappid=YOUT_ALIPAYAPPID
```

or

```bash
ionic plugin add cordova-plugin-x-alipay --variable --variable aliappid=YOUT_ALIPAYAPPID
```

# Usage

```Javascript
var params = {
    order: 'alipay_sdk=alipay-sdk-java-dynamicVersionNo&app_id=2017062907602740&...', // this string return by back-end
}

xAlipay(params, function() {
    console.log('success');
}, function (error) {
    console.log(error);
});
```
# LICENSE

[MIT LICENSE](http://opensource.org/licenses/MIT)

# cordova-plugin-x-alipay
💰This is a alipay plugin of cordova.

# Feature

-  Ali payment for app.

# Install
```bash
cordova plugin add cordova-plugin-x-alipay --variable aliappid=YOUT_ALIPAYAPPID
```

or

```bash
ionic plugin add cordova-plugin-x-alipay --variable aliappid=YOUT_ALIPAYAPPID
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

# Events

- `XAlipay_StandbyCallback_Success` for iOS only. Will call when app launch alipay and self been killed. [More Info](https://docs.open.alipay.com/204/105295/#s8)
- `XAlipay_StandbyCallback_Error` for iOS only. Will call when app launch alipay and self been killed. [More Info](https://docs.open.alipay.com/204/105295/#s8)

## Example

```
document.addEventListener('XAlipay_StandbyCallback_Success', function(event){
    alert(event);
}, false);
```

# LICENSE

[MIT LICENSE](http://opensource.org/licenses/MIT)

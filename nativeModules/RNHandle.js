'use strict'

import {
    NativeModules,
    NativeAppEventEmitter
} from 'react-native';

var promisify = require("es6-promisify");
var RNHandle = NativeModules.RNHandle;
var _updateVersion = promisify(RNHandle.updateVersion)

let progressEventName = 'updateProgressEvent'
var _error = (err) => {
    throw err
}

var Handle = {
    updateVersion(newVersion, currentVersion,downloadUrl) {
        return _updateVersion(newVersion, currentVersion,downloadUrl)
            .catch(_error)
    },
    addListener(callback) {
        return NativeAppEventEmitter.addListener(progressEventName, callback)
    }
}

module.exports = Handle
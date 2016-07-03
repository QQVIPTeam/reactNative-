/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 * @flow
 */

import React, { Component } from 'react';
import {
    AppRegistry,
    StyleSheet,
    Text,
    View,
    Image,
    TouchableOpacity,
    Animated,
    Dimensions
} from 'react-native';


import FileDownload from 'react-native-file-download';
import RNFS from 'react-native-fs';
//import ZipArchive from'react-native-zip-archive';
import DeviceInfo from 'react-native-device-info';

//import Handle from './nativeModules/RNHandle';
import Config from './config';
import GamePageView from './app/GamePageView';

const fileName = "main.json";
const DEST = RNFS.DocumentDirectoryPath+'/JSBundle';
const destFileName = DEST+'/'+fileName;
console.log(DEST);
const headers = {
    "Accept-Language": "en-US"
};

class hotUpdate extends Component {

    constructor(props) {
        super(props);
        this.state = {
            showMessage:false,
            dataInfo:{}
        }
    }

    componentDidMount() {

        var self = this;
        //获取app版本信息
        var appVersion = DeviceInfo.getVersion();
        this._versionCompare(function (data) {
            self.setState({
                dataInfo: data
            });
            console.log(data);
            var _data = self.state.dataInfo;
            if(appVersion == _data['appVersion']){
                if(Config.pachVersion == _data['curPachVersion']){
                    if(Config.pachVersion<_data['targetPachVersion']){
                        self._downloadJsBoundle();
                    }
                }
                //已经更新到最新版
                if(Config.pachVersion==_data['targetPachVersion']){
                    //检测是否存在lock文件
                    RNFS.exists(DEST+'/update.lock').then((bool)=>{
                        if(!bool){
                            //更新到新版首次提示message
                            self.setState({
                                showMessage:true
                            });

                            RNFS.writeFile(DEST+'/update.lock', '', 'utf8')
                                .then((success) => {
                                    console.log('FILE WRITTEN!');
                                })
                                .catch((err) => {
                                    console.log(err.message);
                                });
                        }
                    })


                }

            }

        });
        console.log(RNFS.MainBundlePath);
    }

    _downloadJsBoundle() {
        var self = this;

        const URL = Config.url+this.state.dataInfo['targetPachVersion']+"/"+fileName+"?time="+Math.random();
        FileDownload.download(URL, DEST, fileName, headers)
            .then((response) => {
                RNFS.stat(destFileName).then((info)=>{
                    if(info.size == self.state.dataInfo['targetPachSize']){

                        //delete jsboundle assets
                        RNFS.unlink(DEST+"/main.jsbundle")
                            .then(()=>{
                                console.log("delete sucess!");
                            })
                            .catch((error)=>{
                                console.log(error);
                            })
                        //rename
                        RNFS.moveFile(DEST+"/main.json",DEST+"/main.jsbundle")
                            .then(()=>{
                                console.log("moveFile sucess!");
                            })
                            .catch((error)=>{
                                console.log(error);
                            })
                    }
                })

            })
            .catch((error) => {
                console.log(error)
            })


    }

    _get(url,sucessCallback ,failCallback) {
        fetch(url)
            .then((response) => response.text())
            .then((responseText) => {
                sucessCallback(JSON.parse(responseText));
            })
            .catch(function(err){
                failCallback(err);
            })
    }

    _versionCompare(callback) {
        this._get(
            Config.url+'version.json'+"?time="+Math.random(),
            function (data) {
                callback(data);

            },function (err) {
                console.log(err);
            }
        )
    }

    _delJsboundle() {
        //delete jsboundle assets
        RNFS.exists(DEST+'/update.lock').then((bool)=>{
            if(bool){
                RNFS.unlink(DEST+"/update.lock")
                    .then(()=>{
                        alert("本地lock文件删除成功");
                    })
            }
        })

        RNFS.exists(DEST+"/main.jsbundle").then((bool)=>{
            if(bool){
                RNFS.unlink(DEST+"/main.jsbundle")
                    .then(()=>{
                        alert("本地jsoundle文件删除成功");
                    })

            }
        })

    }


    render() {
        return (
            <View style={styles.container}>
                <GamePageView></GamePageView>
                {this.state.showMessage && <View style={[styles.tipsContainer]}>
                    <Text style={styles.tipsText} numberOfLines={1}>{this.state.dataInfo.message}</Text>
                </View>}
                <TouchableOpacity onPress={this._delJsboundle}>
                    <View style={styles.delBtn}><Text style={styles.delText}>Del</Text></View>
                </TouchableOpacity>
            </View>
        );
    }
}

const styles = StyleSheet.create({
    container: {
        backgroundColor: '#000'
    },
    tipsContainer:{
        position:"absolute",
        paddingTop:5,
        paddingBottom:5,
        left: Dimensions.get('window').width/2-60,
        bottom:60,
        backgroundColor:'red',
        width:120,
        flex:1,
        justifyContent: 'center',
        alignItems: 'center',
        borderRadius:10
    },
    tipsText:{
        color:'#fff',
        fontSize:12
    },
    delBtn:{
        position:"absolute",
        right:20,
        bottom:20,
        paddingTop:5,
        paddingBottom:5,
        width:30,
        height:30,
        borderRadius:15,
        backgroundColor:'gray',
        overflow:"hidden",
        flex:1,
        justifyContent: 'center',
        alignItems: 'center',
    },
    delText:{
        color:"#fff",
        fontSize:12
    }
});

AppRegistry.registerComponent('hotUpdate', () => hotUpdate);

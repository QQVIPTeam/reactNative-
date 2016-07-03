'use strict';
import React, { Component } from 'react';
import {
    AppRegistry,
    StyleSheet,
    ListView,
    Image,
    Text,
    View
} from 'react-native';
import Util from './Util';
import Color from './Color';
const deviceSize = Util.deviceSize();
const gridWidth = deviceSize.deviceWidth/3;//单行显示三个游戏

export default class Cell extends Component {

    render() {
        var row = this.props.row,
            tag = this.props.row.tag,
            _index = this.props.index,
            leftStyle = '';

        var itemContainer = function(){
            return {
                left:0,
                position:'relative',
                paddingBottom:9,
                backgroundColor:'#000'
            };
        };

        return (
            <View style={itemContainer()}>
                <View style={[styles.thumbBox]}>
                    <Image source={{uri:row.coverImg}} style={styles.thumbNail} />
                    {
                        tag ?
                            <View style={[styles.tagContainer,styles.center]}>
                                <Text style={[styles.tagText]}>{row.tag}</Text>
                            </View>
                            : null
                    }
                </View>
                <View style={styles.content}>
                    <Text numberOfLines={1} style={[styles.flex,styles.center,styles.title]}>{row.appName}</Text>
                    <Text numberOfLines={1} style={[styles.flex,styles.center,styles.description]}>{row.slogan}</Text>
                </View>
            </View>
        );
    }
}

const styles = StyleSheet.create({
    flex:{
        flex:1
    },
    center:{
        justifyContent: 'center',
        alignItems: 'center'
    },
    itemContainer:{
        paddingBottom:9
    },
    content:{
        paddingLeft:10,
        paddingRight:10,
        width:gridWidth-10,
    },
    thumbBox:{
        width:gridWidth,
        height:gridWidth*1.4947
    },
    thumbNail:{
        width:gridWidth,
        height:gridWidth*1.4947,
        overflow:"hidden"
    },
    title:{
        marginTop:8,
        height:22,
        fontSize:15,
        color:'#fff'
    },
    description:{
        height:15,
        fontSize:10,
        color:Color.secondaryColor,
    },
    tagContainer:{
        position: 'absolute',
        top: 5,
        right: 0,
        flex:1,
        paddingLeft:8,
        paddingRight:5,
        height: 19,
        borderTopLeftRadius:19,
        borderBottomLeftRadius:19,
        backgroundColor: Color.tagBgColor
    },
    tagText:{
        color: '#fff',
        fontSize: 10,
    }
});


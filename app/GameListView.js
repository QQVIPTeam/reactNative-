'use strict';
import React, { Component } from 'react';
import {
    AppRegistry,
    Image,
    ListView,
    TouchableHighlight,
    StyleSheet,
    Text,
    View
} from 'react-native';

import Util from './Util';
import Cell from './GameCollectionCell';
const deviceSize = Util.deviceSize();

export default class GameListView extends Component {
    constructor(props) {
        super(props);
        this.state = {
            baseUrl : this.props.baseUrl,
            dataSource: new ListView.DataSource({
                rowHasChanged: (row1, row2) => row1 !== row2,
            }),
            show:false
        };
    }

    componentDidMount() {
        var that = this;
        that.setState({
            dataSource: that.state.dataSource.cloneWithRows(that.props.baseData),
            show: true
        });
    }
    _renderRow(rowData, sectionID, rowID, highlightRow) {
        return <Cell row={rowData} index={rowID}></Cell>
    }

    render() {
        return (
            <View>
                {this.state.show ?
                    <ListView
                        contentContainerStyle={styles.list}
                        dataSource={this.state.dataSource}
                        style={styles.listView}
                        renderRow={this._renderRow}
                    />
                    : Util.renderLoadingView
                }
            </View>
        );
    }

}
var styles = StyleSheet.create({
    listView:{
        flex:1,
        paddingTop:1,
        height:deviceSize.deviceHeight-45-20,
        backgroundColor:'#000'
    },
    list: {
        flexDirection: 'row',
        flexWrap: 'wrap'
    }
});


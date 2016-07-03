import React, { Component } from 'react';
import {
    StyleSheet,
    Text,
} from 'react-native';
import Config from '../config';
import ScrollableTabView from 'react-native-scrollable-tab-view';
import ListView from './GameListView';
import GameTabBar from './GameTabBar';
import Color from './Color';

export default class GamePageView extends Component {

    constructor(props) {
        super(props);
        this.state = {
            tabs:this.getcategoryName()
        };
    }

    getcategoryName() {
        var cate =['全部'];
        let categoryMap = Config.gameList.data.categoryMap;
        for(var i in categoryMap){
            cate.push(categoryMap[i])
        }
        return cate;
    }


    render() {
        return <ScrollableTabView
            style={styles.container}
            renderTabBar={() => <GameTabBar backgroundColor={Color.tabBar}/>}
        >
            {this.state.tabs.map((tab, i) => {
                var gameArray = [];
                console.log(i);
                var baseData = i==0 ? Config.gameList.data.list : Config.gameList.data.map[i];
                return <ListView tabLabel={tab} key={i} baseData={baseData}></ListView>;
            })}
        </ScrollableTabView>;
    }
}

const styles = StyleSheet.create({
    container:{
        backgroundColor: '#000'
    }
})

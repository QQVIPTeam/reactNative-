import React,{
    PixelRadio,
    View,
    Text,
    ActivityIndicatorIOS,
    Dimensions,
    Platform
} from 'react-native';

class Util {

    static pixel(number) {
        var number = number ? number : 1;
        return number/React.PixelRatio.get();
    }

    static deviceSize() {
        return({
            deviceWidth : Dimensions.get('window').width,
            deviceHeight : Dimensions.get('window').height
        });
    }

    static get(url,sucessCallback ,failCallback) {
        fetch(url)
            .then((response) => response.text())
            .then((responseText) => {
                sucessCallback(JSON.parse(responseText));
            })
            .catch(function(err){
                failCallback(err);
            })
    }

    static renderLoadingView() {
        if (Platform.OS === 'ios') {
            return (
                <View style={{flex:1,justifyContent: 'center',alignItems: 'center',height:Dimensions.get('window').height}}>
                    <ActivityIndicatorIOS
                        color={'#000'}
                        style={{marginBottom:10}}/>
                    <Text style={{color:'#777',fontSize:12}}>正在努力加载中</Text>
                </View>
            );
        }

    }

};

module.exports = Util;
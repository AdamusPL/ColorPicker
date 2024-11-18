import { StyleSheet, View, Image, Pressable, Dimensions } from "react-native";
import { Text } from 'react-native-paper';
import React, { useState } from "react";
import { convertHSVToRGB } from "./Calculator";
import { KeyboardAwareScrollView } from "react-native-keyboard-aware-scroll-view";
import Square from "../components/Square";
import { useColor } from "../components/ColorProvider";
import TextFields from "../components/TextFields";

export default function PaletteChoice() {
    const { selectedColor, setSelectedColor } = useColor();
    const { width, height } = Dimensions.get('window');
    const [pressableCenterPosition, setPressableCenterPosition] = useState({ x: 0, y: 0 });
    const [pressableWidth, setPressableWidth] = useState(0);
    const [circlePosition, setCirclePosition] = useState({ x: 0, y: 0});
    const [isDrawing, setIsDrawing] = useState(false);

    const handlePress = (event) => {
        const { pageX, pageY } = event.nativeEvent;

        if(!isDrawing){
            setIsDrawing(true);
        }

        const centerX = pressableCenterPosition.x;
        const centerY = pressableCenterPosition.y;
        
        const radius = pressableWidth / 2;
        const distance = Math.sqrt(Math.pow(pageX - centerX, 2) + Math.pow(pageY - centerY, 2));
        const angle = Math.atan2(pageY - centerY, pageX - centerX) * (180 / Math.PI);

        // console.log("locationX", locationX)
        // console.log("locationY", locationY)
        // console.log("centerX", centerX)
        // console.log("distance", distance)
        // console.log("angle", angle);
        // console.log("");

        if (distance <= radius) {
            const hue = (angle + 360) % 360;

            const saturation = Math.min(distance / radius, 1) * 100;

            const value = 100;

            const { r, g, b } = convertHSVToRGB(hue, saturation, value);

            setSelectedColor(`rgb(${r}, ${g}, ${b})`);

            setCirclePosition({ x: pageX, y: pageY });
        }else{
            console.log("centerX: ", centerX);
            console.log("centerY: ", centerY);
            console.log("pageX: ", pageX);
            console.log("pageY: ", pageY);
            console.log("locationX - centerX pow: ", Math.pow(pageX - centerX, 2));
            console.log("locationY - centerY pow: ", Math.pow(pageY - centerY, 2));
            console.log("sqrt: ", Math.sqrt(Math.pow(pageX - centerX, 2) + Math.pow(pageY - centerY, 2)));
            console.log("distance: ", distance);
            console.log("radius: ", radius);
            console.log("out of range");  
        }

    };

    function handlePressableLayout(event) {
        const {x, y, width, height} = event.nativeEvent.layout;
        const previousY = pressableCenterPosition.y;
        const previousX = pressableCenterPosition.x;
        setPressableCenterPosition({ x: x + previousX + width/2, y: y + previousY + height/2 });
        setPressableWidth(width);
    }

    function handleLayout(event) {
        const { x, y } = event.nativeEvent.layout;
        const previousX = pressableCenterPosition.x;
        const previousY = pressableCenterPosition.y;
        setPressableCenterPosition({ x: x + previousX, y: y + previousY });
    }

    function handleLayoutDemo(event) {
        const {  x, y  } = event.nativeEvent.layout;
        const previousX = pressableCenterPosition.x;
        const previousY = pressableCenterPosition.y;
        setPressableCenterPosition({ x: x + previousX, y: y + previousY });
    }


    return (<>
        <KeyboardAwareScrollView>
            <View onLayout={handleLayoutDemo}>
                <Text style={styles.title} variant="titleLarge">Color picker</Text>
                <View onLayout={handleLayout} style={styles.centered}>
                    <Pressable
                        onStartShouldSetResponder={() => true}
                        onMoveShouldSetResponder={() => true}
                        onTouchMove={handlePress}
                        onPress={handlePress}
                        onLayout={handlePressableLayout}
                        style={styles.centeredPalette}>
                        <Image style={styles.image} source={require('./images/palette.png')}></Image>
                        
                    </Pressable>
                    
                </View>
                <View style={styles.centeredSquare}>
                    <Square width={65} height={65} />
                </View>
                {circlePosition && isDrawing && (
                            <View
                                style={[
                                    styles.circle,
                                    {
                                        top: circlePosition.y - 10,
                                        left: circlePosition.x - 10,
                                    },
                                ]}
                            />
                        )}
            </View >
            
            <TextFields isReadOnly={true} />

        </KeyboardAwareScrollView >
    </>)
}

const styles = StyleSheet.create({
    body: {
        marginLeft: 15,
        marginRight: 15
    },

    title: {
        marginLeft: 15,
        marginRight: 15,
        marginTop: 20,
        marginBottom: 30
    },

    square: {
        width: 70,
        height: 70,
        marginTop: 5,
        marginBottom: 10
    },

    centeredSquare: {
        alignItems: 'center',
    },

    centeredPalette: {
        alignItems: 'center',
        justifyContent: 'center',
        borderRadius: 175,
        width: 315,
        height: 315,
    },

    centered: {
        alignItems: 'center',
        justifyContent: 'center',
        flex: 1,
        width: '100%',
        height: '100%',
    },

    palette: {
        marginTop: 30
    },

    circle: {
        position: 'absolute',
        width: 20,
        height: 20,
        backgroundColor: 'rgb(0, 0, 0)',
        borderRadius: 25,
        borderWidth: 3,
        borderColor: 'black',
        backgroundColor: 'transparent',
    },

    image: {
        width: 315,
        height: 315
    }
})
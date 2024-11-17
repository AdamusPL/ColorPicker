import { StyleSheet, View, Image, Pressable, Dimensions } from "react-native";
import { TextInput, Text } from 'react-native-paper';
import React, { useEffect, useState } from "react";
import { convertRGBToCMYK, convertRGBToHex, convertRGBToHSV, convertHSVToRGB } from "./Calculator";
import { KeyboardAwareScrollView } from "react-native-keyboard-aware-scroll-view";

export default function PaletteChoice() {
    const { width, height } = Dimensions.get('window');
    const [circlePosition, setCirclePosition] = useState({ x: 101, y: 101 });
    const [selectedColor, setSelectedColor] = useState('rgb(255, 0, 0)');
    const [isDrawing, setIsDrawing] = useState(false);

    //r,g,b
    const [r, setR] = useState("0");
    const [g, setG] = useState("0");
    const [b, setB] = useState("0");

    //h,s,v
    const [h, setH] = useState("0");
    const [s, setS] = useState("0");
    const [v, setV] = useState("0");

    //c,m,y,k
    const [c, setC] = useState("0");
    const [m, setM] = useState("0");
    const [y, setY] = useState("0");
    const [k, setK] = useState("0");

    //hex
    const [hex, setHex] = useState("000000");

    useEffect(() => {
        handleChange();
    }, [selectedColor]);

    function handleChange() {
        const result = selectedColor.match(/\d+/g);
        if (result && result.length === 3) {
            const [r, g, b] = result.map(Number);

            let hsv = convertRGBToHSV(r, g, b);
            let cmyk = convertRGBToCMYK(r, g, b);
            let hex = convertRGBToHex(r, g, b);

            setR(r.toString());
            setG(g.toString());
            setB(b.toString());

            setH(hsv.h);
            setS(hsv.s);
            setV(hsv.v);

            setC(cmyk.c);
            setM(cmyk.m);
            setY(cmyk.y);
            setK(cmyk.k);

            setHex(hex);
        }
    }

    const handlePress = (event) => {
        const { locationX, locationY } = event.nativeEvent;

        const centerX = 101;
        const centerY = 101;
        const radius = 101;
        const distance = Math.sqrt(Math.pow(locationX - centerX, 2) + Math.pow(locationY - centerY, 2));
        const angle = Math.atan2(locationY - centerY, locationX - centerX) * (180 / Math.PI);

        console.log("locationX", locationX)
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

            const rgbColor = `rgb(${r}, ${g}, ${b})`;
            setSelectedColor(rgbColor);
            setR(r.toString());
            setG(g.toString());
            setB(b.toString());

            setCirclePosition({ x: locationX, y: locationY });
        }

    };

    function handleTouchStart(event) {
        setIsDrawing(true);

        handlePress(event);
    }

    function handleTouchMove(event) {
        if (!isDrawing) return;

        handlePress(event);
    }

    function handleTouchEnd(event) {
        setIsDrawing(false);
    }


    return (<>
        <KeyboardAwareScrollView>
            <View style={styles.body}>
                <Text style={styles.title} variant="titleLarge">Color picker</Text>
                <View style={styles.centered}>
                    <Pressable
                        onStartShouldSetResponder={() => true}
                        onMoveShouldSetResponder={() => true}
                        onTouchStart={handleTouchStart}
                        onTouchMove={handleTouchMove}
                        onTouchEnd={handleTouchEnd}
                        onPress={handlePress}
                        style={styles.centeredPalette}>
                        <Image style={styles.image} source={require('./images/palette.png')}></Image>
                        {circlePosition && (
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
                    </Pressable>
                </View>
                <View style={styles.centeredSquare}>
                    <View style={[styles.square, { backgroundColor: selectedColor }]}></View>
                </View>
            </View >

            <View style={styles.fields}>
                <View style={styles.container}>
                    <TextInput style={styles.input}
                        label="R"
                        value={r}
                        readOnly
                        maxLength={3}
                    />
                    <TextInput style={styles.input}
                        label="G"
                        value={g}
                        readOnly
                        maxLength={3}
                    />
                    <TextInput style={styles.input}
                        label="B"
                        value={b}
                        readOnly
                        maxLength={3}
                    />
                </View>

                <View style={styles.container}>
                    <TextInput style={styles.input}
                        label="H"
                        value={h}
                        readOnly
                        maxLength={3}
                        right={<TextInput.Affix text="°" />}
                    />
                    <TextInput style={styles.input}
                        label="S"
                        value={s} readOnly
                        maxLength={3}
                        right={<TextInput.Affix text="%" />}
                    />
                    <TextInput style={styles.input}
                        label="V"
                        value={v}
                        readOnly
                        maxLength={3}
                        right={<TextInput.Affix text="%" />}
                    />
                </View>

                <View style={styles.container}>
                    <TextInput style={styles.input}
                        label="C"
                        value={c}
                        readOnly
                        maxLength={3}
                        right={<TextInput.Affix text="%" />}
                    />
                    <TextInput style={styles.input}
                        label="M"
                        value={m}
                        readOnly
                        maxLength={3}
                        right={<TextInput.Affix text="%" />}
                    />
                    <TextInput style={styles.input}
                        label="Y"
                        value={y}
                        readOnly
                        maxLength={3}
                        right={<TextInput.Affix text="%" />}
                    />
                    <TextInput style={styles.input}
                        label="K"
                        value={k}
                        readOnly
                        maxLength={3}
                        right={<TextInput.Affix text="%" />}
                    />
                </View>

                <View style={styles.container}>
                    <TextInput style={styles.input}
                        label="Hex"
                        value={hex}
                        readOnly
                        maxLength={6}
                        left={<TextInput.Affix text="#" />}
                    />
                </View>
            </View>
        </KeyboardAwareScrollView >
    </>)
}

const styles = StyleSheet.create({
    body: {
        marginLeft: 15,
        marginRight: 15
    },

    fields: {
        marginLeft: 5,
        marginRight: 5
    },

    title: {
        marginTop: 30,
        marginBottom: 30
    },

    container: {
        flexDirection: 'row',
        marginTop: 15
    },

    input: {
        flex: 1,
        marginHorizontal: 5
    },

    square: {
        width: 100,
        height: 100,
        marginTop: 30
    },

    centeredSquare: {
        alignItems: 'center',
        marginTop: 30,
    },

    centeredPalette: {
        alignItems: 'center',
        justifyContent: 'center',
        flex: 1,
        width: 202,
        height: 202,
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
        width: 202,
        height: 202
    }
})
import { StyleSheet, View } from "react-native";
import { TextInput, Text } from 'react-native-paper';
import React, { useEffect } from "react";
import { useState } from "react";
import { convertHexToRGB, convertHSVToRGB, convertRGBToCMYK, convertRGBToHex, convertRGBToHSV, convertCMYKToRGB } from "./Calculator";
import { KeyboardAwareScrollView } from "react-native-keyboard-aware-scroll-view";
import Palette from "./Palette";

export default function PaletteChoice() {

    const [selectedColor, setSelectedColor] = useState('rgb(255, 0, 0)');

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

    return (<>
        <KeyboardAwareScrollView>
            <View style={styles.body}>
                <Text style={styles.title} variant="titleLarge">Color picker</Text>
                <Palette onColorSelect={setSelectedColor} />
                <View style={styles.centeredSquare}>
                    <View style={[styles.square, { backgroundColor: selectedColor }]}></View>
                </View>
            </View>

            <View style={styles.fields}>
                <View style={styles.container}>
                    <TextInput style={styles.input}
                        label="R"
                        value={r}
                        disabled
                        maxLength={3}
                    />
                    <TextInput style={styles.input}
                        label="G"
                        value={g}
                        disabled
                        maxLength={3}
                    />
                    <TextInput style={styles.input}
                        label="B"
                        value={b}
                        disabled
                        maxLength={3}
                    />
                </View>

                <View style={styles.container}>
                    <TextInput style={styles.input}
                        label="H"
                        value={h}
                        disabled
                        maxLength={3}
                        right={<TextInput.Affix text="°" />}
                    />
                    <TextInput style={styles.input}
                        label="S"
                        value={s} disabled
                        maxLength={3}
                        right={<TextInput.Affix text="%" />}
                    />
                    <TextInput style={styles.input}
                        label="V"
                        value={v}
                        disabled
                        maxLength={3}
                        right={<TextInput.Affix text="%" />}
                    />
                </View>

                <View style={styles.container}>
                    <TextInput style={styles.input}
                        label="C"
                        value={c}
                        disabled
                        maxLength={3}
                        right={<TextInput.Affix text="%" />}
                    />
                    <TextInput style={styles.input}
                        label="M"
                        value={m}
                        disabled
                        maxLength={3}
                        right={<TextInput.Affix text="%" />}
                    />
                    <TextInput style={styles.input}
                        label="Y"
                        value={y}
                        disabled
                        maxLength={3}
                        right={<TextInput.Affix text="%" />}
                    />
                    <TextInput style={styles.input}
                        label="K"
                        value={k}
                        disabled
                        maxLength={3}
                        right={<TextInput.Affix text="%" />}
                    />
                </View>

                <View style={styles.container}>
                    <TextInput style={styles.input}
                        label="Hex"
                        value={hex}
                        disabled
                        maxLength={6}
                        left={<TextInput.Affix text="#" />}
                    />
                </View>
            </View>
        </KeyboardAwareScrollView>
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
        width: 250,
        height: 250,
        marginTop: 30
    },

    centeredSquare: {
        alignItems: 'center',
        marginTop: 30
    },

    palette: {
        marginTop: 30
    }
})
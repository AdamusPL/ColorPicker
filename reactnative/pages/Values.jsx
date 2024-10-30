import { StyleSheet, View, Text } from "react-native";
import { TextInput } from 'react-native-paper';
import React, { useEffect } from "react";
import { useState } from "react";
import { convertHexToRGB, convertHSVToRGB, convertRGBToCMYK, convertRGBToHex, convertRGBToHSV, convertCMYKToRGB } from "./Calculator";

export default function Values() {
    
    //r,g,b
    const [r, setR] = useState(0);
    const [g, setG] = useState(0);
    const [b, setB] = useState(0);

    //h,s,v
    const [h, setH] = useState(0.0);
    const [s, setS] = useState(0.0);
    const [v, setV] = useState(0.0);

    //c,m,y,k
    const [c, setC] = useState(0.0);
    const [m, setM] = useState(0.0);
    const [y, setY] = useState(0.0);
    const [k, setK] = useState(0.0);

    //hex
    const [hex, setHex] = useState(0);

    // function handleChange() {
    //     let hsv = convertRGBToHSV(r, g, b);
    //     let cmyk = convertRGBToCMYK(r, g, b);
    //     let hex = convertRGBToHex(r, g, b);

    //     setH(hsv.h);
    //     setS(hsv.s);
    //     setV(hsv.v);

    //     setC(cmyk.c);
    //     setM(cmyk.m);
    //     setY(cmyk.y);
    //     setK(cmyk.k);

    //     setHex(hex);
    // }

    function handleRGBChange(input, label) {
        let hsv = {};
        let cmyk = {};
        let hex = "";

        switch (label) {
            case 'r':
                hsv = convertRGBToHSV(input, g, b);
                cmyk = convertRGBToCMYK(input, g, b);
                hex = convertRGBToHex(input, g, b);
                setR(input);
                break;
            case 'g':
                hsv = convertRGBToHSV(r, input, b);
                cmyk = convertRGBToCMYK(r, input, b);
                hex = convertRGBToHex(r, input, b);
                setG(input);
                break;
            case 'b':
                hsv = convertRGBToHSV(r, g, input);
                cmyk = convertRGBToCMYK(r, g, input);
                hex = convertRGBToHex(r, g, input);
                setB(input);
                break;
        }

        setH(hsv.h);
        setS(hsv.s);
        setV(hsv.v);

        setC(cmyk.c);
        setM(cmyk.m);
        setY(cmyk.y);
        setK(cmyk.k);

        setHex(hex);
    }

    function handleHSVChange(input, label) {

        let rgb = {};
        let cmyk = {};
        let hex = "";

        switch (label) {
            case 'h':
                rgb = convertHSVToRGB(input, s, v);
                cmyk = convertRGBToCMYK(input, s, v);
                hex = convertRGBToHex(input, s, v);
                setH(input);
                break;
            case 's':
                rgb = convertHSVToRGB(h, input, v);
                cmyk = convertRGBToCMYK(h, input, v);
                hex = convertRGBToHex(h, input, v);
                setS(input);
                break;
            case 'v':
                rgb = convertHSVToRGB(h, s, input);
                cmyk = convertRGBToCMYK(h, s, input);
                hex = convertRGBToHex(h, s, input);
                setV(input);
                break;
        }

        setR(rgb.r);
        setG(rgb.g);
        setB(rgb.b);

        setC(cmyk.c);
        setM(cmyk.m);
        setY(cmyk.y);
        setK(cmyk.k);

        setHex(hex);
    }

    function handleCMYKChange(input, label) {
        let rgb = {};
        let hsv = {};
        let hex = "";

        switch (label) {
            case 'c':
                rgb = convertCMYKToRGB(input, m, y, k);
                hsv = convertRGBToHSV(input, m, y, k);
                hex = convertRGBToHex(input, m, y, k);
                setC(input);
                break;
            case 'm':
                rgb = convertCMYKToRGB(c, input, y, k);
                hsv = convertRGBToHSV(c, input, y, k);
                hex = convertRGBToHex(c, input, y, k);
                setM(input);
                break;
            case 'y':
                rgb = convertCMYKToRGB(c, m, input, k);
                hsv = convertRGBToHSV(c, m, input, k);
                hex = convertRGBToHex(c, m, input, k);
                setY(input);
                break;
            case 'k':
                rgb = convertCMYKToRGB(c, m, y, input);
                hsv = convertRGBToHSV(c, m, y, input);
                hex = convertRGBToHex(c, m, y, input);
                setK(input);
                break;
        }

        setR(rgb.r);
        setG(rgb.g);
        setB(rgb.b);

        setH(hsv.h);
        setS(hsv.s);
        setV(hsv.v);

        setHex(hex);
    }

    function handleHexChange(input) {
        const rgb = convertHexToRGB(input);
        const hsv = convertRGBToHex(input);
        const cmyk = convertCMYKToRGB(input);
        setHex(input);

        setR(rgb.r);
        setG(rgb.g);
        setB(rgb.b);

        setH(hsv.h);
        setS(hsv.s);
        setV(hsv.v);

        setC(cmyk.c);
        setM(cmyk.m);
        setY(cmyk.y);
        setK(cmyk.k);
    }

    return (<>
        <View style={[styles.square, { backgroundColor: `rgb(${r},${g},${b})` }]}></View>
        <Text>Color picker</Text>

        <View style={styles.container}>
            <TextInput style={styles.input}
                label="R"
                value={r}
                defaultValue="0"
                keyboardType="numeric"
                maxLength={3}
                onChangeText={x => handleRGBChange(x, 'r')}
            />
            <TextInput style={styles.input}
                label="G"
                value={g}
                defaultValue="0"
                keyboardType="numeric"
                maxLength={3}
                onChangeText={x => handleRGBChange(x, 'g')}
            />
            <TextInput style={styles.input}
                label="B"
                value={b}
                defaultValue="0"
                keyboardType="numeric"
                maxLength={3}
                onChangeText={x => handleRGBChange(x, 'b')}
            />
        </View>

        <View style={styles.container}>
            <TextInput style={styles.input}
                label="H"
                value={h}
                defaultValue="0.00"
                keyboardType="numeric"
                onChangeText={h => handleHSVChange(h, 'h')}
            />
            <TextInput style={styles.input}
                label="S"
                value={s}
                defaultValue="0.00"
                keyboardType="numeric"
                onChangeText={s => handleHSVChange(s, 's')}
            />
            <TextInput style={styles.input}
                label="V"
                value={v}
                defaultValue="0.00"
                keyboardType="numeric"
                onChangeText={v => handleHSVChange(v, 'v')}
            />
        </View>

        <View style={styles.container}>
            <TextInput style={styles.input}
                label="C"
                value={c}
                defaultValue="0.00"
                keyboardType="numeric"
                onChangeText={c => handleCMYKChange(c, 'c')}
            />
            <TextInput style={styles.input}
                label="M"
                value={m}
                defaultValue="0.00"
                keyboardType="numeric"
                onChangeText={m => handleCMYKChange(m, 'm')}
            />
            <TextInput style={styles.input}
                label="Y"
                value={y}
                defaultValue="0.00"
                keyboardType="numeric"
                onChangeText={y => handleCMYKChange(y, 'y')}
            />
            <TextInput style={styles.input}
                label="K"
                value={k}
                defaultValue="0.00"
                keyboardType="numeric"
                onChangeText={k => handleCMYKChange(k, 'k')}
            />
        </View>

        <TextInput style={styles.input}
            label="Hex"
            value={hex}
            defaultValue="000000"
            maxLength={7}
            onChangeText={handleHexChange}
        />
    </>)
}

const styles = StyleSheet.create({
    container: {
        flexDirection: 'row',
        justifyContent: 'space-between'
    },

    input: {
        // flex: 1
    },

    square: {
        width: 100,
        height: 100
    }
})
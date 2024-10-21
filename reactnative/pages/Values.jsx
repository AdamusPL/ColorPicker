import { StyleSheet, View, Text } from "react-native";
import { TextInput } from 'react-native-paper';
import React from "react";
import { useState } from "react";

export default function Values() {
    const [value, setValue] = React.useState(0);

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

    function handlePercentChange(input, label) {
        const userInput = input.slice(0, -1);
        // console.log(userInput);

        if (/^\d*\.?\d{0,2}$/.test(userInput) && userInput.length <= 3) {
            switch (label) {
                case 'h': setH(userInput + '°'); break;
                case 's': setS(userInput + '%'); break;
                case 'v': setV(userInput + '%'); break;
                case 'c': setC(userInput + '%'); break;
                case 'm': setM(userInput + '%'); break;
                case 'y': setY(userInput + '%'); break;
                case 'k': setK(userInput + '%'); break;
            }
        }
    }

    //hex
    const [hex, setHex] = useState(0);

    function handleHexChange(input) {
        const userInput = input.substring(1);
        console.log(`userinput=${userInput}`);

        if (/^[a-fA-F0-9]*$/.test(userInput) && userInput.length <= 6) {
            setHex('#' + userInput);
            const [r, g, b] = convertHexToRGB(userInput);
            convertRGBToRest(r, g, b);
        }
    }

    function convertHSVToRGB() {

    }

    function convertCMYKToRGB() {

    }

    function convertHexToRGB(userInput) {
        // console.log(userInput);
        var bigint = parseInt(userInput, 16);
        var r = (bigint >> 16) & 255;
        var g = (bigint >> 8) & 255;
        var b = bigint & 255;

        console.log(`r=${r}g=${g}b=${b}`);

        setR(r.toString());
        setG(g.toString());
        setB(b.toString());

        return [r, g, b];
    }

    function convertRGBToRest(r, g, b) {
        //h,s,v
        r = r / 255;
        g = g / 255;
        b = b / 255;

        var Cmax = Math.max(r, g, b);
        var Cmin = Math.min(r, g, b);
        var delta = Cmax - Cmin;

        var h, s, v;

        //h
        if (delta === 0) {
            h = 0;
        }
        else if (Cmax === r) {
            h = 60 * (((g - b) / delta) % 6) * 100;
        }
        else if (Cmax === g) {
            h = 60 * ((b - r) / delta + 2) * 100;
        }
        else if (Cmax === b) {
            h = 60 * ((r - g) / delta + 4) * 100;
        }

        //s
        if (Cmax === 0) {
            s = 0
        }
        else {
            s = delta / Cmax * 100;
        }

        v = Cmax * 100;

        setH(h.toString() + '°');
        setS(s.toString() + '%');
        setV(v.toString() + '%');

        console.log(`h=${h}s=${s}v=${v}`);

        //c,m,y,k
        const k = (+(1 - Math.max(r, g, b)).toFixed(1)) * 100;
        const c = (+((1 - r - k) / (1 - k) || 0).toFixed(1)) * 100;
        const m = (+((1 - g - k) / (1 - k) || 0).toFixed(1)) * 100;
        const y = (+((1 - b - k) / (1 - k) || 0).toFixed(1)) * 100;

        setC(c.toString() + '%');
        setM(m.toString() + '%');
        setY(y.toString() + '%');
        setK(k.toString() + '%');

        console.log(`c=${c}m=${m}y=${y}k=${k}`);
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
                onChangeText={r => setR(r)}
            />
            <TextInput style={styles.input}
                label="G"
                value={g}
                defaultValue="0"
                keyboardType="numeric"
                maxLength={3}
                onChangeText={g => setG(g)}
            />
            <TextInput style={styles.input}
                label="B"
                value={b}
                defaultValue="0"
                keyboardType="numeric"
                maxLength={3}
                onChangeText={b => setB(b)}
            />
        </View>

        <View style={styles.container}>
            <TextInput style={styles.input}
                label="H"
                value={h}
                defaultValue="0.00°"
                keyboardType="numeric"
                onChangeText={h => handlePercentChange(h, 'h')}
            />
            <TextInput style={styles.input}
                label="S"
                value={s}
                defaultValue="0.00%"
                keyboardType="numeric"
                onChangeText={s => handlePercentChange(s, 's')}
            />
            <TextInput style={styles.input}
                label="V"
                value={v}
                defaultValue="0.00%"
                keyboardType="numeric"
                onChangeText={v => handlePercentChange(v, 'v')}
            />
        </View>

        <View style={styles.container}>
            <TextInput style={styles.input}
                label="C"
                value={c}
                defaultValue="0.00%"
                keyboardType="numeric"
                onChangeText={c => handlePercentChange(c, 'c')}
            />
            <TextInput style={styles.input}
                label="M"
                value={m}
                defaultValue="0.00%"
                keyboardType="numeric"
                onChangeText={m => handlePercentChange(m, 'm')}
            />
            <TextInput style={styles.input}
                label="Y"
                value={y}
                defaultValue="0.00%"
                keyboardType="numeric"
                onChangeText={y => handlePercentChange(y, 'y')}
            />
            <TextInput style={styles.input}
                label="K"
                value={k}
                defaultValue="0.00%"
                keyboardType="numeric"
                onChangeText={k => handlePercentChange(k, 'k')}
            />
        </View>

        <TextInput style={styles.input}
            label="Hex"
            value={hex}
            defaultValue="#000000"
            maxLength={7}
            onChangeText={handleHexChange}
        />
    </>)
}

const styles = StyleSheet.create({
    container: {
        flexDirection: 'row',
    },

    input: {
        flex: 1
    },

    square: {
        width: 100,
        height: 100
    }
})
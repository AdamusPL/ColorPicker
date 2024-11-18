import { useEffect, useState } from "react";
import { StyleSheet, View } from "react-native"
import { TextInput } from "react-native-paper"
import { convertHexToRGB, convertHSVToRGB, convertRGBToCMYK, convertRGBToHex, convertRGBToHSV, convertCMYKToRGB } from "../pages/Calculator";
import { useColor } from "./ColorProvider";

export default function TextFields({ isReadOnly }) {
    const { selectedColor, setSelectedColor } = useColor();

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
    }, []);

    useEffect(() => {
        if (isReadOnly) {
            handleChange();
        }
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

    function handleRGBChange(input, label) {
        let hsv = {};
        let cmyk = {};
        let hex = "";

        switch (label) {
            case 'r':
                hsv = convertRGBToHSV(input, g, b);
                cmyk = convertRGBToCMYK(input, g, b);
                hex = convertRGBToHex(input, g, b);
                setSelectedColor(`rgb(${input}, ${g}, ${b})`);
                setR(input);
                break;
            case 'g':
                hsv = convertRGBToHSV(r, input, b);
                cmyk = convertRGBToCMYK(r, input, b);
                hex = convertRGBToHex(r, input, b);
                setSelectedColor(`rgb(${r}, ${input}, ${b})`);
                setG(input);
                break;
            case 'b':
                hsv = convertRGBToHSV(r, g, input);
                cmyk = convertRGBToCMYK(r, g, input);
                hex = convertRGBToHex(r, g, input);
                setSelectedColor(`rgb(${r}, ${g}, ${input})`);
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
                setH(input);
                break;
            case 's':
                rgb = convertHSVToRGB(h, input, v);
                setS(input);
                break;
            case 'v':
                rgb = convertHSVToRGB(h, s, input);
                setV(input);
                break;
        }

        cmyk = convertRGBToCMYK(rgb.r, rgb.g, rgb.b);
        hex = convertRGBToHex(rgb.r, rgb.g, rgb.b);

        setR(rgb.r);
        setG(rgb.g);
        setB(rgb.b);

        setC(cmyk.c);
        setM(cmyk.m);
        setY(cmyk.y);
        setK(cmyk.k);

        setHex(hex);

        setSelectedColor(`rgb(${rgb.r}, ${rgb.g}, ${rgb.b})`);
    }

    function handleCMYKChange(input, label) {
        let rgb = {};
        let hsv = {};
        let hex = "";

        switch (label) {
            case 'c':
                rgb = convertCMYKToRGB(input, m, y, k);
                setC(input);
                break;
            case 'm':
                rgb = convertCMYKToRGB(c, input, y, k);
                setM(input);
                break;
            case 'y':
                rgb = convertCMYKToRGB(c, m, input, k);
                setY(input);
                break;
            case 'k':
                rgb = convertCMYKToRGB(c, m, y, input);
                setK(input);
                break;
        }

        hsv = convertRGBToHSV(rgb.r, rgb.g, rgb.b);
        hex = convertRGBToHex(rgb.r, rgb.g, rgb.b);

        setR(rgb.r);
        setG(rgb.g);
        setB(rgb.b);

        setH(hsv.h);
        setS(hsv.s);
        setV(hsv.v);

        setHex(hex);

        setSelectedColor(`rgb(${rgb.r}, ${rgb.g}, ${rgb.b})`);
    }

    function handleHexChange(input) {
        const rgb = convertHexToRGB(input);
        const hsv = convertRGBToHSV(rgb.r, rgb.g, rgb.b);
        const cmyk = convertRGBToCMYK(rgb.r, rgb.g, rgb.b);
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

        setSelectedColor(`rgb(${rgb.r}, ${rgb.g}, ${rgb.b})`);
    }

    return (
        <View style={styles.fields}>
            <View style={styles.container}>
                <TextInput style={styles.input}
                    label="R"
                    value={r}
                    readOnly={isReadOnly}
                    maxLength={3}
                    onChangeText={x => !isReadOnly ? handleRGBChange(x, 'r') : null}
                />
                <TextInput style={styles.input}
                    label="G"
                    value={g}
                    readOnly={isReadOnly}
                    maxLength={3}
                    onChangeText={x => !isReadOnly ? handleRGBChange(x, 'g') : null}
                />
                <TextInput style={styles.input}
                    label="B"
                    value={b}
                    readOnly={isReadOnly}
                    maxLength={3}
                    onChangeText={x => !isReadOnly ? handleRGBChange(x, 'b') : null}
                />
            </View>

            <View style={styles.container}>
                <TextInput style={styles.input}
                    label="H"
                    value={h}
                    readOnly={isReadOnly}
                    maxLength={3}
                    onChangeText={x => !isReadOnly ? handleHSVChange(x, 'h') : null}
                    right={<TextInput.Affix text="°" />}
                />
                <TextInput style={styles.input}
                    label="S"
                    value={s}
                    readOnly={isReadOnly}
                    maxLength={3}
                    onChangeText={x => !isReadOnly ? handleHSVChange(x, 's') : null}
                    right={<TextInput.Affix text="%" />}
                />
                <TextInput style={styles.input}
                    label="V"
                    value={v}
                    readOnly={isReadOnly}
                    maxLength={3}
                    onChangeText={x => !isReadOnly ? handleHSVChange(x, 'v') : null}
                    right={<TextInput.Affix text="%" />}
                />
            </View>

            <View style={styles.container}>
                <TextInput style={styles.input}
                    label="C"
                    value={c}
                    readOnly={isReadOnly}
                    maxLength={3}
                    onChangeText={x => !isReadOnly ? handleCMYKChange(x, 'c') : null}
                    right={<TextInput.Affix text="%" />}
                />
                <TextInput style={styles.input}
                    label="M"
                    value={m}
                    readOnly={isReadOnly}
                    maxLength={3}
                    onChangeText={x => !isReadOnly ? handleCMYKChange(x, 'm') : null}
                    right={<TextInput.Affix text="%" />}
                />
                <TextInput style={styles.input}
                    label="Y"
                    value={y}
                    readOnly={isReadOnly}
                    maxLength={3}
                    onChangeText={x => !isReadOnly ? handleCMYKChange(x, 'y') : null}
                    right={<TextInput.Affix text="%" />}
                />
                <TextInput style={styles.input}
                    label="K"
                    value={k}
                    readOnly={isReadOnly}
                    maxLength={3}
                    onChangeText={x => !isReadOnly ? handleCMYKChange(x, 'k') : null}
                    right={<TextInput.Affix text="%" />}
                />
            </View>

            <View style={styles.container}>
                <TextInput style={styles.input}
                    label="Hex"
                    value={hex}
                    readOnly={isReadOnly}
                    maxLength={6}
                    onChangeText={x => !isReadOnly ? handleHexChange(x) : null}
                    left={<TextInput.Affix text="#" />}
                />
            </View>
        </View>)
}

const styles = StyleSheet.create({
    container: {
        flexDirection: 'row',
        marginTop: 5
    },

    input: {
        flex: 1,
        marginHorizontal: 5
    },

    fields: {
        marginLeft: 5,
        marginRight: 5
    },
})
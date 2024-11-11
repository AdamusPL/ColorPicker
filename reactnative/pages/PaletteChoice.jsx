import { StyleSheet, TouchableOpacity, View } from "react-native";
import { TextInput, Text } from 'react-native-paper';
import React, { useEffect, useRef } from "react";
import { useState } from "react";
import { convertRGBToCMYK, convertRGBToHex, convertRGBToHSV } from "./Calculator";
import { KeyboardAwareScrollView } from "react-native-keyboard-aware-scroll-view";
import Canvas, { Image as CanvasImage } from 'react-native-canvas';
import data from './color-palette.json'

export default function PaletteChoice() {
    const canvasRef = useRef(null);
    const [isCanvasRendered, setIsCanvasRendered] = useState(false);
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
        if (canvasRef.current && !isCanvasRendered) {
            setIsCanvasRendered(true);
            const ctx = canvasRef.current.getContext('2d');
            let img = new CanvasImage(canvasRef.current);
            img.src = data.COLOR_PALETTE;

            img.addEventListener('load', () => {
                ctx.drawImage(img, 0, 0, 200, 200);
            });
        }
    }, [canvasRef, isCanvasRendered]);

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

    function handleClick(e) {
        if (!canvasRef.current) {
            return;
        }
        const point = {
            x: parseInt(e.nativeEvent.locationX),
            y: parseInt(e.nativeEvent.locationY)
        };

        getColorAtPixel(canvasRef.current, point.x, point.y);
        drawCircle(canvasRef.current, point.x, point.y);
    }

    async function drawCircle(canvas, locationX, locationY) {
        const ctx = canvas.getContext('2d');
        ctx.clearRect(0, 0, canvas.width, canvas.height);

        let img = new CanvasImage(canvasRef.current);
        img.src = data.COLOR_PALETTE;

        img.addEventListener('load', () => {
            ctx.drawImage(img, 0, 0, 200, 200);

            ctx.beginPath();
            ctx.arc(locationX, locationY, 7, 0, 2 * Math.PI);
            ctx.strokeStyle = 'black';
            ctx.stroke();

            ctx.beginPath();
            ctx.arc(locationX, locationY - 5, 50, 0, 2 * Math.PI);
            ctx.strokeStyle = 'rgba(0, 0, 0, 0)';
            ctx.lineWidth = 2;
            ctx.stroke();
        });
    }

    async function getColorAtPixel(canvas, locationX, locationY) {
        const ctx = canvas.getContext('2d');
        const imageData = await ctx.getImageData(locationX, locationY, 1, 1);

        const colors = imageData.data;
        console.log(colors);
        setSelectedColor(`rgb(${colors[0]}, ${colors[1]}, ${colors[2]})`);
    };


    return (<>
        <KeyboardAwareScrollView>
            <View style={styles.body}>
                <Text style={styles.title} variant="titleLarge">Color picker</Text>
                <View style={styles.centeredPalette}>
                    <TouchableOpacity style={styles.centeredSquare} onPress={(e) => handleClick(e)}>
                        <Canvas ref={canvasRef} style={styles.canvas} />
                    </TouchableOpacity>
                </View>
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
    },

    palette: {
        marginTop: 30
    },

    canvas: {
        width: 200,
        height: 200
    }
})
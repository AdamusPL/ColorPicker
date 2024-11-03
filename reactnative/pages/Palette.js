import React from 'react';
import { TouchableOpacity, View } from 'react-native';
import { convertHSVToRGB, convertRGBToHSV } from './Calculator';

function range(label, direction, offset, r, g, b, i, row, width, onColorSelect) {
    const step = direction ? offset : -offset;
    let x = direction ? 0 : 255;
    while (direction ? x < 255 : x > 0) {
        //make lower saturation (S from HSV)
        const hsv = convertRGBToHSV(r, g, b);
        hsv.s *= (1 - 0.02 * i);
        const rgb = convertHSVToRGB(hsv.h, hsv.s, hsv.v);

        const color = `rgb(${rgb.r}, ${rgb.g}, ${rgb.b})`;

        row.push(
            <TouchableOpacity
                onPress={() => onColorSelect(color)}>
                <View
                    // key={`${rgb.r}-${rgb.g}-${rgb.b}`}
                    style={{
                        backgroundColor: color,
                        width: width,
                        height: width,
                        display: 'inline-block',
                    }}
                />
            </TouchableOpacity>
        );

        switch (label) {
            case 'r':
                r = x;
                break;
            case 'g':
                g = x;
                break;
            case 'b':
                b = x;
                break;
        }

        x += step;
    }
}

const Palette = ({ onColorSelect }) => {
    const palette = [];

    const width = 2;
    const offset = 10;

    for (let i = 0; i < 50; i++) {
        const row = [];

        //first row
        //1
        //start: (255, 0, 0), end: (255, 254, 0)
        range('g', true, offset, 255, 0, 0, i, row, width, onColorSelect);

        //2
        //start: (255, 255, 0), end: (1, 255, 0)
        range('r', false, offset, 255, 255, 0, i, row, width, onColorSelect);

        //3
        //start: (0, 255, 0), end: (0, 255, 254)
        range('b', true, offset, 0, 255, 0, i, row, width, onColorSelect);

        //4
        //start: (0, 255, 255), end: (0, 1, 255)
        range('g', false, offset, 0, 255, 255, i, row, width, onColorSelect);

        //5
        //start: (0, 0, 255), end: (254, 0, 255)
        range('r', true, offset, 0, 0, 255, i, row, width.onColorSelect);

        //6
        //start: (255, 0, 255), end: (254, 0, 0)
        range('b', false, offset, 255, 0, 255, i, row, width, onColorSelect);

        palette.push(
            <View key={`row-${i}`} style={{ flexDirection: 'row' }}>
                {row}
            </View>
        );
    }

    return (<View style={{ flex: 1, alignItems: 'center', justifyContent: 'center' }}>
        <View style={{ flexDirection: 'column', alignItems: 'center' }}>
            {palette}
        </View>
    </View>);

}

export default Palette;
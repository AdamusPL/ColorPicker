import React from 'react';
import { View } from 'react-native';

const Palette = () => {
    const palette = [];

    const width = 1;
    const offset = 5;

    let r = 255, g = 0, b = 0;

    let color;

    for (let i = 0; i < 50; i++) {
        r = 255, g = 0, b = 0;
        const row = [];

        //first row
        //1
        //start: (255, 0, 0), end: (255, 254, 0)
        while (g < 255) {
            color = `rgb(${r}, ${g}, ${x})`;
            row.push(
                <View
                    key={`${r}-${g}-${x}`}
                    style={{
                        backgroundColor: color,
                        width: width,
                        height: width,
                        display: 'inline-block',
                    }}
                />
            );
            g += offset;
        }

        

        //2
        //start: (255, 255, 0), end: (1, 255, 0)
        while (r > 0) {
            color = `rgb(${r}, ${g}, ${x})`;
            row.push(
                <View
                    key={`${r}-${g}-${x}`}
                    style={{
                        backgroundColor: color,
                        width: width,
                        height: width,
                        display: 'inline-block',
                    }}
                />
            );
            r -= offset;
        }

        //3
        //start: (0, 255, 0), end: (0, 255, 254)
        while (b < 255) {
            color = `rgb(${x}, ${g}, ${b})`;
            row.push(
                <View
                    key={`${x}-${g}-${b}`}
                    style={{
                        backgroundColor: color,
                        width: width,
                        height: width,
                        display: 'inline-block',
                    }}
                />
            );
            b += offset;
        }

        //4
        //start: (0, 255, 255), end: (0, 1, 255)
        while (g > 0) {
            color = `rgb(${x}, ${g}, ${b})`;
            row.push(
                <View
                    key={`${x}-${g}-${b}`}
                    style={{
                        backgroundColor: color,
                        width: width,
                        height: width,
                        display: 'inline-block',
                    }}
                />
            );
            g -= offset;
        }

        //5
        //start: (0, 0, 255), end: (254, 0, 255)
        while (r < 255) {
            color = `rgb(${r}, ${x}, ${b})`;
            row.push(
                <View
                    key={`${r}-${x}-${b}`}
                    style={{
                        backgroundColor: color,
                        width: width,
                        height: width,
                        display: 'inline-block',
                    }}
                />
            );
            r += offset;
        }

        //6
        //start: (255, 0, 255), end: (254, 0, 0)
        while (b > 0) {
            color = `rgb(${r}, ${x}, ${b})`;
            row.push(
                <View
                    key={`${r}-${x}-${b}`}
                    style={{
                        backgroundColor: color,
                        width: width,
                        height: width,
                        display: 'inline-block',
                    }}
                />
            );
            b -= offset;
        }

        palette.push(
            <View key={`row-${i}`} style={{ flexDirection: 'row' }}>
                {row}
            </View>
        );
    }

    return <View style={{ flexDirection: 'column' }}>{palette}</View>;

}

export default Palette;
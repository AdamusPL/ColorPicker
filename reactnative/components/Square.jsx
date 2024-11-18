import { StyleSheet, View } from "react-native";
import { useColor } from "./ColorProvider";

const Square = ({ width, height }) => {
    const { selectedColor } = useColor();

    return (<>
        <View style={[styles.square, { backgroundColor: selectedColor, width: width, height: height }]}></View>
    </>)
}

const styles = StyleSheet.create({
    square: {
        marginTop: 30,
        marginBottom: 15
    }
})

export default Square;
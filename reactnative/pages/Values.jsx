import { StyleSheet, View } from "react-native";
import { Text } from 'react-native-paper';
import React from "react";
import { KeyboardAwareScrollView } from "react-native-keyboard-aware-scroll-view";
import Square from "../components/Square";
import TextFields from "../components/TextFields";

export default function Values() {
    return (<>
        <KeyboardAwareScrollView>
            <View style={styles.body}>
                <Text style={styles.title} variant="titleLarge">Color picker</Text>
                <Square width={375} height={375} />
            </View>

            <TextFields isReadOnly={false} />
        </KeyboardAwareScrollView>
    </>)
}

const styles = StyleSheet.create({
    body: {
        marginLeft: 15,
        marginRight: 15
    },

    title: {
        marginTop: 20,
    },

    container: {
        flexDirection: 'row',
        marginTop: 5
    },

    input: {
        flex: 1,
        marginHorizontal: 5
    },
})
package com.example.myapplication.ui.components

import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.material3.Text
import androidx.compose.material3.TextField
import androidx.compose.runtime.Composable

import androidx.compose.runtime.snapshots.SnapshotStateList
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp
import com.example.myapplication.MainViewModel

@Composable
fun TextFieldRow(
    values: SnapshotStateList<String>,
    labels: List<String> = emptyList(),
    viewModel: MainViewModel,
    readOnly: Boolean = true,
    getPrefix: (String) -> String = { "" },
    getSuffix: (String) -> String = { "" },
    isValidInput: (String, String) -> Boolean = { _, _ -> true }) {
    Row(modifier = Modifier.fillMaxWidth()) {
        values.forEachIndexed { index, value ->
            val label = labels.getOrNull(index) ?: "TextField ${index + 1}"
            TextField(
                value = value,
                onValueChange = { newValue ->
                    if (isValidInput(label, newValue)) {
                        values[index] = newValue
                        viewModel.updateColor(labels.joinToString(""))
                    }
                },
                label = { Text(getLabel(labels, index)) },
                modifier = Modifier
                    .weight(1f)
                    .padding(4.dp),
                singleLine = true,
                suffix = { Text(getSuffix(label)) },
                prefix = { Text(getPrefix(label)) },
                readOnly = readOnly
            )
        }
    }
}

@Composable
fun getLabel(labels: List<String>, index: Int): String {
    return labels.getOrNull(index) ?: "TextField ${index + 1}"
}
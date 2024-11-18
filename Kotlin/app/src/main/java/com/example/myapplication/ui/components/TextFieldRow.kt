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
    readOnly: Boolean = true
) {
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

fun isValidInput(label: String, input: String): Boolean {
    return when (label) {
        "R", "G", "B" -> {
            input.isBlank() || (input.toIntOrNull()
                ?.let { it in 0..255 } == true && input.length in 0..3)
        }

        "H" -> {
            input.isBlank() || (input.toDoubleOrNull()
                ?.let { it in 0.0..360.0 } == true && input.length in 0..5)
        }

        "S", "V", "C", "M", "Y", "K" -> {
            input.isBlank() || (input.toDoubleOrNull()
                ?.let { it in 0.0..100.0 } == true && input.length in 0..5)
        }

        "HEX" -> {
            input.matches(Regex("^[A-Fa-f0-9]{0,6}$"))
        }

        else -> {
            true
        }
    }
}

@Composable
fun getLabel(labels: List<String>, index: Int): String {
    return labels.getOrNull(index) ?: "TextField ${index + 1}"
}

@Composable
fun getPrefix(label: String): String {
    return when (label) {
        "HEX" -> "#"
        else -> ""
    }
}

@Composable
fun getSuffix(label: String): String {
    return when (label) {
        "H" -> "°"
        "S", "V", "C", "M", "Y", "K" -> "%"
        else -> ""
    }
}
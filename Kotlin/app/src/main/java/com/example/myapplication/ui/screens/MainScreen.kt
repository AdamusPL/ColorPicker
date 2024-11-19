package com.example.myapplication.ui.screens

import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.PaddingValues
import androidx.compose.foundation.layout.padding
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import com.example.myapplication.MainViewModel
import com.example.myapplication.ui.components.Square
import com.example.myapplication.ui.components.TextFieldRow

@Composable
fun FirstScreen(viewModel: MainViewModel, innerPadding: PaddingValues) {
    Column(modifier = Modifier.padding(innerPadding)) {
        Square(viewModel)
        TextFieldRow(
            viewModel.rgbFieldValues,
            listOf("R", "G", "B"),
            viewModel,
            false,
            isValidInput = { _, input ->
                input.isBlank() || (input.toIntOrNull()
                    ?.let { it in 0..255 } == true && input.length in 0..3)
            }

        )
        TextFieldRow(
            viewModel.hsvFieldValues,
            listOf("H", "S", "V"),
            viewModel,
            false,
            getSuffix = { if (it == "H") "°" else "%" },
            isValidInput = { label, input ->
                when (label) {
                    "H" -> {
                        input.isBlank() || (input.toDoubleOrNull()
                            ?.let { it in 0.0..360.0 } == true && input.length in 0..6)
                    }

                    "S", "V" -> {
                        input.isBlank() || (input.toDoubleOrNull()
                            ?.let { it in 0.0..100.0 } == true && input.length in 0..6)
                    }
                    else -> true
                }
            }

        )
        TextFieldRow(
            viewModel.cmykFieldValues,
            listOf("C", "M", "Y", "K"),
            viewModel,
            false,
            getSuffix = { "%" },
            isValidInput = { _, input ->
                input.isBlank() || (input.toIntOrNull()
                    ?.let { it in 0..100 } == true && input.length in 0..3)
            }
        )
        TextFieldRow(
            viewModel.hexFieldValues,
            listOf("HEX"),
            viewModel,
            false,
            getPrefix = { "#" },
            isValidInput = { _, input ->
                input.matches(Regex("^[A-Fa-f0-9]{0,6}$"))
            }
        )
    }
}
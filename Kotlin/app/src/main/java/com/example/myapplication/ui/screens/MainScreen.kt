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
            false
        )
        TextFieldRow(
            viewModel.hsvFieldValues,
            listOf("H", "S", "V"),
            viewModel,
            false,
            getSuffix = { if (it == "H") "°" else "%" }
        )
        TextFieldRow(
            viewModel.cmykFieldValues,
            listOf("C", "M", "Y", "K"),
            viewModel,
            false,
            getSuffix = { "%" }
        )
        TextFieldRow(
            viewModel.hexFieldValues,
            listOf("HEX"),
            viewModel,
            false,
            getPrefix = { "#" }
        )
    }
}
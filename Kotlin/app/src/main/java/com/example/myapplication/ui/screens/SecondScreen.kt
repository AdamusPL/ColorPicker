package com.example.myapplication.ui.screens

import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.PaddingValues
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp
import com.example.myapplication.MainViewModel
import com.example.myapplication.ui.components.ColorWheel
import com.example.myapplication.ui.components.Square
import com.example.myapplication.ui.components.TextFieldRow

@Composable
fun SecondScreen(viewModel: MainViewModel, innerPadding: PaddingValues) {
    Column(
        modifier = Modifier
            .padding(innerPadding)
            .fillMaxSize()
    ) {
        Box(
            modifier = Modifier
                .weight(1f)
                .fillMaxWidth(),
            contentAlignment = Alignment.Center

        ) {
            ColorWheel(viewModel)
        }
        Box(
            modifier = Modifier
                .fillMaxWidth(),
            contentAlignment = Alignment.Center
        ) {
            Box(
                modifier = Modifier.size(100.dp),
                contentAlignment = Alignment.Center
            ) {
                Square(viewModel)
            }
        }
        TextFieldRow(
            viewModel.rgbFieldValues,
            listOf("R", "G", "B"),
            viewModel,
            true
        )
        TextFieldRow(
            viewModel.hsvFieldValues,
            listOf("H", "S", "V"),
            viewModel,
            true,
            getSuffix = { if (it == "H") "°" else "%" }
        )
        TextFieldRow(
            viewModel.cmykFieldValues,
            listOf("C", "M", "Y", "K"),
            viewModel,
            true,
            getSuffix = { "%" }
        )
        TextFieldRow(
            viewModel.hexFieldValues,
            listOf("HEX"),
            viewModel,
            true,
            getPrefix = { "#" }
        )
    }
}
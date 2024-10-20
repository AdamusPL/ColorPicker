package com.example.myapplication.ui.components

import androidx.compose.foundation.layout.aspectRatio
import androidx.compose.foundation.layout.padding
import androidx.compose.material3.Card
import androidx.compose.material3.CardDefaults
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.RectangleShape
import androidx.compose.ui.unit.dp
import com.example.myapplication.MainViewModel

@Composable
fun Square(viewModel: MainViewModel) {
    val hex = viewModel.hexFieldValues[0]
    val r = hex.substring(1, 3).toInt(16)
    val g = hex.substring(3, 5).toInt(16)
    val b = hex.substring(5, 7).toInt(16)
    val alpha = 0xFF
    Card (
        modifier = Modifier
            .aspectRatio(1f)
            .padding(16.dp),
        colors = CardDefaults.cardColors(containerColor = Color(r, g, b, alpha)),
        shape = RectangleShape
    ) {}
}
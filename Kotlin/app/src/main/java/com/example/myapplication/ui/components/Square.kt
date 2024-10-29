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
    val r = if (hex.length >= 2) hex.substring(0, 2).toInt(16) else 0
    val g = if (hex.length >= 4) hex.substring(2, 4).toInt(16) else 0
    val b = if (hex.length >= 6) hex.substring(4, 6).toInt(16) else 0
    val alpha = 0xFF
    Card (
        modifier = Modifier
            .aspectRatio(1f)
            .padding(16.dp),
        colors = CardDefaults.cardColors(containerColor = Color(r, g, b, alpha)),
        shape = RectangleShape
    ) {}
}
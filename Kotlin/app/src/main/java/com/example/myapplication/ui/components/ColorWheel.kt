package com.example.myapplication.ui.components

import android.graphics.BitmapFactory
import androidx.compose.foundation.Canvas
import androidx.compose.foundation.Image
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.aspectRatio
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.padding
import androidx.compose.material3.Card
import androidx.compose.material3.CardDefaults
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.geometry.Offset
import android.graphics.Color as AndroidColor
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.drawscope.Stroke
import androidx.compose.ui.graphics.painter.Painter
import androidx.compose.ui.input.pointer.pointerInput
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.unit.IntSize
import androidx.compose.ui.unit.dp
import com.example.myapplication.MainViewModel
import com.example.myapplication.R
import kotlin.math.pow
import kotlin.math.sqrt

@Composable
fun ColorWheel(viewModel: MainViewModel) {
    val hex = "FDF7FE"
    val r = hex.substring(0, 2).toInt(16)
    val g = hex.substring(2, 4).toInt(16)
    val b = hex.substring(4, 6).toInt(16)
    val alpha = 0xFF
    val painter: Painter = painterResource(id = R.drawable.color_wheel)
    val context = LocalContext.current
    val bitmap = remember { BitmapFactory.decodeResource(context.resources, R.drawable.color_wheel) }
    var lastTouchPosition by remember { mutableStateOf(Offset.Zero) }

    Card (
        modifier = Modifier
            .aspectRatio(1f)
            .padding(16.dp),
        colors = CardDefaults.cardColors(containerColor = Color(r, g, b, alpha)),
    ) {
        Box(
            contentAlignment = Alignment.Center,
            modifier = Modifier.fillMaxSize() // Ensures Box takes up full space
        ) {
            Image(
                painter = painter,
                contentDescription = "Color Wheel",
                modifier = Modifier.aspectRatio(1f)
                    .pointerInput(Unit) {
                        awaitPointerEventScope {
                            while (true) {
                                val event = awaitPointerEvent()
                                val offset = event.changes.first().position
                                lastTouchPosition = handleTouch(offset, size, bitmap, viewModel, lastTouchPosition)
                                println("Last touch position: $lastTouchPosition")
                            }
                        }
                    }
            )

            if(lastTouchPosition != Offset.Zero) {
                lastTouchPosition.let { position ->
                    Canvas(modifier = Modifier.fillMaxSize()) {
                        val outerRadius = 20f // Customize outer radius as needed
                        val ringThickness = 4f // Customize ring thickness as needed

                        // Draw the ring (outer circle)
                        drawCircle(
                            color = Color.Black, // Customize ring color as needed
                            radius = outerRadius,
                            center = position,
                            style = Stroke(width = ringThickness)
                        )
                    }
                }
            }

        }
    }
}

private fun handleTouch(offset: Offset, size: IntSize, bitmap: android.graphics.Bitmap, viewModel: MainViewModel, lastTouchPosition: Offset): Offset {
    val imageWidth = size.width.toFloat()
    val imageHeight = size.height.toFloat()
    val centerX = imageWidth / 2
    val centerY = imageHeight / 2
    val radius = imageWidth / 2

    val localOffset = offset - Offset(
        (size.width - imageWidth) / 2,
        (size.height - imageHeight) / 2
    )

    val distanceFromCenter = sqrt((localOffset.x - centerX).pow(2) + (localOffset.y - centerY).pow(2))

    if (distanceFromCenter <= radius) {
        val mappedX = (localOffset.x / imageWidth * bitmap.width).toInt()
        val mappedY = (localOffset.y / imageHeight * bitmap.height).toInt()

        if (mappedX in 0 until bitmap.width && mappedY in 0 until bitmap.height) {
            val pixel = bitmap.getPixel(mappedX, mappedY)
            val r = AndroidColor.red(pixel)
            val g = AndroidColor.green(pixel)
            val b = AndroidColor.blue(pixel)
            viewModel.updateRGBValues(r, g, b)

            return localOffset
        }
    }
    return lastTouchPosition
}


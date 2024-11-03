package com.example.myapplication

import androidx.compose.runtime.mutableStateListOf
import androidx.compose.runtime.snapshots.SnapshotStateList
import androidx.lifecycle.ViewModel
import com.example.myapplication.utils.ColorConverter

class MainViewModel : ViewModel() {
    val rgbFieldValues: SnapshotStateList<String> = mutableStateListOf("0", "0", "0")
    val hsvFieldValues: SnapshotStateList<String> = mutableStateListOf("0", "0", "0")
    val cmykFieldValues: SnapshotStateList<String> = mutableStateListOf("0", "0", "0", "100")
    val hexFieldValues: SnapshotStateList<String> = mutableStateListOf("000000")

    fun updateRGBValues(r: Int, g: Int, b: Int) {
        rgbFieldValues[0] = r.toString()
        rgbFieldValues[1] = g.toString()
        rgbFieldValues[2] = b.toString()
        updateColor("RGB")
    }

    fun updateColor(hasChanged : String) {
        when (hasChanged) {
            "RGB" -> {
                val r = rgbFieldValues[0].toIntOrNull() ?: 0
                val g = rgbFieldValues[1].toIntOrNull() ?: 0
                val b = rgbFieldValues[2].toIntOrNull() ?: 0
                val hsv = ColorConverter.rgbToHsv(r, g, b)
                val cmyk = ColorConverter.rgbToCmyk(r, g, b)
                val hex = ColorConverter.rgbToHex(r, g, b)
                hsvFieldValues[0] = hsv[0]
                hsvFieldValues[1] = hsv[1]
                hsvFieldValues[2] = hsv[2]
                cmykFieldValues[0] = cmyk[0]
                cmykFieldValues[1] = cmyk[1]
                cmykFieldValues[2] = cmyk[2]
                cmykFieldValues[3] = cmyk[3]
                hexFieldValues[0] = hex
            }
            "HSV" -> {
                val h = hsvFieldValues[0].toDoubleOrNull() ?: 0.0
                val s = hsvFieldValues[1].toDoubleOrNull() ?: 0.0
                val v = hsvFieldValues[2].toDoubleOrNull() ?: 0.0
                val rgb = ColorConverter.hsvToRgb(h, s, v)
                val cmyk = ColorConverter.rgbToCmyk(rgb[0], rgb[1], rgb[2])
                val hex = ColorConverter.rgbToHex(rgb[0], rgb[1], rgb[2])
                rgbFieldValues[0] = "${rgb[0]}"
                rgbFieldValues[1] = "${rgb[1]}"
                rgbFieldValues[2] = "${rgb[2]}"
                cmykFieldValues[0] = cmyk[0]
                cmykFieldValues[1] = cmyk[1]
                cmykFieldValues[2] = cmyk[2]
                cmykFieldValues[3] = cmyk[3]
                hexFieldValues[0] = hex
            }
            "CMYK" -> {
                val c = cmykFieldValues[0].toIntOrNull() ?: 0
                val m = cmykFieldValues[1].toIntOrNull() ?: 0
                val y = cmykFieldValues[2].toIntOrNull() ?: 0
                val k = cmykFieldValues[3].toIntOrNull() ?: 0
                val rgb = ColorConverter.cmykToRgb(c, m, y, k)
                val hsv = ColorConverter.rgbToHsv(rgb[0], rgb[1], rgb[2])
                val hex = ColorConverter.rgbToHex(rgb[0], rgb[1], rgb[2])
                rgbFieldValues[0] = "${rgb[0]}"
                rgbFieldValues[1] = "${rgb[1]}"
                rgbFieldValues[2] = "${rgb[2]}"
                hsvFieldValues[0] = hsv[0]
                hsvFieldValues[1] = hsv[1]
                hsvFieldValues[2] = hsv[2]
                hexFieldValues[0] = hex
            }
            "HEX" -> {
                val hex = hexFieldValues[0]
                val r = if (hex.length >= 2) hex.substring(0, 2).toIntOrNull(16) ?: 0 else 0
                val g = if (hex.length >= 4) hex.substring(2, 4).toIntOrNull(16) ?: 0 else 0
                val b = if (hex.length >= 6) hex.substring(4, 6).toIntOrNull(16) ?: 0 else 0
                val hsv = ColorConverter.rgbToHsv(r, g, b)
                val cmyk = ColorConverter.rgbToCmyk(r, g, b)
                rgbFieldValues[0] = "$r"
                rgbFieldValues[1] = "$g"
                rgbFieldValues[2] = "$b"
                hsvFieldValues[0] = hsv[0]
                hsvFieldValues[1] = hsv[1]
                hsvFieldValues[2] = hsv[2]
                cmykFieldValues[0] = cmyk[0]
                cmykFieldValues[1] = cmyk[1]
                cmykFieldValues[2] = cmyk[2]
                cmykFieldValues[3] = cmyk[3]
            }
        }
    }
}
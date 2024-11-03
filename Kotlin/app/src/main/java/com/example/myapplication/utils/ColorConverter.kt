package com.example.myapplication.utils

import android.annotation.SuppressLint
import kotlin.math.abs
import kotlin.math.max
import kotlin.math.min
import kotlin.math.round

@SuppressLint("DefaultLocale")
class ColorConverter {
    companion object {
        fun rgbToHsv(r: Int, g: Int, b: Int): List<String> {
            val rp = r / 255.0
            val gp = g / 255.0
            val bp = b / 255.0
            val cmax = max(rp, max(gp, bp))
            val cmin = min(rp, min(gp, bp))
            val delta = cmax - cmin
            var h = 0.0
            if (delta == 0.0) {
                h = 0.0
            } else if (cmax == rp) {
                h = 60.0 * (((gp - bp) / delta) % 6.0)
            } else if (cmax == gp) {
                h = 60.0 * (((bp - rp) / delta) + 2.0)
            } else if (cmax == bp) {
                h = 60.0 * (((rp - gp) / delta) + 4.0)
            }
            var s = if (cmax == 0.0) 0 else delta / cmax
            s = s.toDouble()
            return listOf(
                String.format("%.2f", h),
                String.format("%.2f", s * 100),
                String.format("%.2f", cmax * 100)
            )
        }


        fun rgbToCmyk(r: Int, g: Int, b: Int): List<String> {
            val rp = r / 255.0
            val gp = g / 255.0
            val bp = b / 255.0
            val k = 1 - max(rp, max(gp, bp))
            if (k == 1.0) {
                return listOf("0", "0", "0", "100")
            }
            val c = (1 - rp - k) / (1 - k)
            val m = (1 - gp - k) / (1 - k)
            val y = (1 - bp - k) / (1 - k)
            return listOf(
                String.format("%.2f", c * 100).removeTrailingZeros(),
                String.format("%.2f", m * 100).removeTrailingZeros(),
                String.format("%.2f", y * 100).removeTrailingZeros(),
                String.format("%.2f", k * 100).removeTrailingZeros()
            )
        }

        fun rgbToHex(r: Int, g: Int, b: Int): String {
            var hex = r.toString(16).padStart(2, '0')
            hex += g.toString(16).padStart(2, '0')
            hex += b.toString(16).padStart(2, '0')
            return hex
        }

        fun hsvToRgb(h: Double, s: Double, v: Double): List<Int> {
            val ss = s/100
            val vs = v/100
            val c = vs * ss
            val x = c * (1 - abs((h / 60) % 2 - 1))
            val m = vs - c
            val (rp, gp, bp) = when {
                h < 60 -> Triple(c, x, 0.0)
                h < 120 -> Triple(x, c, 0.0)
                h < 180 -> Triple(0.0, c, x)
                h < 240 -> Triple(0.0, x, c)
                h < 300 -> Triple(x, 0.0, c)
                else -> Triple(c, 0.0, x)
            }
            val r = round(((rp + m) * 255)).toInt()
            val g = round(((gp + m) * 255)).toInt()
            val b = round(((bp + m) * 255)).toInt()
            return listOf(r, g, b)
        }

        fun cmykToRgb(c: Int, m: Int, y: Int, k: Int): List<Int> {
            val rp = 255 * (1 - c / 100.0) * (1 - k / 100.0)
            val gp = 255 * (1 - m / 100.0) * (1 - k / 100.0)
            val bp = 255 * (1 - y / 100.0) * (1 - k / 100.0)
            return listOf(round(rp).toInt(), round(gp).toInt(), round(bp).toInt())
        }

        private fun String.removeTrailingZeros(): String {
            return this.replace(Regex("\\.?0*$"), "")
        }
    }
}

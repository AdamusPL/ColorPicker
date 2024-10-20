package com.example.myapplication

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.activity.enableEdgeToEdge
import androidx.activity.viewModels
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Home
import androidx.compose.material3.BottomAppBar
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Text
import androidx.compose.material3.TopAppBar
import androidx.compose.material3.TopAppBarColors
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.tooling.preview.Preview
import com.example.myapplication.ui.components.Square
import com.example.myapplication.ui.components.TextFieldRow
import com.example.myapplication.ui.theme.MyApplicationTheme

class MainActivity : ComponentActivity() {
    private val viewModel: MainViewModel by viewModels()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        setContent {
            MyApplicationTheme {
                val rgbValues = viewModel.rgbFieldValues
                val hsvValues = viewModel.hsvFieldValues
                val cmykValues = viewModel.cmykFieldValues
                val hexValues = viewModel.hexFieldValues

                Scaffold(modifier = Modifier.fillMaxSize(),
                    topBar = { TopNavigationBar() },
                    bottomBar = { BottomNavigationBar() }) { innerPadding ->
                    Column (modifier = Modifier.padding(innerPadding)) {
                        Square(viewModel)
                        TextFieldRow(rgbValues, listOf("R", "G", "B"), viewModel)
                        TextFieldRow(hsvValues, listOf("H", "S", "V"), viewModel)
                        TextFieldRow(cmykValues, listOf("C", "M", "Y", "K"), viewModel)
                        TextFieldRow(hexValues, listOf("HEX"), viewModel)

                    }
                }
            }
        }
    }
}

@Composable
fun BottomNavigationBar() {
    BottomAppBar {
        Row(modifier = Modifier.fillMaxWidth(), horizontalArrangement = Arrangement.Center) {
            IconButton(onClick = { /* doSomething() */ }) {
                Icon(Icons.Filled.Home, contentDescription = "Home")
            }
            IconButton(onClick = { /* doSomething() */ }) {
                Icon(Icons.Filled.Home, contentDescription = "Home")
            }
        }
    }
}

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun TopNavigationBar() {
    TopAppBar(title = { Text("Color picker") })
}
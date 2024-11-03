package com.example.myapplication

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.activity.enableEdgeToEdge
import androidx.activity.viewModels
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.PaddingValues
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
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.navigation.NavHostController
import androidx.navigation.compose.NavHost
import androidx.navigation.compose.composable
import androidx.navigation.compose.rememberNavController
import com.example.myapplication.ui.components.ColorWheel
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
                val navController = rememberNavController()
                Scaffold(modifier = Modifier.fillMaxSize(),
                    topBar = { TopNavigationBar() },
                    bottomBar = { BottomNavigationBar(navController) }) { innerPadding ->
                    NavigationGraph(navController, viewModel, innerPadding)
                }
            }
        }
    }
}

@Composable
fun FirstScreen(viewModel : MainViewModel, innerPadding: PaddingValues) {
    Column (modifier = Modifier.padding(innerPadding)) {
        Square(viewModel)
        TextFieldRow(viewModel.rgbFieldValues, listOf("R", "G", "B"), viewModel, false)
        TextFieldRow(viewModel.hsvFieldValues, listOf("H", "S", "V"), viewModel, false)
        TextFieldRow(viewModel.cmykFieldValues, listOf("C", "M", "Y", "K"), viewModel, false)
        TextFieldRow(viewModel.hexFieldValues, listOf("HEX"), viewModel, false)
    }
}

@Composable
fun SecondScreen(viewModel: MainViewModel, innerPadding: PaddingValues){
    Column (modifier = Modifier.padding(innerPadding)) {
        ColorWheel(viewModel)
        TextFieldRow(viewModel.rgbFieldValues, listOf("R", "G", "B"), viewModel, true)
        TextFieldRow(viewModel.hsvFieldValues, listOf("H", "S", "V"), viewModel, true)
        TextFieldRow(viewModel.cmykFieldValues, listOf("C", "M", "Y", "K"), viewModel, true)
        TextFieldRow(viewModel.hexFieldValues, listOf("HEX"), viewModel, true)
    }
}

@Composable
fun BottomNavigationBar(navController : NavHostController) {
    BottomAppBar {
        Row(modifier = Modifier.fillMaxWidth(), horizontalArrangement = Arrangement.Center) {
            IconButton(onClick = { navController.navigate("first") }) {
                Icon(Icons.Filled.Home, contentDescription = "Home")
            }
            IconButton(onClick = { navController.navigate("second") }) {
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

@Composable
fun NavigationGraph(navController : NavHostController, viewModel: MainViewModel, innerPadding: PaddingValues) {
    NavHost(navController, startDestination = "first") {
        composable("first") { FirstScreen(viewModel, innerPadding) }
        composable("second") { SecondScreen(viewModel, innerPadding) }
    }
}
package com.example.myapplication

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.activity.enableEdgeToEdge
import androidx.activity.viewModels
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.PaddingValues
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Delete
import androidx.compose.material3.BottomAppBar
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Text
import androidx.compose.material3.TopAppBar
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableIntStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.unit.dp
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
    Column(
        modifier = Modifier
            .padding(innerPadding)
            .fillMaxSize()
    ) {
        Box(
            modifier = Modifier.weight(1f).fillMaxWidth(),
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
        TextFieldRow(viewModel.rgbFieldValues, listOf("R", "G", "B"), viewModel, true)
        TextFieldRow(viewModel.hsvFieldValues, listOf("H", "S", "V"), viewModel, true)
        TextFieldRow(viewModel.cmykFieldValues, listOf("C", "M", "Y", "K"), viewModel, true)
        TextFieldRow(viewModel.hexFieldValues, listOf("HEX"), viewModel, true)
    }
}

@Composable
fun BottomNavigationBar(navController: NavHostController) {
    var selectedIndex by remember { mutableIntStateOf(0) }

    BottomAppBar(
        containerColor = Color.White,
        contentColor = Color.Gray,
    ) {
        Row(
            modifier = Modifier.fillMaxWidth(),
            horizontalArrangement = Arrangement.SpaceAround
        ) {
            IconButton(
                modifier = Modifier.size(96.dp),
                onClick = {
                    selectedIndex = 0
                    navController.navigate("first") {
                        popUpTo("first") { inclusive = true }
                        launchSingleTop = true
                    }
                },
            ) {
                Column(
                    horizontalAlignment = Alignment.CenterHorizontally,
                ) {
                    Icon(
                        painter = painterResource(id = R.drawable.calculate),
                        contentDescription = "Konwerter",
                        tint = if (selectedIndex == 0) Color(0xFFFFC107) else Color.Gray,
                    )
                    Text(
                        text = "Konwerter",
                        color = if (selectedIndex == 0) Color(0xFFFFC107) else Color.Gray,
                    )
                }
            }
            IconButton(
                modifier = Modifier.size(96.dp),
                onClick = {
                    selectedIndex = 1
                    navController.navigate("second") {
                        popUpTo("second") { inclusive = true }
                        launchSingleTop = true
                    }
                },
            ) {
                Column(
                    horizontalAlignment = Alignment.CenterHorizontally,
                ) {
                    Icon(
                        painter = painterResource(id = R.drawable.palette),
                        contentDescription = "Paleta",
                        tint = if (selectedIndex == 1) Color(0xFFFFC107) else Color.Gray,
                    )
                    Text(
                        text = "Paleta",
                        color = if (selectedIndex == 1) Color(0xFFFFC107) else Color.Gray,
                    )
                }
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
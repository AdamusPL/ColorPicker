package com.example.myapplication.ui

import androidx.compose.foundation.layout.PaddingValues
import androidx.compose.runtime.Composable
import androidx.navigation.NavHostController
import androidx.navigation.compose.NavHost
import androidx.navigation.compose.composable
import com.example.myapplication.MainViewModel
import com.example.myapplication.ui.screens.FirstScreen
import com.example.myapplication.ui.screens.SecondScreen

@Composable
fun NavigationGraph(
    navController: NavHostController,
    viewModel: MainViewModel,
    innerPadding: PaddingValues
) {
    NavHost(navController, startDestination = "first") {
        composable("first") { FirstScreen(viewModel, innerPadding) }
        composable("second") { SecondScreen(viewModel, innerPadding) }
    }
}
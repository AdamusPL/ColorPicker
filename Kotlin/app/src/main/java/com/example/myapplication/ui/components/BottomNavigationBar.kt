package com.example.myapplication.ui.components

import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.size
import androidx.compose.material3.BottomAppBar
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.Text
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
import androidx.compose.ui.unit.sp
import androidx.navigation.NavHostController
import com.example.myapplication.R

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
                        fontSize = 12.sp
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
                        fontSize = 12.sp
                    )
                }
            }
        }
    }
}
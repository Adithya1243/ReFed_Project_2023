# Sankey Diagram for Farm Produce

## Overview
This Shiny app visualizes the distribution of farm produce through various stages from farms to the final consumer or surplus. It employs a Sankey diagram to depict the flow and quantity of produce that moves through various channels such as Manufacturing, Food Service, Retail, Residential, and Surplus.

## Features
- **Interactive Inputs**: Users can enter the total quantity of farm produce and adjust the percentages that flow into different channels.
- **Dynamic Sankey Diagram**: The Sankey diagram updates in real-time to reflect changes in the input values.
- **Predefined Values**: The `sankey_chart` file comes with predefined values in the text boxes, providing a default view of the produce distribution. Users can modify these values as needed to explore different scenarios.

## How to Use
1. **Adjust the Inputs**: The application allows you to modify the input values according to your data or scenario. You can enter the total quantity of farm produce and adjust the distribution percentages for different channels. The text boxes come with predefined values to give you an initial view of the distribution.
2. **View the Sankey Diagram**: Once you have entered or adjusted the values, the Sankey diagram on the right side of the app will automatically update to show the current distribution of the produce.
3. **Interact with the Diagram**: Hover over the links to see the quantity of the produce being distributed from one stage to the next.

## Installation
To run this Shiny app locally, you will need to have R and the following packages installed on your computer: `shiny`, `networkD3`, and `openxlsx`. If these packages are not already installed, you can do so using the following commands in R:

```R
install.packages("shiny")
install.packages("networkD3")
install.packages("openxlsx")

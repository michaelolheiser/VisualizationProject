import java.io.*;

Table table;            // Table to store the data
int currentIndex;       // Index to iterate over the rows
boolean animationDone;  // Flag to indicate if animation is complete

void setup() {
  size(400, 400);
  // Load the data from the CSV file
  table = loadTable("suicide_rates_usa.csv", "header");
  // Initialize variables
  currentIndex = 0;
  animationDone = false;

  // Set the frame rate for the animation
  frameRate(10);

}

void draw() {
  background(255);
  
  // Check if animation is complete
  if (currentIndex >= table.getRowCount()) {
    animationDone = true;
  }
  
  // Plot the data points up to the current index
  if (!animationDone) {
    plotDataPoints(currentIndex);
    currentIndex++;
  }
  
    if (animationDone) {
    plotDataPoints(18);
  }
  
  // Draw labels and values
  drawLabels();
}

void plotDataPoints(int endIndex) {
  // Set up variables for plotting
  float xInterval = (width - 200) / table.getRowCount();
  float yScale = (height-200) / getMaxRate();
    int grid = 10;

  // Plot each data point up to the specified end index
  for (int i = 0; i <= endIndex; i++) {
    TableRow row = table.getRow(i);
    int year = row.getInt("Year");
    float rate = row.getFloat("Rate");
    // Calculate the position of the data point
    float x = map(i, 0, table.getRowCount() - 1, 100, width - 100);
    float y = map(rate, 0, getMaxRate(), height + 100, 100);

    
    // Draw a circle at the data point
    noStroke();
    fill(255, 191, 0);
    ellipse(x, y, 11, 11);
    stroke(65,105,225);
    strokeWeight(5);
    line(80, height-180, width-80, height-180);
    line(80, height-180, 80, 80);

  }
}

void drawLabels() {
  // Draw the year label
  fill(0);
  PFont font;
  font = createFont("Gill Sans MT Bold", 32);
  textFont(font);
  textAlign(CENTER, BOTTOM);
  textSize(20);
  
  if (animationDone) {
    text("Year: 2019", width / 2, height - 150);
  } else {
    TableRow row = table.getRow(currentIndex - 1);
    int year = row.getInt("Year");
    text("Year: " + year, width / 2, height - 150);
  }
  
  // Draw the rate label
  textAlign(CENTER, TOP);
  textSize(18);
  
  if (animationDone) {
    TableRow row = table.getRow(table.getRowCount()-1);
    float rate = row.getFloat("Rate");
    text("Suicide Rate per 100K in the US: " + rate, width / 2, 50);
  } else {
    TableRow row = table.getRow(currentIndex - 1);
    float rate = row.getFloat("Rate");
    text("Suicide Rate per 100K in the US: " + rate, width / 2, 50);
  }
}

float getMaxRate() {
  // Find the maximum suicide rate in the data
  float maxRate = 0;
  
  for (int i = 0; i < table.getRowCount(); i++) {
    TableRow row = table.getRow(i);
    float rate = row.getFloat("Rate");
    
    if (rate > maxRate) {
      maxRate = rate;
    }
  }
  
  return maxRate;
}

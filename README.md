<p align="center">
  <img src="https://github.com/tushal13/spadview/assets/113960162/de2f24e2-1216-4743-9f8d-cb572716f81e" alt="SpandView Logo" />
</p>


<h1 align="center">SpandView Expense Tracke</h1>

<p align="center">
  <strong>Effortlessly track your daily expenses with a simple and intuitive Flutter app</strong>
</p>

## Overview

SpendView is a feature-rich expense management Flutter application designed to provide users with complete control over their finances. The app offers a user-friendly interface and a robust set of features for efficiently tracking expenses, setting and achieving savings goals, and gaining insights into spending patterns.

## Key Features

### Expense Tracking

- **Effortless Recording**: Record daily expenses with ease, providing a seamless experience for users to log transactions on the go.
  
- **Comprehensive Details**: Categorize transactions, add notes, and attach receipts for comprehensive record-keeping.

### Savings Goals

- **Goal Planning**: Plan for the future by setting savings goals. Users can define their objectives and track their progress over time.

- **Visual Progress**: Monitor savings goal progress with visual indicators and celebrate financial milestones.

### Interactive Charts

- **Visual Insights**: Gain insights into your financial health with interactive charts. Analyze spending patterns through visually appealing visualizations, helping users understand their financial habits.

- **Customization**: Users can customize charts to focus on specific time periods or expense categories.

### Categories

- **Organized Transactions**: Organize transactions by categorizing them into predefined or custom categories. The app provides a structured approach to financial management.

- **Category Insights**: Users can analyze spending patterns based on categories, helping them make informed decisions.

### Heatmap Calendar

- **Visualize Activities**: The Heatmap Calendar allows users to visualize spending activities on a color-coded calendar.

- **Identify Patterns**: Users can identify peak spending days and optimize their budget based on historical data.

### Animations

- **Smooth Transitions**: The app incorporates smooth animations for a delightful user experience.

- **Interactive Elements**: Animated buttons, transitions, and visual feedback enhance user engagement.

### PDF Summary

- **Export PDF Reports**: Users can generate and export PDF summaries of their financial data.

- **Customizable Reports**: Choose specific date ranges or categories for detailed and customizable PDF reports.

### PDF Summary

 - Personalize your avatar with random customization options.



## Technologies Used

- [Flutter](https://flutter.dev/): Google's UI toolkit for building natively compiled applications for mobile, web, and desktop from a single codebase.
  
- [Provider Package](https://pub.dev/packages/provider): State management for efficient communication between different components of the app.

- [SQFlite Database](https://pub.dev/packages/sqflite): Local database storage for persistent data management.

- [Fl_chart Package](https://pub.dev/packages/fl_chart): A Flutter charting library for visually appealing and customizable charts.

- [Shared Preferences](https://pub.dev/packages/shared_preferences): Light storage for user preferences.

- [HTTP Package](https://pub.dev/packages/http): Facilitates communication with external APIs.

- [Logger](https://pub.dev/packages/logger): A powerful logging package for detailed debugging and error tracking.

- [PDF Package](https://pub.dev/packages/pdf) and [Printing Package](https://pub.dev/packages/printing): Integration for generating and exporting PDF reports.

- Other Dependencies: 
- [`animated_bottom_navigation_bar`](https://pub.dev/packages/animated_bottom_navigation_bar): A customizable animated bottom navigation bar for Flutter.
  - [`percent_indicator`](https://pub.dev/packages/percent_indicator): Circular percent indicators for visualizing progress.
  - [`url_launcher`](https://pub.dev/packages/url_launcher): A Flutter plugin for launching URLs in the mobile platform.
  - [`google_fonts`](https://pub.dev/packages/google_fonts): A package to include Google Fonts in your Flutter app.
  - [`page_transition`](https://pub.dev/packages/page_transition): Beautiful page transition animations for Flutter apps.
  - [`simple_animations`](https://pub.dev/packages/simple_animations): Create custom animations using the AnimationController.
  - [`intl`](https://pub.dev/packages/intl): Provides internationalization and localization support.
  - [`fluentui_system_icons`](https://pub.dev/packages/fluentui_system_icons): Icons from the Fluent System.
  - [`loading_btn`](https://pub.dev/packages/loading_btn): A Flutter package for creating loading buttons.
  - [`animated_text_kit`](https://pub.dev/packages/animated_text_kit): A collection of Flutter widgets for animated text.
  - [`flutter_heatmap_calendar`](https://pub.dev/packages/flutter_heatmap_calendar): A Flutter package to display a heatmap calendar.
  - [`syncfusion_flutter_charts`](https://pub.dev/packages/syncfusion_flutter_charts): Data visualization library for Flutter with various chart types.
  - [`path_provider`](https://pub.dev/packages/path_provider): Provides a platform-agnostic way to find commonly used locations on the filesystem.
  - [`introduction_screen`](https://pub.dev/packages/introduction_screen): A Flutter package to build customizable introduction screens.
  - [`flutter_slidable`](https://pub.dev/packages/flutter_slidable): A Flutter package that provides a slideable widget.
  - [`awesome_dialog`](https://pub.dev/packages/awesome_dialog): A Flutter package for a customizable and flexible dialog.
  - [`flutter_launcher_icons`](https://pub.dev/packages/flutter_launcher_icons): A package for updating Flutter launcher icons.

## Directory Structure
 
📦 spendview_flutter_app                                                                                                                                         
 ┣ 📂 lib                                                                                                                                                        
 ┃ ┣ 📂 controller                                                                                                                                                
 ┃ ┃ ┣ 📜 api_controller.dart                                                                                                                                        
 ┃ ┃ ┣ 📜 category_controller.dart                                                                                                                                
 ┃ ┃ ┣ 📜 heatmap_controller.dart                                                                                                                                
 ┃ ┃ ┣ 📜 login_screen_controller.dart                                                                                                                               
 ┃ ┃ ┣ 📜 page_index_controller.dart                                                                                                                                
 ┃ ┃ ┣ 📜 savings_controller.dart                                                                                                                                
 ┃ ┃ ┣ 📜 transaction_controller.dart                                                                                                                                
 ┃ ┃ ┗ 📜 user_controller.dart                                                                                                                                       
 ┃ ┣ 📂 helper                                                                                                                                                       
 ┃ ┃ ┣ 📜 api_helper.dart                                                                                                                                            
 ┃ ┃ ┗ 📜 database_helper.dart                                                                                                                                       
 ┃ ┣ 📂 modal                                                                                                                                                        
 ┃ ┃ ┣ 📜 category_modal.dart                                                                                                                                
 ┃ ┃ ┣ 📜 chart_modal.dart                                                                                                                                
 ┃ ┃ ┣ 📜 saving_goal_modal.dart                                                                                                                                
 ┃ ┃ ┣ 📜 saving_modal.dart                                                                                                                                
 ┃ ┃ ┣ 📜 transaction_modal.dart                                                                                                                                
 ┃ ┃ ┗ 📜 user_modal.dart                                                                                                                                
 ┃ ┣ 📂 utility                                                                                                                                                   
 ┃ ┃ ┣ 📂 animation                                                                                                                                            
 ┃ ┃ ┃ ┣ 📜 fade_animation.dart                                                                                                                                
 ┃ ┃ ┃ ┗ 📜 loop_animation.dart                                                                                                                                
 ┃ ┃ ┗ 📜 color_list.dart                                                                                                                                
 ┃ ┣ 📂 views                                                                                                                                
 ┃ ┃ ┣ 📂 component                                                                                                                                
 ┃ ┃ ┃ ┣ 📜 saving_tile.dart                                                                                                                                
 ┃ ┃ ┃ ┣ 📜 saving_tile_2.dart                                                                                                                                
 ┃ ┃ ┃ ┣ 📜 setting_tile.dart                                                                                                                                
 ┃ ┃ ┃ ┗ 📜 tran_tile.dart                                                                                                                                
 ┃ ┃ ┣ 📂 screens                                                                                                                                
 ┃ ┃ ┃ ┣ 📜 add_transaction.dart                                                                                                                                
 ┃ ┃ ┃ ┣ 📜 history.dart                                                                                                                                
 ┃ ┃ ┃ ┣ 📜 home.dart                                                                                                                                
 ┃ ┃ ┃ ┣ 📜 intro1.dart                                                                                                                                
 ┃ ┃ ┃ ┣ 📜 intro2.dart                                                                                                                                
 ┃ ┃ ┃ ┣ 📜 intro3.dart                                                                                                                                
 ┃ ┃ ┃ ┣ 📜 login.dart                                                                                                                                
 ┃ ┃ ┃ ┣ 📜 monthly.dart                                                                                                                                
 ┃ ┃ ┃ ┣ 📜 recent.dart                                                                                                                                
 ┃ ┃ ┃ ┣ 📜 saving_goal.dart                                                                                                                                
 ┃ ┃ ┃ ┣ 📜 saving.dart                                                                                                                                
 ┃ ┃ ┃ ┣ 📜 sign.dart                                                                                                                                
 ┃ ┃ ┃ ┣ 📜 splash.dart                                                                                                                                
 ┃ ┃ ┃ ┗ 📜 week.dart                                                                                                                                
 ┃ ┣ 📜 main.dart                                                                                                                                
 ┗ 📜 .gitignore                                                                                                                                


The app follows the MVC (Model-View-Controller) pattern:

- **lib/controller:** Contains all the controller classes responsible for managing app logic.
- **lib/helper:** Includes helper classes such as API helpers and database helpers.
- **lib/modal:** Holds modal classes defining the structure of data objects.
- **lib/utility/animation:** Houses animation-related utility classes.
- **lib/views/component:** Custom widgets and components used across the app.
- **lib/views/screens:** Individual screens of the app.
- **lib/main.dart:** The entry point of the application.
- **lib/splash_screen.dart:** SplashScreen, the initial screen displayed when the app launches.

## Asset Files

- **assets/images:** Directory for storing image assets.

## Screen Reviews

### Home Screen

- The home screen provides a quick overview of recent transactions and savings goals.

### Analytics Screen

- The analytics screen displays interactive charts, allowing users to analyze their spending patterns.

### Saving Goals Screen

- Users can set and track their savings goals, ensuring better financial planning.

### Transactions Screen

- The transactions screen lists all logged expenses, providing details such as date, category, and amount.

### Profile Screen

- The profile screen allows users to view and edit their account information.

## Animation Enhancements

- The app incorporates subtle animations for a more engaging user experience.

## Custom Widgets

- Various custom widgets, such as `SavingTile`, `SettingTile`, and `TransactionTile`, enhance the UI.

## Utils

- Utility classes, including `FadeAnimation` and `LoopAnimation`, are utilized for animation effects.

## Directory Structure

- The app maintains a clear and organized directory structure, following best practices.

## Screenshots

<img src="https://github.com/tushal13/spadview/assets/113960162/0103bd95-b36b-4df6-9a70-f093bef2c27b" alt="Image" width="200"> 

<img src="https://github.com/tushal13/spadview/assets/113960162/ecc4cbf0-af48-4fc8-bbd5-1d937e56cd4b" alt="Image" width="200"> 

<img src="https://github.com/tushal13/spadview/assets/113960162/f65d29de-a514-428a-9c23-e58e88140b12" alt="Image" width="200"> 

<img src="https://github.com/tushal13/spadview/assets/113960162/d2ddb1fd-8541-4452-8145-6e72904a9479" alt="Image" width="200"> 

<img src="https://github.com/tushal13/spadview/assets/113960162/5c7bd2b7-1f60-4b9f-be10-cbbaa3ae95e1" alt="Image" width="200"> 

<img src="https://github.com/tushal13/spadview/assets/113960162/16d5acab-5335-48de-8cfc-92d0d05de434" alt="Image" width="200"> 

<img src="https://github.com/tushal13/spadview/assets/113960162/9a2f2f39-3bce-4805-a992-29f6b0fab8d8" alt="Image" width="200"> 

<img src="https://github.com/tushal13/spadview/assets/113960162/c2c58a50-fce5-4de5-b758-65a792aa41c0" alt="Image" width="200"> 

<img src="https://github.com/tushal13/spadview/assets/113960162/f4bb4199-faca-4a96-9cad-d97972bc0cd0" alt="Image" width="200"> 

<img src="https://github.com/tushal13/spadview/assets/113960162/c65aadb2-b8a3-4638-8564-9c7c891244ff" alt="Image" width="200"> 

<img src="https://github.com/tushal13/spadview/assets/113960162/e76f0858-0d6f-49a1-aeba-0e79dab69562" alt="Image" width="200"> 

<img src="https://github.com/tushal13/spadview/assets/113960162/56a4c3a9-02a6-4546-8ff0-d56f0f3cce96" alt="Image" width="200"> 

<img src="https://github.com/tushal13/spadview/assets/113960162/ec14d56d-4248-4f3c-a797-0089990c30d1" alt="Image" width="200"> 

<img src="https://github.com/tushal13/spadview/assets/113960162/325b5d75-d195-4636-a752-73b49a3c8db8" alt="Image" width="200"> 

<img src="https://github.com/tushal13/spadview/assets/113960162/d08df1e8-e9e8-4986-ad57-e9b6330a9392" alt="Image" width="200"> 

### [Video](https://drive.google.com/file/d/1RpXnE6GCQFlE8I-TD6sJicbWQS5rsGA2/view?usp=sharing)

## Getting Started

1. **Clone the repository:**
    ```bash
    git clone https://github.com/your-username/spendview_flutter.git
    cd spendview_flutter
    ```

2. **Install dependencies:**
    ```bash
    flutter pub get
    ```

3. **Run the app:**
    ```bash
    flutter run
    ```

## Avatar Customization

Explore SpendView's avatar customization feature to add a personal touch to your user profile.

## Logger Integration

SpendView employs the Logger package for detailed debugging and error tracking. View logs in the console or customize logging as needed.

```dart
// Example Usage
import 'package:logger/logger.dart';

final Logger logger = Logger();

void main() {
  logger.d('Debug message');
  logger.i('Information message');
  logger.e('Error message');
}
```

## Contributing

Contributions are welcome! Feel free to open issues, suggest improvements, or submit pull requests following our guidelines.

## License

SpendView is licensed under the MIT License. Refer to the [GT](LICENSE) file for details.

## Acknowledgments

We extend our gratitude to the Flutter community, contributors, and third-party libraries that contribute to the success of SpendView.

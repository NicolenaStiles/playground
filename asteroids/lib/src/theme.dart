import 'package:flutter/material.dart';
//import 'package:flutter_markdown/flutter_markdown.dart';

// Main content for website theme
ThemeData websiteTheme = ThemeData( 
  
  brightness: Brightness.dark,
  useMaterial3: true,
  scaffoldBackgroundColor: Colors.black,

  textTheme: const TextTheme(

    bodySmall: TextStyle(
      color: Colors.white,
      fontSize: 16,
      fontFamily: 'ProFontIIx',
      fontWeight: FontWeight.w400,
      height: 0,
    ),

    // Main body text
    bodyMedium: TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontFamily: 'ProFontIIx',
      fontWeight: FontWeight.w400,
      height: 0,
    ),

    // Desktop: used for blog entry labels
    labelMedium: TextStyle(
      color: Colors.grey,
      fontSize: 16,
      fontFamily: 'ProFontIIx',
      fontWeight: FontWeight.w400,
      height: 0,
    ),

    // Desktop: Header for blog entries
    titleMedium: TextStyle(
      color: Colors.white,
      fontSize: 24,
      fontFamily: 'ProFontIIx',
      fontWeight: FontWeight.w400,
      height: 0,
    ),

    // Desktop: Header for blog entries
    titleLarge: TextStyle(
      color: Colors.white,
      fontSize: 28,
      fontFamily: 'ProFontIIx',
      fontWeight: FontWeight.w400,
      height: 0,
    ),

    // Headline Elements
    headlineSmall: TextStyle(
      color: Colors.white,
      fontSize: 32,
      fontFamily: 'ProFontIIx',
      fontWeight: FontWeight.w400,
      height: 0,
    ),

    headlineMedium: TextStyle(
      color: Colors.white,
      fontSize: 36,
      fontFamily: 'ProFontIIx',
      fontWeight: FontWeight.w400,
      height: 0,
    ),

    headlineLarge: TextStyle(
      color: Colors.white,
      fontSize: 40,
      fontFamily: 'ProFontIIx',
      fontWeight: FontWeight.w400,
      height: 0,
    ),

    // Display Elements
    displaySmall: TextStyle(
      color: Colors.white,
      fontSize: 44,
      fontFamily: 'ProFontIIx',
      fontWeight: FontWeight.w400,
      height: 0,
    ),

    displayMedium: TextStyle(
      color: Colors.white,
      fontSize: 52,
      fontFamily: 'ProFontIIx',
      fontWeight: FontWeight.w400,
      height: 0,
    ),

    displayLarge: TextStyle(
      color: Colors.white,
      fontSize: 57,
      fontFamily: 'ProFontIIx',
      fontWeight: FontWeight.w400,
      height: 0,
    ),

  ),
);

// Markdown/blog post theme data
/*
MarkdownStyleSheet websiteMarkdown = MarkdownStyleSheet( 
  horizontalRuleDecoration: ShapeDecoration(
            color: Colors.black.withOpacity(1),
            shape: RoundedRectangleBorder( 
              side: BorderSide(width: 1, color: Color(0xFF00B8D4)),
            )
          ),
);
*/

/*

// TODO: Define an actual custom style-sheet

styleSheet: MarkdownStyleSheet(
  p: TextStyle(color: Colors.white, fontSize: 21),
  h1: TextStyle(color: Colors.white, fontSize: 48),
  h2: TextStyle(color: Colors.white, fontSize: 32),
  h3: TextStyle(color: Colors.white, fontSize: 24),
),
*/

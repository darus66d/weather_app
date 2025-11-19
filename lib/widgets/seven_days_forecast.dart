import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math';

class SevenDaysForecast extends StatefulWidget {
  final List<dynamic>? data; // ← API থেকে আসবে

  const SevenDaysForecast({super.key, this.data});

  @override
  State<SevenDaysForecast> createState() => _SevenDaysForecastState();
}

class _SevenDaysForecastState extends State<SevenDaysForecast> {
  final PageController _pageController = PageController(viewportFraction: 1/4);
  int currentPage = 0;

  // Random gradient generator (same style)
  List<Color> getRandomGradient() {
    final gradients = [
      [Color(0xff3d2c8e), Color(0xff533595)],
      [Color(0xff533595), Color(0xff9d52ac)],
      [Color(0xff9d52ac), Color(0xff3d2c8e)],
    ];

    return gradients[Random().nextInt(gradients.length)];
  }

  // Convert timestamp to weekday
  String getWeekDay(int timestamp) {
    DateTime date =
    DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    return ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"][date.weekday % 7];
  }

  // Weather icon mapping
  String getWeatherIcon(String iconCode) {
    if (iconCode.contains("d")) {
      return "assets/images/sun_rain.png";
    } else {
      return "assets/images/Moon_cloud_mid_rain.png";
    }
  }

  void _prev() {
    if (currentPage > 0) {
      currentPage--;
      _pageController.animateToPage(
        currentPage,
        duration: Duration(milliseconds: 280),
        curve: Curves.easeOut,
      );
    }
  }

  void _next() {
    if (currentPage < widget.data!.length - 1) {
      currentPage++;
      _pageController.animateToPage(
        currentPage,
        duration: Duration(milliseconds: 280),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.data == null) {
      return Center(
        child: Text(
          "Loading...",
          style: TextStyle(color: Colors.white),
        ),
      );
    }

    return Row(
      children: [
        SizedBox(width: 17),
        GestureDetector(
          onTap: _prev,
          child: Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
        ),
        SizedBox(width: 17),
        SizedBox(
          width: 300,
          height: 172,
          child: PageView.builder(
            controller: _pageController,
            padEnds: false,
            clipBehavior: Clip.none,
            itemCount: widget.data!.length,
            onPageChanged: (i) =>
                setState(() => currentPage = i),
            itemBuilder: (_, i) {
              final item = widget.data![i];

              String day = getWeekDay(item["dt"]);
              String temp = "${item["temp"]["day"].round()}°C";
              String iconCode = item["weather"][0]["icon"];
              String icon = getWeatherIcon(iconCode);

              List<Color> gradient = getRandomGradient();

              return FractionallySizedBox(
                widthFactor: 0.92,
                child: bottle(
                  gradient[0].value,
                  gradient[1].value,
                  null,
                  icon,
                  day,
                  temp,
                ),
              );
            },
          ),
        ),
        SizedBox(width: 17),
        GestureDetector(
          onTap: _next,
          child: Icon(Icons.arrow_forward_ios, color: Colors.white, size: 20),
        ),
        SizedBox(width: 17),
      ],
    );
  }

  Widget bottle(int? clr1, int? clr2, int? clr3,
      String img, String text1, String text2) {
    final List<Color> gradientColors = [];
    if (clr1 != null) gradientColors.add(Color(clr1));
    if (clr2 != null) gradientColors.add(Color(clr2));
    if (clr3 != null) gradientColors.add(Color(clr3));

    return Container(
      width: 82,
      height: 172,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: gradientColors,
        ),
      ),
      child: Column(
        children: [
          SizedBox(height: 26),
          Text(
            text1,
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
          Image.asset(img, width: 66, height: 66),
          Text(
            text2,
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
//
//
// class SevenDaysForecast extends StatefulWidget {
//   const SevenDaysForecast({super.key});
//
//   @override
//   State<SevenDaysForecast> createState() => _SevenDaysForecastState();
// }
//
// class _SevenDaysForecastState extends State<SevenDaysForecast> {
//
//   final PageController _pageController = PageController(viewportFraction: 1/4);
//   int currentPage = 0;
//   final List<Map<String,dynamic>> forecast =[
//     {"day":"Mon","temp":"19°C","icon":"assets/images/sun_rain.png","c1":0xff3d2c8e,"c2":0xff533595,"c3":null},
//     {"day":"Tue","temp":"19°C","icon":"assets/images/Moon_cloud_mid_rain.png","c1":0xff3d2c8e,"c2":0xff533595,"c3":null},
//     {"day":"Wed","temp":"19°C","icon":"assets/images/Moon_cloud_mid_rain.png","c1":0xff3d2c8e,"c2":0xff533595,"c3":null},
//     {"day":"Thu","temp":"19°C","icon":"assets/images/sun_rain.png","c1":0xff3d2c8e,"c2":0xff533595,"c3":null},
//     {"day":"Fri","temp":"19°C","icon":"assets/images/sun_rain.png","c1":0xff3d2c8e,"c2":0xff533595,"c3":null},
//     {"day":"Sat","temp":"19°C","icon":"assets/images/Moon_cloud_mid_rain.png","c1":0xff3d2c8e,"c2":0xff533595,"c3":null},
//     {"day":"Sun","temp":"19°C","icon":"assets/images/Moon_cloud_mid_rain.png","c1":0xff3d2c8e,"c2":0xff533595,"c3":null},
//   ];
//   void _prev(){
//     if(currentPage >0){
//       currentPage --;
//       _pageController.animateToPage(
//           currentPage,
//           duration: Duration(milliseconds: 280),
//           curve: Curves.easeOut);
//     }
//   }
//
//   void _next(){
//     if(currentPage < forecast.length -1 ){
//       currentPage++;
//       _pageController.animateToPage(
//           currentPage,
//           duration: Duration(milliseconds: 280),
//           curve: Curves.easeOut);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         SizedBox(width: 17,),
//         GestureDetector(
//           onTap: _prev,
//           child: Icon(Icons.arrow_back_ios_new,color: Colors.white,size: 20 ),
//         ),
//         SizedBox(width: 17,),
//         SizedBox(
//           width: 300,
//           height: 172,
//           child: PageView.builder(
//             controller: _pageController,
//               padEnds: false,
//               clipBehavior: Clip.none,
//               itemCount: forecast.length,
//               onPageChanged: (i) =>setState(() =>currentPage=1),
//               itemBuilder:(_, i) {
//               final it = forecast[i];
//               return FractionallySizedBox(
//                 widthFactor: 0.92,
//                 child: bottle(it["c1"],it["c2"],it["c3"],it["icon"],it["day"],it["temp"]),
//               );
//           }),
//         ),
//         SizedBox(width: 17,),
//         GestureDetector(
//           onTap: _next,
//           child: Icon(
//             Icons.arrow_forward_ios,
//             color: Colors.white,
//             size: 20,
//           ),
//         ),
//         SizedBox(width: 17,),
//       ],
//     );
//   }
//
//   Widget bottle (int? clr1, int? clr2,int? clr3,String img,String text1, String text2){
//     final List<Color> gradientColors = [];
//     if(clr1 != null) gradientColors.add(Color(clr1));
//     if(clr2 != null) gradientColors.add(Color(clr2));
//     if(clr3 != null) gradientColors.add(Color(clr3));
//
//     return Container(
//       width: 82,
//       height: 172,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(50),
//         gradient: LinearGradient(
//           begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: gradientColors)
//       ),
//       child: Column(
//         children: [
//           SizedBox(height: 26,),
//           Text(
//             text1,
//             style: GoogleFonts.poppins(
//               fontSize: 20,
//               fontWeight: FontWeight.w500,
//               color: Color(0xffffffff),
//             ),
//           ),
//           Image.asset(img,width: 66,height: 66,),
//           Text(
//             text2,
//             style: GoogleFonts.poppins(
//               fontSize: 20,
//               fontWeight: FontWeight.w500,
//               color: Color(0xffffffff),
//             ),
//           )
//         ],
//       ),
//     );
//   }
//   }

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:softagi/modules/login/login_page.dart';
import 'package:softagi/modules/login/login_page.dart';
import 'package:softagi/shared/components/network/cache.dart';

class PageOrder extends StatefulWidget {
  PageOrder({Key? key}) : super(key: key);

  @override
  State<PageOrder> createState() => _PageOrderState();
}

class _PageOrderState extends State<PageOrder> {
  var PageOrderController = PageController();

  List<ModelPageOreder> model = [
    ModelPageOreder(
        img: 'assets/images/animations/order2.json',
        title: 'Screen 1',
        body: 'body 1'),
    ModelPageOreder(
        img: 'assets/images/animations/oreder1.json',
        title: 'Screen 2',
        body: 'body 2'),
    ModelPageOreder(
        img: 'assets/images/animations/order4.json',
        title: 'Screen 3',
        body: 'body 3'),
  ];
  void submit() {
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
      if (value ?? true) {
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (_) => LoginPage()));
      }
    });
  }

  bool isLast = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () {
                submit();
              },
              child: Text(
                'SKIP',
                style: TextStyle(
                    color: Colors.deepOrange, fontWeight: FontWeight.bold),
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                  onPageChanged: (int index) {
                    if (index == model.length - 1) {
                      setState(() {
                        isLast = true;
                      });
                    } else {
                      setState(() {
                        isLast = false;
                      });
                    }
                  },
                  controller: PageOrderController,
                  itemCount: 3,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) => buildBoardingItem(
                        model: model[index],
                      )),
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: PageOrderController,
                  count: model.length,
                  effect: ExpandingDotsEffect(
                      activeDotColor: Colors.deepOrange,
                      dotColor: Colors.grey,
                      dotHeight: 10,
                      expansionFactor: 4,
                      dotWidth: 10,
                      spacing: 5),
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast) {
                      submit();
                    } else {
                      PageOrderController.nextPage(
                          duration: Duration(
                            milliseconds: 750,
                          ),
                          curve: Curves.fastLinearToSlowEaseIn);
                    }
                  },
                  child: const Icon(Icons.arrow_forward_ios),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class buildBoardingItem extends StatelessWidget {
  ModelPageOreder? model;
  buildBoardingItem({Key? key, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Expanded(child: Image(image: AssetImage('${model!.img ?? ''}'))),
        Expanded(child: Lottie.asset('${model!.img ?? ''}')),

        SizedBox(height: 30),
        Text(
          '${model!.title ?? ''}',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Text(
          '${model!.body ?? ''}',
          style: TextStyle(fontSize: 15),
        ),
        // Row(
        //   children: [
        //     Text('Indicator'),
        //     Spacer(),
        //     FloatingActionButton(
        //       onPressed: () {},
        //       child: Icon(
        //         Icons.arrow_forward_ios,
        //       ),
        //     )
        //   ],
        // )
      ],
    );
  }
}

class ModelPageOreder {
  String? img;
  String? title;
  String? body;
  ModelPageOreder({this.img, this.title, this.body});
}

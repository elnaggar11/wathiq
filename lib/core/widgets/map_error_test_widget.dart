import 'package:flutter/material.dart';
import 'package:wathiq/core/widgets/map_error_widget.dart';

class MapErrorTestWidget extends StatefulWidget {
  const MapErrorTestWidget({super.key});

  @override
  State<MapErrorTestWidget> createState() => _MapErrorTestWidgetState();
}

class _MapErrorTestWidgetState extends State<MapErrorTestWidget> {
  MapErrorType? currentErrorType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('اختبار معالجة أخطاء الخريطة'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // أزرار الاختبار
          Container(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'اختر نوع الخطأ لاختباره:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16),
                _buildTestButton('لا يوجد موقع متاح', MapErrorType.noLocation),
                _buildTestButton(
                    'مشكلة في مفتاح الخرائط', MapErrorType.apiKeyError),
                _buildTestButton('مشكلة في الشبكة', MapErrorType.networkError),
                _buildTestButton(
                    'مشكلة في الصلاحيات', MapErrorType.permissionError),
                _buildTestButton('خطأ عام', MapErrorType.generalError),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      currentErrorType = null;
                    });
                  },
                  child: Text('إعادة تعيين'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
          ),

          // عرض الخطأ المختار
          Expanded(
            child: currentErrorType != null
                ? MapErrorWidget(
                    errorType: currentErrorType!,
                    errorMessage: currentErrorType == MapErrorType.generalError
                        ? 'هذا خطأ تجريبي لاختبار معالجة الأخطاء'
                        : null,
                    onRetry: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('تم الضغط على إعادة المحاولة'),
                          backgroundColor: Colors.blue,
                        ),
                      );
                    },
                    onOpenSettings:
                        currentErrorType == MapErrorType.permissionError
                            ? () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('سيتم فتح إعدادات التطبيق'),
                                    backgroundColor: Colors.orange,
                                  ),
                                );
                              }
                            : null,
                  )
                : Container(
                    color: Colors.grey[100],
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.map,
                            size: 64,
                            color: Colors.grey[600],
                          ),
                          SizedBox(height: 16),
                          Text(
                            'اختر نوع خطأ من القائمة أعلاه لاختباره',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[600],
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildTestButton(String title, MapErrorType errorType) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            currentErrorType = errorType;
          });
        },
        child: Text(title),
        style: ElevatedButton.styleFrom(
          backgroundColor:
              currentErrorType == errorType ? Colors.blue : Colors.grey[300],
          foregroundColor:
              currentErrorType == errorType ? Colors.white : Colors.black87,
        ),
      ),
    );
  }
}

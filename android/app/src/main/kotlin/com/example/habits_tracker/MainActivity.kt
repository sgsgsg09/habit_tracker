package com.example.habits_tracker

import android.appwidget.AppWidgetManager
import android.content.ComponentName
import android.content.Intent
import android.os.Bundle
import android.util.Log
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {

    // flutterEngine 인스턴스를 저장할 변수 추가
    private lateinit var flutterEngineInstance: FlutterEngine

    // 채널 이름들
    private val UPDATE_WIDGET_CHANNEL = "com.example.habits_tracker/update_widget"
    private val WIDGET_ACTION_CHANNEL = "com.example.habits_tracker/widget_action"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        // flutterEngine 저장
        flutterEngineInstance = flutterEngine

        // 위젯 업데이트 채널 설정
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, UPDATE_WIDGET_CHANNEL)
            .setMethodCallHandler { call, result ->
                if (call.method == "updateWidget") {
                    updateWidget()
                    result.success(null)
                } else {
                    result.notImplemented()
                }
            }
            
        // 위젯 액션 채널 설정 (Flutter에서 처리할 수 있도록)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, WIDGET_ACTION_CHANNEL)
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        // 위젯에서 앱이 실행된 경우의 인텐트 처리
        handleIntent(intent)
    }

    // 앱이 이미 실행 중일 때, 새로운 인텐트를 받을 경우도 처리
    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)
        handleIntent(intent)
    }

    // 인텐트 처리 메서드
    private fun handleIntent(intent: Intent?) {
        if (intent?.action == "com.example.habits_tracker.CALL_FLUTTER_METHOD") {
    val methodName = intent.getStringExtra("METHOD") ?: return
    val habitTitle = intent.getStringExtra("HABIT_TITLE") ?: return
    
    // MethodChannel을 사용하여 Flutter 호출
    MethodChannel(flutterEngineInstance.dartExecutor.binaryMessenger, WIDGET_ACTION_CHANNEL)
        .invokeMethod(methodName, mapOf("title" to habitTitle))
}
    }

    // 위젯 업데이트 메서드
    private fun updateWidget() {
        val appWidgetManager = AppWidgetManager.getInstance(applicationContext)
        val componentName = ComponentName(applicationContext, TaskWidgetProvider::class.java)
        val appWidgetIds = appWidgetManager.getAppWidgetIds(componentName)

        // 위젯 리스트 뷰 갱신 요청
        appWidgetManager.notifyAppWidgetViewDataChanged(appWidgetIds, R.id.task_list_view)

        // 위젯 갱신을 위한 인텐트 브로드캐스트 전송
        val intent = Intent(applicationContext, TaskWidgetProvider::class.java).apply {
            action = AppWidgetManager.ACTION_APPWIDGET_UPDATE
            putExtra(AppWidgetManager.EXTRA_APPWIDGET_IDS, appWidgetIds)
        }
        sendBroadcast(intent)
    }
}


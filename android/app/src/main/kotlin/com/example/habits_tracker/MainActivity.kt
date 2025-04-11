package com.example.habits_tracker

import android.appwidget.AppWidgetManager
import android.content.ComponentName
import android.content.Intent
import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.example.habits_tracker/update_widget"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
            .setMethodCallHandler { call, result ->
                if (call.method == "updateWidget") {
                    // Widget을 갱신하라는 메시지를 받으면 실행
                    updateWidget()
                    result.success(null)
                } else {
                    result.notImplemented()
                }
            }
    }

    private fun updateWidget() {
        // 위젯의 데이터를 갱신하는 부분
        val appWidgetManager = AppWidgetManager.getInstance(applicationContext)

        // 이 부분에서 현재 앱에 설정된 모든 해당 위젯 ID를 가져온다
        val componentName = ComponentName(applicationContext, TaskWidgetProvider::class.java)
        val appWidgetIds = appWidgetManager.getAppWidgetIds(componentName)

        // 위젯 리스트 뷰가 갱신되도록 알림
        appWidgetManager.notifyAppWidgetViewDataChanged(appWidgetIds, R.id.task_list_view)

        // 브로드캐스트를 보내서 onUpdate()가 호출되도록 유도
        val intent = Intent(applicationContext, TaskWidgetProvider::class.java).apply {
            action = AppWidgetManager.ACTION_APPWIDGET_UPDATE
            putExtra(AppWidgetManager.EXTRA_APPWIDGET_IDS, appWidgetIds)
        }
        sendBroadcast(intent)
    }
}
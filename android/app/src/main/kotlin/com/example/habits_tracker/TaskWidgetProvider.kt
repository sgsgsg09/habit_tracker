package com.example.habits_tracker

import android.app.PendingIntent
import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.ComponentName
import android.content.Context
import android.content.Intent
import android.util.Log
import android.widget.RemoteViews
import org.json.JSONArray
import android.view.View
class TaskWidgetProvider : AppWidgetProvider() {
    private val TAG = "TaskWidgetProvider"

    // 위젯 업데이트 시 호출되는 메서드
    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray
    ) {
        Log.d(TAG, "onUpdate called with appWidgetIds: ${appWidgetIds.joinToString()}")

        // 각 위젯 인스턴스에 대해 개별 업데이트 처리
        for (appWidgetId in appWidgetIds) {
            updateWidget(context, appWidgetManager, appWidgetId)
        }
    }

   // 각 위젯의 레이아웃 및 데이터를 업데이트하는 메서드
    private fun updateWidget(context: Context, appWidgetManager: AppWidgetManager, appWidgetId: Int) {
        Log.d(TAG, "updateWidget called for widget ID: $appWidgetId")
        val views = RemoteViews(context.packageName, R.layout.widget_layout)

        // SharedPreferences에서 모든 습관 데이터를 읽어옵니다.
        val prefs = context.getSharedPreferences("FlutterSharedPreferences", Context.MODE_PRIVATE)
        val tasksString = prefs.getString("flutter.tasks", "") ?: ""
        var tasksJSONArray: JSONArray? = null

        if (tasksString.isNotEmpty()) {
            try {
                tasksJSONArray = JSONArray(tasksString)
            } catch (e: Exception) {
                Log.e(TAG, "Error parsing tasks JSON", e)
            }
        }

        // 데이터가 존재하면 전체 습관(완료 여부와 관계없이)을 리스트에 표시하도록 RemoteViewsAdapter 설정
        if (tasksJSONArray != null) {
            // TaskWidgetService가 RemoteViewsFactory를 구현하여 SharedPreferences에서 읽은 데이터를 사용하게 됩니다.
            val serviceIntent = Intent(context, TaskWidgetService::class.java)
            views.setRemoteAdapter(R.id.task_list_view, serviceIntent)
            views.setEmptyView(R.id.task_list_view, R.id.empty_view)
        } else {
            // 데이터가 없을 경우 빈 뷰를 표시
            views.setViewVisibility(R.id.task_list_view, View.GONE)
            views.setViewVisibility(R.id.empty_view, View.VISIBLE)
            views.setTextViewText(R.id.empty_view, "No tasks available")
        }

        // 리스트 아이템 클릭 시 실행될 브로드캐스트 리시버 (WidgetActionReceiver)를 위한 pendingIntent 설정
        val clickIntent = Intent(context, WidgetActionReceiver::class.java).apply {
            action = "com.example.habits_tracker.INCREMENT_HABIT"
        }
        val clickPendingIntent = PendingIntent.getBroadcast(
            context,
            0,
            clickIntent,
            PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_MUTABLE
        )
        views.setPendingIntentTemplate(R.id.task_list_view, clickPendingIntent)

        // 위젯 업데이트
        appWidgetManager.updateAppWidget(appWidgetId, views)

        
    }

    // 브로드캐스트를 수신할 때 호출되며, 특정 액션에 따른 추가 동작을 수행합니다.
    override fun onReceive(context: Context?, intent: Intent?) {
        super.onReceive(context, intent)

        // "com.example.habits_tracker.UPDATE_WIDGET" 액션을 통해 위젯 업데이트를 트리거하는 경우
        if (intent?.action == "com.example.habits_tracker.UPDATE_WIDGET") {
            Log.d(TAG, "Received custom action to update widget")

            val appWidgetManager = AppWidgetManager.getInstance(context)
            val componentName = ComponentName(context!!, TaskWidgetProvider::class.java)
            val appWidgetIds = appWidgetManager.getAppWidgetIds(componentName)

            // 모든 위젯 인스턴스에 대해 업데이트 로직 호출
            for (appWidgetId in appWidgetIds) {
                updateWidget(context, appWidgetManager, appWidgetId)
            }

            // ListView의 데이터가 즉각적으로 갱신되도록 위젯 매니저에 알림
            appWidgetManager.notifyAppWidgetViewDataChanged(appWidgetIds, R.id.task_list_view)
        }
    }
}